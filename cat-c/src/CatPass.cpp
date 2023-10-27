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
    map<BasicBlock *, set<BasicBlock *>> loopToBlocks = {};
    map<BasicBlock *, set<Value *>> loopToBadConstants = {};
    set<BasicBlock *> loopBlocks = {};
    queue<BasicBlock *> q = {};
    set<BasicBlock *> visited = {};

    for (auto &b : F) {
      q.push(&b);
      break;
    }

    for (auto &b : F) {
      set<BasicBlock *> visited2 = {};
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
    // // print loopBlocks
    // errs() << "\nloopBlocks\n";
    // for (auto &b: loopBlocks){
    //   errs() << *b << " ";
    // }

    for (auto &b : loopBlocks) {
      queue<BasicBlock *> preds = {};
      set<BasicBlock *> visited3 = {};
      queue<BasicBlock *> succs = {};
      set<BasicBlock *> visited4 = {};
      for (auto *bn : predecessors(b)) {
        if (loopBlocks.find(bn) != loopBlocks.end()) {
          preds.push(bn);
        }
      }
      for (auto *bn : successors(b)) {
        if (loopBlocks.find(bn) != loopBlocks.end()) {
          succs.push(bn);
        }
      }

      while (preds.size() > 0) {
        BasicBlock *b2 = preds.front();
        preds.pop();
        if (visited3.find(b2) != visited3.end())
          continue;
        bool leaves = false;
        set<BasicBlock *> toPush = {};

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
        set<BasicBlock *> toPush = {};
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
      // // print visited3
      // errs() << "\nvisited3\n";
      // for (auto &b: visited3){
      //   errs() << *b << " ";
      // }
      // // print visited4
      // errs() << "\nvisited4\n";
      // for (auto &b: visited4){
      //   errs() << *b << " ";
      // }

      for (auto &b : visited3) {
        visited4.insert(b);
      }
      visited4.insert(b);
      loopToBlocks.insert({b, visited4});
    }
    // print loopToBlock
    //  errs() << "loopToBlock ****\n";
    //  for (auto &b: loopToBlocks){
    //    b.first->print(errs());
    //    errs() << ": \n";
    //    for (auto &bn: b.second){
    //      errs() << *bn << " ";
    //    }
    //    errs() << "____________________\n";
    //  }

    for (auto &pair : loopToBlocks) {
      BasicBlock *b = pair.first;
      set<Value *> temp = {};
      loopToBadConstants.insert({b, temp});
      for (auto &inst : *b) {
        if (isa<CallInst>(inst)) {
          CallInst *cinst = &(cast<CallInst>(inst));
          Value *vinst = cinst->getOperand(0);
          for (int i = 1; i < cinst->arg_size(); i++) {
            if (vinst == cinst->getOperand(i)) {
              if (isa<ConstantInt>(vinst) &&
                  cast<ConstantInt>(vinst)->getSExtValue() == 0) {
                continue;
              }
              loopToBadConstants[b].insert(vinst);
              break;
            }
          }
        }
      }
    }

    // print loopToBadConstants
    errs() << "loopToBadConstants ****\n";
    for (auto &b : loopToBadConstants) {
      errs() << "loop\n";
      b.first->print(errs());
      errs() << ": \n";
      for (auto &bn : b.second) {
        bn->print(errs());
        errs() << " ";
      }
      errs() << "____________________\n";
    }

    BasicBlock *first = q.front();
    set<Value *> permakill = {};

    while (q.size() > 0) {

      errs() << "currenpermakill\n";
      for (auto &val : permakill) {
        val->print(errs());
        errs() << "\n";
      }
      errs() << "\nend";
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
        for (auto &bn : loopToBlocks[b]) {
          for (auto &bad : loopToBadConstants[bn]) {
            falseFinds.insert(bad);
          }
        }
        for (auto &inst : *b) {
          if (isa<CallInst>(inst)) {
            CallInst *cinst = &(cast<CallInst>(inst));
            Value *vinst = cinst->getOperand(0);
            for (int i = 1; i < cinst->arg_size(); i++) {
              if (falseFinds.find(cinst->getOperand(i)) != falseFinds.end()) {
                falseFinds.insert(vinst);
                break;
              }
            }
          }
        }
        // print falseFinds
        errs() << "\nfalseFinds\n";
        for (auto &v : falseFinds) {
          v->print(errs());
          errs() << " ";
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

      for (auto const &val : permakill) {
        errs() << "\npermakilled: ";
        val->print(errs());
        errs() << "\n";
        falseFinds.insert(val);
      }
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

      // errs() << "\nconstant";
      // for (auto &consta : constants) {
      //   consta.first->print(errs());
      //   errs() << consta.second;
      //   errs() << "\n";
      // }

      map<CallInst *, map<int, ConstantInt *>> operandChanges = {};

      for (auto &inst : *b) {
        errs() << "\n\nInstruction\n";
        inst.print(errs());
        errs() << "\n";

        set<Instruction *> eraseQueue = {};

        if (isa<CallInst>(inst)) {
          CallInst *cinst = cast<CallInst>(&inst);
          string name = cinst->getCalledFunction()->getName().str();
          if (!(name == "CAT_new" || name == "CAT_set" || name == "CAT_add" ||
                name == "CAT_sub" || name == "CAT_get" || name == "printf")) {
            for (int i = 0; i < cinst->arg_size(); i++) {
              if (Instruction *a =
                      dyn_cast<Instruction>(cinst->getOperand(i))) {
                if (!isa<CallInst>(a))
                  continue;
                errs() << "erased an instruction cause it was called in a "
                          "function";
                a->print(errs());
                errs() << "\n";
                if (cinst->arg_size() > 1) permakill.insert(cast<Value>(a));
                eraseQueue.insert(a);
              }
            }
          }
        }
        if (isa<PHINode>(inst)) {
          errs() << "phiNode\n";
          /* ADDED THIS BIT AND GOT ERROR*/
          if (falseFinds.find(&inst) == falseFinds.end()) {
            errs() << "not falsefind\n";
            PHINode *phi = cast<PHINode>(&inst);
            Value *phiVal = phi->hasConstantValue();
            errs() << "\n";
            if (phiVal != NULL) {
              changes.insert({&inst, phiVal});
              operandReplacement.insert({&(cast<Value>(inst)), phiVal});
              errs() << "constantphifound";
              phi->print(errs());
              phiVal->print(errs());
              errs() << "\n";
            } else {
              ConstantInt *prev = NULL;
              int flag = true;
              Value *v;
              for (unsigned i = 0, e = phi->getNumIncomingValues(); i != e;
                   ++i) {
                Value *incomingValue = phi->getIncomingValue(i);
                bool sameblock = false;
                for (auto U : incomingValue->users()) { // U is of type User*
                  if (auto I = dyn_cast<Instruction>(U)) {
                    if (I == &inst)
                      continue;
                    if (I->getParent() == b) {
                      sameblock = true;
                      break;
                    }
                  }
                }
                if (sameblock) {
                  flag = false;
                  break;
                }
                errs() << "incomingValue: ";
                incomingValue->print(errs());
                errs() << "\n";
                CallInst *calli = dyn_cast<CallInst>(incomingValue);
                if (!calli) {
                  flag = false;
                  break;
                }
                v = (calli->arg_size() == 1) ? calli->getOperand(0)
                                             : calli->getOperand(1);

                ConstantInt *incomingConstant = NULL;
                if (isa<ConstantInt>(v)) {
                  incomingConstant = cast<ConstantInt>(v);
                  errs() << "incomingConstant: ";
                  incomingConstant->print(errs());
                  errs() << "\n";
                }
                if (i == 0) {
                  if (incomingConstant == NULL) {
                    flag = false;
                    break;
                  }
                  prev = incomingConstant;
                  continue;
                }

                if (incomingConstant == NULL ||
                    incomingConstant->getSExtValue() != prev->getSExtValue()) {
                  errs() << "not equal\nprev: ";
                  prev->print(errs());
                  flag = false;
                  break;
                }
                errs() << "constant: ";
                incomingConstant->print(errs());
                errs() << "\n";
                prev = incomingConstant;
              }
              if (flag) {
                changes.insert({&inst, phi->getIncomingValue(0)});
                operandReplacement.insert({&(cast<Value>(inst)), prev});
                errs() << "constantphifoundHERE";
                phi->print(errs());
                prev->print(errs());
                errs() << "\n";
              }
            }
          }
        }

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
            }
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

              if (permakill.find(constantval) != permakill.end()){
                continue;
              }
              // callinst->print(errs());
              if (constantval == val) {
                ConstantInt *constval =
                    (constanttup.second != NULL)
                        ? cast<ConstantInt>(constant->getOperand(1))
                        : cast<ConstantInt>(constant->getOperand(0));
                // errs() << "\nbefore\n";
                // errs() << "\nafter\n";

                if (name == "CAT_get") {
                  errs() << "\noptimize Cat_get\n";
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
        errs() << "\nConstant after instruction\n";
        for (auto const &consta : constants) {
          consta.first->print(errs());
          errs() << "\n";
        }
      }

      Module *M = F.getParent();
      Function *CATSetFunc = M->getFunction("CAT_set");
      Function *CATGetFunc = M->getFunction("CAT_get");

      IRBuilder<> builder(b);
      LLVMContext &context = b->getContext();

      for (auto const &x : operandChanges) {
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

      for (auto const &x : changes) {
        BasicBlock::iterator ii(x.first);
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
