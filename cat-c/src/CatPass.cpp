#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Type.h"
#include "llvm/Pass.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include <algorithm>
#include <map>
#include <set>
#include <string>
#include <vector>

using namespace llvm;
using namespace std;
namespace {

struct CAT : public FunctionPass {
  static char ID;
  map<Instruction *, set<Instruction *>> gen;
  map<Instruction *, set<Instruction *>> kill;

  map<Value *, set<Instruction *>> var_to_inst;

  map<Instruction *, set<Instruction *>> in;
  map<Instruction *, set<Instruction *>> out;
  map<Instruction *, set<Instruction *>> prev_out;

  CAT() : FunctionPass(ID) {}

  // This function is invoked once at the initialization phase of the compiler
  // The LLVM IR of functions isn't ready at this point
  bool doInitialization(Module &M) override {

    // errs() << "Hello LLVM World at \"doInitialization\"\n" ;
    return false;
  }

  // This function is invoked once per function compiled
  // The LLVM IR of the input functions is ready and it can be analyzed and/or
  // transformed
  bool runOnFunction(Function &F) override {
    // errs() << F;
    gen = {};
    kill = {};
    var_to_inst = {};
    in = {};
    out = {};

    for (auto &b : F) {

      for (auto &inst : b) {
        if (!isa<Instruction>(&inst)) {
          continue;
        }

        Instruction *i = cast<Instruction>(&inst);

        string name = "";
        CallInst *callinst;

        if (isa<CallInst>(*i)) {
          callinst = cast<CallInst>(i);
          name = callinst->getCalledFunction()->getName().str();
        }

        if (name == "CAT_new" || name == "CAT_set" || name == "CAT_add" ||
            name == "CAT_sub") {
          set<Instruction *> newgen = {i};
          gen.insert({i, newgen});
          Value *argValue;
          if (isa<ReturnInst>(i) ||
              (isa<CallInst>(i) && callinst->arg_size() == 1)) {
            argValue = dyn_cast<Value>(callinst);
          } else {
            argValue = i->getOperand(0);
          }

          if (var_to_inst.find(argValue) == var_to_inst.end()) {
            set<Instruction *> newset = {i};
            var_to_inst.insert({argValue, newset});
          } else {
            var_to_inst[argValue].insert(i);
          }
        } else {
          set<Instruction *> newgen = {};
          gen.insert({i, newgen});
        }
      }
    }

    for (map<Value *, set<Instruction *>>::iterator it = var_to_inst.begin();
         it != var_to_inst.end(); ++it) {
      if (it->second.size() > 1) {
        for (Instruction *inst : it->second) {
          for (Instruction *inst2 : it->second) {
            if (inst != inst2) {
              kill[inst].insert(inst2);
            }
          }
        }
      }
    }
    prev_out = {};
    do {

      prev_out = out;

      for (auto &b : F) {
        Instruction *last = NULL;

        for (auto &inst : b) {
          if (!isa<Instruction>(&inst)) {
            continue;
          }

          Instruction *i = cast<Instruction>(&inst);

          if (in.find(i) == in.end()) {
            set<Instruction *> newgen = {};
            in.insert({i, newgen});
          }

          if (out.find(i) == out.end()) {
            set<Instruction *> newgen = {};
            out.insert({i, newgen});
          }

          if (last != NULL) {
            for (auto &insert : out[last]) {
              in[i].insert(insert);
            }
          }

          for (auto &insert : gen[i]) {
            out[i].insert(insert);
          }

          for (auto &insert : in[i]) {
            out[i].insert(insert);
          }

          for (auto &remove : kill[i]) {
            out[i].erase(remove);
          }

          last = i;
        }
      }

      for (auto &b : F) {
        Instruction *last = NULL;

        for (auto p : predecessors(&b)) {

          last = p->getTerminator();

          for (auto &inst : b) {

            if (!isa<Instruction>(&inst)) {
              continue;
            }

            Instruction *i = cast<Instruction>(&inst);

            if (in.find(i) == in.end()) {
              set<Instruction *> newgen = {};
              in.insert({i, newgen});
            }

            if (out.find(i) == out.end()) {
              set<Instruction *> newgen = {};
              out.insert({i, newgen});
            }

            if (last != NULL) {
              for (auto &insert : out[last]) {
                in[i].insert(insert);
              }
            }

            for (auto &insert : gen[i]) {
              out[i].insert(insert);
            }

            for (auto &insert : in[i]) {
              out[i].insert(insert);
            }

            for (auto &remove : kill[i]) {
              out[i].erase(remove);
            }

            last = i;
          }
        }
      }

    } while (prev_out != out);

    map<BasicBlock *, map<Instruction *, Value *>> globalconstants = {};
    map<BasicBlock *, map<Instruction *, Value *>> globalkilled = {};
    map<BasicBlock *, set<BasicBlock* >> loopToBlocks = {};
    map<BasicBlock *, set<Value* >> loopToBadConstants = {};
    set<BasicBlock *> loopBlocks = {};
    queue<BasicBlock *> q = {};
    set<BasicBlock *> visited = {};

    for (auto &b : F) {
      q.push(&b);
      break;
    }

    for (auto &b : F) {
      set <BasicBlock *> visited2 = {};
      queue<BasicBlock *> q2 = {};
      for (auto *bn : predecessors(&b))
        q2.push(bn);
      while (q2.size() > 0) {
        BasicBlock *b2 = q2.front();
        q2.pop();
        if (visited2.find(b2) != visited2.end())
          continue;
        visited2.insert(b2);
        for (auto *bn : predecessors(b2))
          q2.push(bn);
        if (b2 == &b) {
          loopBlocks.insert(&b);
          break;
        }
      }
    }
    // print loopBlocks
    errs() << "\nloopBlocks\n";
    for (auto &b: loopBlocks){
      errs() << *b << " ";
    }

    for (auto& b: loopBlocks){
      queue<BasicBlock *> preds = {};
      set<BasicBlock *> visited3 = {};
      queue<BasicBlock *> succs = {};
      set<BasicBlock *> visited4 = {};
      for (auto *bn : predecessors(b))
          preds.push(bn);
      for (auto *bn : successors(b))
          succs.push(bn);
      
      while (preds.size() > 0) {
        BasicBlock *b2 = preds.front();
        preds.pop();
        if (visited3.find(b2) != visited3.end())
          continue;
        bool leaves = false;
        set<BasicBlock* > toPush = {};
        visited3.insert(b2);
        for (auto *bn : predecessors(b2)) {
          if (loopBlocks.find(bn) == loopBlocks.end()) {
            leaves = true;
          }
          toPush.insert(bn);
        }
        if (!leaves) {
          for (auto &block : toPush) {
            preds.push(block);
          }
        }
      }

      while (succs.size() > 0) {
        BasicBlock *b2 = succs.front();
        succs.pop();
        if (visited4.find(b2) != visited4.end())
          continue;
        bool leaves = false;
        set<BasicBlock* > toPush = {};
        visited4.insert(b2);
        for (auto *bn : successors(b2)) {
          if (loopBlocks.find(bn) == loopBlocks.end()) {
            leaves = true;
          }
          toPush.insert(bn);
        }
        if (!leaves) {
          for (auto &block : toPush) {
            succs.push(block);
          }
        }
      }

      while (succs.size() > 0) {
        BasicBlock *b2 = succs.front();
        succs.pop();
        preds.push(b2);
      }
      set<BasicBlock* > temp = {};
      loopToBlocks.insert({b, temp});
      while(preds.size() > 0) {

        BasicBlock *b2 = preds.front();
        preds.pop();
        loopToBlocks[b].insert(b2);
      }
    
    }
    //print loopToBlock
    errs() << "loopToBlock ****\n";
    for (auto &b: loopToBlocks){
      errs() << b.first << " : ";
      for (auto &bn: b.second){
        errs() << *bn << " ";
      }
      errs() << "\n";
    }
    
    for (auto &pair : loopToBlocks){
      BasicBlock *b = pair.first;
      set<Value *> temp = {};
      loopToBadConstants.insert({b, temp});
      for (auto& inst : *b) {
          if (isa<CallInst>(inst)) {
            CallInst *cinst = &(cast<CallInst>(inst));
            Value *vinst = cinst->getOperand(0);
            for (int i = 1; i < cinst->arg_size(); i++) {
              if (vinst == cinst->getOperand(i)) {
                loopToBadConstants[b].insert(vinst);
                break;
              }
            }
          }
        }
    }


    BasicBlock *first = q.front();

    while (q.size() > 0) {
      BasicBlock *b = q.front();
      q.pop();
      if (visited.find(b) != visited.end())
        continue;
      visited.insert(b);
      for (auto *bn : successors(b))
        q.push(bn);

      map<Instruction *, Value *> constants = {};
      set<Value *> falseFinds = {};

      for (BasicBlock *pred : predecessors(b)) {
        errs() << pred << "basicblock";
        if (globalconstants.find(pred) == globalconstants.end()) {
          continue;
        }
        for (const auto &map : globalconstants[pred]) {

          Value *flag = NULL;
          Value *constantval = map.second;

          CallInst *calli = cast<CallInst>(map.first);
          Value *constop = (calli->arg_size() == 1) ? calli->getOperand(0)
                                                    : calli->getOperand(1);

          if (constantval == NULL) {
            constantval = cast<Value>(map.first);
          }

          Value *current;

          for (const auto &constant : constants) {

            Value *constantval2 = constant.second;
            current = constantval2;
            if (constantval2 == NULL) {
              constantval2 = cast<Value>(constant.first);
            }

            if (constantval2 == constantval) {
              CallInst *calli2 = cast<CallInst>(constant.first);
              flag = (calli2->arg_size() == 1) ? calli2->getOperand(0)
                                               : calli2->getOperand(1);
              break;
            }
          }

          if (flag != NULL) {
            if (cast<ConstantInt>(constop)->getSExtValue() !=
                cast<ConstantInt>(flag)->getSExtValue()) {
              falseFinds.insert(constantval);
              errs() << "\n found bad: ";
              map.first->print(errs());
              flag->print(errs());
              errs() << "\n";
            } else {
              constants.insert({map.first, map.second});
            }
          } else {
            constants.insert({map.first, map.second});
          }
        }
      }

      

      if (loopToBlocks.find(b) != loopToBlocks.end()) {
        for (auto &inst : *b) {
          Value * vinst = cast<Value>(&inst);
          for (auto &bn: loopToBlocks[b]){
            if (loopToBadConstants[bn].find(vinst) != loopToBadConstants[bn].end()){
              falseFinds.insert(vinst);
              break;
            }
          }
        }
      }

      for (BasicBlock *pred : predecessors(b)) {
        for (const auto &map : globalkilled[pred]) {
          Value *flag = NULL;
          Value *constantval = map.second;

          CallInst *calli = cast<CallInst>(map.first);

          if (constantval == NULL) {
            constantval = cast<Value>(map.first);
          }
          bool found = false;
          for (const auto &map2 : globalconstants[pred]) {
            Value *flag = NULL;
            Value *constantval2 = map2.second;

            CallInst *calli2 = cast<CallInst>(map2.first);

            if (constantval2 == NULL) {
              constantval2 = cast<Value>(map2.first);
            }

            if (constantval == constantval2) {
              found = true;
            }
          }
          if (!found) {
            falseFinds.insert(constantval);
          }
        }
      }

      set<Instruction *> eraseQ = {};

      for (auto const &inst : constants) {
        Value *constantval = inst.second;
        if (constantval == NULL) {
          constantval = cast<Value>(inst.first);
        }
        for (auto &v : falseFinds) {
          if (v == constantval) {
            eraseQ.insert(inst.first);
          }
        }
      }

      for (auto &inst : eraseQ) {
        errs() << "REMOVED\n\n";
        inst->print(errs());
        errs() << constants.size() << "->";
        constants.erase(inst);
        errs() << constants.size();
      }

      map<Instruction *, Value *> changes = {};
      map<Value *, Value *> operandReplacement = {};

      errs() << "\nconstant";
      for (auto &consta : constants) {
        consta.first->print(errs());
        errs() << consta.second;
        errs() << "\n";
      }
      errs() << "----\n";
      errs() << b;
      errs() << "endconstant\n";
      map<CallInst *, map<int, ConstantInt *>> operandChanges = {};

      for (auto &inst : *b) {
        bool found = false;
        if (isa<PHINode>(inst)) {
          errs() << "phiNode\n";
          PHINode *phi = cast<PHINode>(&inst);
          for (unsigned i = 0, e = phi->getNumIncomingValues(); i != e; ++i) {
            Value *incomingValue = phi->getIncomingValue(i);
            errs() << "incomingvalue\n";
            incomingValue->print(errs());
            errs() << "\n";
            // BasicBlock *incomingBlock = phi->getIncomingBlock(i);
            for (auto const &constant : constants) {
              Instruction *constantinst = constant.first;
              Value *constantval = constant.second;
              if (constantval == NULL) {
                constantval = cast<Value>(constant.first);
              }
              if (constantval == incomingValue) {
                errs() << "constantphifound";
                phi->print(errs());
                constantinst->print(errs());
                errs() << "\n";
                // eraseQueue.insert(constantinst);
                changes.insert({&inst, constantinst});
                operandReplacement.insert({&(cast<Value>(inst)), constantinst});
                found = true;
                break;
              }
            }
            if (found)
              break;
          }

          if (!found) {
            Value *phiVal = phi->hasConstantValue();

            errs() << "\n";
            if (phiVal != NULL) {
              changes.insert({&inst, phiVal});
              operandReplacement.insert({&(cast<Value>(inst)), phiVal});
              errs() << "constantphifound";
              phi->print(errs());
              phiVal->print(errs());
              errs() << "\n";
            }
          }
        }
        // errs() << "\n\nCONSTANTS---\n";

        for (auto const &consta : constants) {
          // consta.first->print(errs());
          if (consta.second != NULL) {
            // consta.second->print(errs());
          }
        }
        // errs() << "\n!---!\n\n";

        set<Instruction *> eraseQueue = {};

        Function *func = b->getParent();
        bool seen = false;
        if (!seen && func->arg_size() > 0) {
          seen = true;
          for (int i = 0; i < func->arg_size(); i++) {
            Value *arg = func->getArg(i);
            for (auto &consta : constants) {
              Value *constantval = consta.second;

              if (consta.second == NULL) {
                constantval = cast<Value>(consta.first);
              }
              if (arg == constantval) {
                eraseQueue.insert(consta.first);
                errs() << "\ndeleted\n";
                consta.first->print(errs());
                errs() << "\n";
              }
            }
          }
          for (auto &erased : eraseQueue) {
            constants.erase(erased);
          }
        }

        CallInst *callinst = NULL;
        if (isa<CallInst>(inst)) {
          callinst = &(cast<CallInst>(inst));
          if (isa<ConstantInt>(inst.getOperand(0))) {
            constants.insert({&inst, NULL});
          } else if (callinst->getCalledFunction()->getName() == "CAT_set" &&
                     isa<ConstantInt>(callinst->getOperand(1))) {
            constants.insert({&inst, cast<Value>(callinst->getOperand(0))});
            // errs() << callinst->getOperand(0);
          }

          for (auto const &constant : constants) {
            bool flag = false;
            for (auto &outinst : out[&inst]) {
              if (outinst == constant.first) {
                flag = true;
                break;
              }
            }
            CallInst *killed = NULL;
            if (!flag) {
              killed = cast<CallInst>(constant.first);
              eraseQueue.insert(constant.first);
              // errs() << "\n";
              // inst.print(errs());
              // errs() << "this killed ";
              // constant.first->print(errs());
              // errs() << "\n";
            }

            // if (!flag && callinst->arg_size() > 1) {
            //   bool correct1 = false;
            //   bool correct2 = false;
            //   for (auto &c : constants) {
            //     if (c.first == callinst->getOperand(1)) {
            //       correct1 = true;
            //     }
            //     if (c.first == callinst->getOperand(2)) {
            //       correct2 = true;
            //     }
            //   }
            //   bool bothConstants = correct1 && correct2;

            //   if (bothConstants) {
            //     if (callinst->getOperand(0) == callinst->getOperand(1)) {
            //       eraseQueue.erase(constant.first);
            //     }
            //     if (callinst->getOperand(0) == callinst->getOperand(2)) {
            //       eraseQueue.erase(constant.first);
            //     }
            //   }
            // }
          }
        }

        if (callinst != NULL) {
          // callinst->print(errs());
          string name = callinst->getCalledFunction()->getName().str();
          // errs() << "\nvals\n";

          for (int i = 0; i < callinst->arg_size(); i++) {
            Value *val = callinst->getOperand(i);
            // errs() << "\n   val: ";
            // val->print(errs());
            // errs() << "\n";

            for (auto &constanttup : constants) {
              Instruction *constant = constanttup.first;
              Value *constantval = constanttup.second;
              if (constantval == NULL) {
                constantval = cast<Value>(constant);
              }
              callinst->print(errs());
              if (constantval == val) {
                ConstantInt *constval =
                    (constanttup.second != NULL)
                        ? cast<ConstantInt>(constant->getOperand(1))
                        : cast<ConstantInt>(constant->getOperand(0));
                // errs() << "\nbefore\n";
                // errs() << "\nafter\n";

                if (name == "CAT_get") {
                  changes.insert({callinst, constval});
                } else if (name == "CAT_add" || name == "CAT_sub") {
                  if (i == 0)
                    continue;
                  if (operandChanges.find(callinst) == operandChanges.end()) {
                    map<int, ConstantInt *> newmap = {{i, constval}};
                    operandChanges.insert({callinst, newmap});
                  } else {
                    operandChanges[callinst].insert({i, constval});
                  }
                }
                // errs() << "-\n";
              }
            }
          }
        }
        for (auto &erased : eraseQueue) {
          errs() << "\nendofblockkilling:";
          erased->print(errs());
          if (globalkilled.find(b) == globalkilled.end()) {
            map<Instruction *, Value *> temp = {};
            globalkilled.insert({b, temp});
          }
          globalkilled[b].insert({erased, constants[erased]});
          constants.erase(erased);
        }

        for (auto const &a : constants) {
          errs() << "\nconstantatm";
          a.first->print(errs());
        }
      }

      Module *M = F.getParent();
      Function *CATSetFunc = M->getFunction("CAT_set");
      Function *CATGetFunc = M->getFunction("CAT_get");

      IRBuilder<> builder(b);
      LLVMContext &context = b->getContext();

      for (auto const &x : operandChanges) {
        // x.first->print(errs());
        // errs() << x.second.size();
        // errs() << "~\n";
        if (x.second.size() == 2) {
          string name = x.first->getCalledFunction()->getName().str();

          auto it = x.second.find(1);
          auto it2 = x.second.find(2);
          builder.SetInsertPoint(x.first);
          if (name == "CAT_add") {
            Value *arg1 = x.first->getOperand(0);
            Value *arg2 = ConstantInt::get(Type::getInt64Ty(context),
                                           it->second->getSExtValue() +
                                               it2->second->getSExtValue());
            CallInst *call = builder.CreateCall(CATSetFunc, {arg1, arg2});
            x.first->eraseFromParent();

          } else if (name == "CAT_sub") {
            Value *arg1 = x.first->getOperand(0);
            Value *arg2 = ConstantInt::get(Type::getInt64Ty(context),
                                           it->second->getSExtValue() -
                                               it2->second->getSExtValue());
            CallInst *call = builder.CreateCall(CATSetFunc, {arg1, arg2});
            x.first->eraseFromParent();
          }
        } else if (x.second.size() == 1) {
          builder.SetInsertPoint(x.first);
          string name = x.first->getCalledFunction()->getName().str();
          for (auto const &y : x.second) {
            errs() << y.first << "^^^^";
            if (y.second->getSExtValue() == 0) {
              if (name == "CAT_add") {
                Value *arg1 = x.first->getOperand(0);
                // x.first->print(errs());
                Value *arg2 = y.first == 1 ? x.first->getOperand(2)
                                           : x.first->getOperand(1);
                if (!isa<ConstantInt>(arg2)) {
                  CallInst *getcall = builder.CreateCall(CATGetFunc, {arg2});
                  errs() << "\n";
                  getcall->print(errs());
                  errs() << "getinsertreplace\n";
                  arg2 = cast<Value>(getcall);
                }
                CallInst *call = builder.CreateCall(CATSetFunc, {arg1, arg2});
                x.first->eraseFromParent();
              } else if (name == "CAT_sub" && y.first == 2) {
                Value *arg1 = x.first->getOperand(0);
                Value *arg2 = x.first->getOperand(1);
                if (!isa<ConstantInt>(arg2)) {
                  CallInst *getcall = builder.CreateCall(CATGetFunc, {arg2});
                  errs() << "\n";
                  getcall->print(errs());
                  errs() << "getinsertreplace\n";
                  arg2 = cast<Value>(getcall);
                }
                CallInst *call = builder.CreateCall(CATSetFunc, {arg1, arg2});
                x.first->eraseFromParent();
              }
            }
          }
        }
      }

      // for (auto const& instcount : changes) {
      for (auto const &x : changes) {
        BasicBlock::iterator ii(x.first);
        errs() << "\n";
        x.first->print(errs());
        errs() << "|";
        ReplaceInstWithValue(b->getInstList(), ii, x.second);
        x.second->print(errs());
      }

      globalconstants.insert({b, constants});

      errs() << "\n\nBLOCK AFTER MODIFICATION\n";
      errs() << *b;
      errs() << "\n\nNEXTBLOCK\n";

      if (changes.size() > 0 || operandReplacement.size() > 0) {
        visited.clear();
        q.push(first);
      }
    }

    return false;
  };

  // We don't modify the program, so we preserve all analyses.
  // The LLVM IR of functions isn't ready at this point
  void getAnalysisUsage(AnalysisUsage &AU) const override {
    // errs() << "Hello LLVM World at \"getAnalysisUsage\"\n" ;
    AU.setPreservesAll();
  }
};
} // namespace

// Next there is code to register your pass to "opt"
char CAT::ID = 0;
static RegisterPass<CAT> X("CAT", "Homework for the CAT class");

// Next there is code to register your pass to "clang"
static CAT *_PassMaker = NULL;
static RegisterStandardPasses _RegPass1(PassManagerBuilder::EP_OptimizerLast,
                                        [](const PassManagerBuilder &,
                                           legacy::PassManagerBase &PM) {
                                          if (!_PassMaker) {
                                            PM.add(_PassMaker = new CAT());
                                          }
                                        }); // ** for -Ox
static RegisterStandardPasses
    _RegPass2(PassManagerBuilder::EP_EnabledOnOptLevel0,
              [](const PassManagerBuilder &, legacy::PassManagerBase &PM) {
                if (!_PassMaker) {
                  PM.add(_PassMaker = new CAT());
                }
              }); // ** for -O0
