#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Pass.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"

#include <algorithm>
#include <map>
#include <set>
#include <string>

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

    map<Instruction *, Value *> constants = {};

    for (auto &b : F) {
      map<Instruction *, Value *> changes = {};
      for (auto &inst : b) {
        errs() << "\n\nCONSTANTS---\n";

        for (auto const &consta : constants) {
          consta.first->print(errs());
          if (consta.second != NULL) {
            consta.second->print(errs());
          }
        }
        errs() << "\n!---!\n\n";

        set<Instruction *> eraseQueue = {};

        CallInst *callinst = NULL;
        if (isa<CallInst>(inst)) {
          callinst = &(cast<CallInst>(inst));
          if (isa<ConstantInt>(inst.getOperand(0))) {
            constants.insert({&inst, NULL});
          } else if (callinst->getCalledFunction()->getName() == "CAT_set" &&
                     isa<ConstantInt>(callinst->getOperand(1))) {
            constants.insert({&inst, cast<Value>(callinst->getOperand(0))});
            errs() << callinst->getOperand(0);
          }

          for (auto const &constant : constants) {
            bool flag = false;
            for (auto &outinst : out[&inst]) {
              if (outinst == constant.first) {
                flag = true;
                break;
              }
            }
            if (!flag) {
              eraseQueue.insert(constant.first);
              errs() << "\n";
              inst.print(errs());
              errs() << "this killed ";
              constant.first->print(errs());
              errs() << "\n";
            }
          }
        }

        for (auto &erased : eraseQueue) {
          constants.erase(erased);
        }

        if (callinst != NULL) {
          callinst->print(errs());
          string name = callinst->getCalledFunction()->getName().str();
          errs() << "\nvals\n";
          for (int i = 0; i < callinst->arg_size(); i++) {
            Value *val = callinst->getOperand(i);
            errs() << "\n   val: ";
            val->print(errs());
            errs() << "\n";

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
                errs() << "\nbefore\n";
                errs() << b;
                errs() << "\nafter\n";

                if (name == "CAT_get") {
                  errs() << "catgetfound";
                  changes.insert({callinst, constval});
                  errs() << b;
                } else {
                  if (i > 0) {
                    callinst->setOperand(i, constval);
                  }
                }
                errs() << "-\n";
              }
            }
          }
        }
      }
      // for (auto const& instcount : changes) {
      for (auto const &x : changes) {
        BasicBlock::iterator ii(x.first);
        errs() << "\n\n\n\n";
        x.first->print(errs());
        ReplaceInstWithValue(b.getInstList(), ii, x.second);
        x.second->print(errs());
        errs() << "\n\n\n\n";
      }
      errs() << b << "\nfinalbasicblock\n";
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
