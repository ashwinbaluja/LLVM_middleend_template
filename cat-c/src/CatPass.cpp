#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Support/Casting.h"

#include <string>
#include <set>
#include <map>

using namespace llvm;
using namespace std;
namespace {



  struct CAT : public FunctionPass {
    static char ID;
    map<CallInst, set<CallInst>> gen;
    map<CallInst, set<CallInst>> kill;

    CAT() : FunctionPass(ID) {} 

    // This function is invoked once at the initialization phase of the compiler
    // The LLVM IR of functions isn't ready at this point
    bool doInitialization (Module &M) override {
      
      gen = {};
      kill = {};

      // errs() << "Hello LLVM World at \"doInitialization\"\n" ;
      return false;
    }

    // This function is invoked once per function compiled
    // The LLVM IR of the input functions is ready and it can be analyzed and/or transformed
    bool runOnFunction (Function &F) override {
      // errs() << F;
      
      for (auto& b : F) {
        errs() << "-----------------\n";
        for (auto& inst : b) {
          if (!isa<CallInst>(&inst)) {
            continue;
          }
          CallInst *i = cast<CallInst>(&inst);

          string name = i->getCalledFunction()->getName().str();

          if (name == "CAT_new" || name == "CAT_set") {
            set<CallInst> newgen = {*i};
            gen.insert({*i, newgen});
          }
          errs() << "\n";
        }
        errs() << "-----------------\n";
      }

      for (map<CallInst*, set<CallInst*>>::iterator it = gen.begin(); it != gen.end(); ++it) {
        it->first->print(errs());
        errs() << "!";
        it->second->print(errs());
        errs() << "\n";


      }
      return false;
    }

    // We don't modify the program, so we preserve all analyses.
    // The LLVM IR of functions isn't ready at this point
    void getAnalysisUsage(AnalysisUsage &AU) const override {
      // errs() << "Hello LLVM World at \"getAnalysisUsage\"\n" ;
      AU.setPreservesAll();
    }
  };
}

// Next there is code to register your pass to "opt"
char CAT::ID = 0;
static RegisterPass<CAT> X("CAT", "Homework for the CAT class");

// Next there is code to register your pass to "clang"
static CAT * _PassMaker = NULL;
static RegisterStandardPasses _RegPass1(PassManagerBuilder::EP_OptimizerLast,
    [](const PassManagerBuilder&, legacy::PassManagerBase& PM) {
        if(!_PassMaker){ PM.add(_PassMaker = new CAT());}}); // ** for -Ox
static RegisterStandardPasses _RegPass2(PassManagerBuilder::EP_EnabledOnOptLevel0,
    [](const PassManagerBuilder&, legacy::PassManagerBase& PM) {
        if(!_PassMaker){ PM.add(_PassMaker = new CAT()); }}); // ** for -O0
