#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"


#include <string>
#include <set>
#include <map>
#include <algorithm>

using namespace llvm;
using namespace std;
namespace
{

  struct CAT : public FunctionPass
  {
    static char ID;
    map<Instruction *, set<Instruction *>> gen;
    map<Instruction *, set<Instruction *>> kill;

    map<Value*, set<Instruction *>> var_to_inst;

    map<Instruction *, set<Instruction *>> in;
    map<Instruction *, set<Instruction *>> out;
    map<Instruction *, set<Instruction *>> prev_out;

    CAT() : FunctionPass(ID) {}

    // This function is invoked once at the initialization phase of the compiler
    // The LLVM IR of functions isn't ready at this point
    bool doInitialization(Module &M) override
    {

      

      // errs() << "Hello LLVM World at \"doInitialization\"\n" ;
      return false;
    }

    // This function is invoked once per function compiled
    // The LLVM IR of the input functions is ready and it can be analyzed and/or transformed
    bool runOnFunction(Function &F) override
    {
      // errs() << F;
      gen = {};
      kill = {};
      var_to_inst = {};
      in = {};
      out = {};
      
      errs() << "Function \"" << F.getName() << "\"\n";
      for (auto &b : F)
      {
        for (auto &inst : b)
        {
          if (!isa<Instruction>(&inst))
          {
            continue;
          }


          Instruction *i = cast<Instruction>(&inst);

          string name = "";
          CallInst* callinst;

          if (isa<CallInst>(*i)) {
            callinst = cast<CallInst>(i);
            name = callinst->getCalledFunction()->getName().str();
          }

          if (name == "CAT_new" || name == "CAT_set" || name == "CAT_add" || name == "CAT_sub")
          {
            set<Instruction *> newgen = {i};
            gen.insert({i, newgen});
            Value* argValue;
            if (isa<ReturnInst>(i) || (isa<CallInst>(i) && callinst->arg_size() == 1)){
              argValue = dyn_cast<Value>(callinst);
            }
            else {
               argValue = i->getOperand(0);
            }

            if (var_to_inst.find(argValue) == var_to_inst.end())
            {
              set<Instruction *> newset = {i};
              var_to_inst.insert({argValue, newset});
            }
            else
            {
              var_to_inst[argValue].insert(i);
            }
          }
          else {
            set<Instruction *> newgen = {};
            gen.insert({i, newgen});
          }
        }
      }

      errs() << "GEN:\n\n";
      for (map<Instruction *, set<Instruction *>>::iterator it = gen.begin(); it != gen.end(); ++it)
      {
        it->first->print(errs());
        errs() << "!";

        for (Instruction *inst : it->second)
        {
          inst->print(errs());
          errs() << ", "; // Optional: to separate the items in the set
        }

        errs() << "\n";
      }


      for (map<Value*, set<Instruction *>>::iterator it = var_to_inst.begin(); it != var_to_inst.end(); ++it)
      {
        //it->first->print(errs());
        /*
        for (CallInst *inst : it->second)
        {
          inst->print(errs());
          errs() << "|||||||||| ";
        }

        errs() << "\n";
        */
        // populate kill
        if (it->second.size() > 1)
        {
          for (Instruction *inst : it->second)
          {
            for (Instruction *inst2 : it->second)
            {
              if (inst != inst2)
              {
                kill[inst].insert(inst2);
              }
            }
          }
        }
      }


      // print kill

      
      errs() << "kill:\n\n";
      for (map<Instruction *, set<Instruction *>>::iterator it = kill.begin(); it != kill.end(); ++it)
      {
        it->first->print(errs());
        errs() << "!";

        for (Instruction *inst : it->second)
        {
          inst->print(errs());
          errs() << ", "; // Optional: to separate the items in the set
        }

        errs() << "\n";
      }
      

     prev_out = {};
     do {

      for (auto &b : F) {
          Instruction *last = NULL;

          for (auto &inst : b) {
            if (!isa<Instruction>(&inst))
            {
              continue;
            }

            Instruction *i = cast<Instruction>(&inst);

            if (in.find(i) == in.end())
            {
              set<Instruction *> newgen = {};
              in.insert({i, newgen});
            }

            if (out.find(i) == out.end())
            {
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

        for (auto p: predecessors(&b)){
          last = p->getTerminator();
          for (auto &inst : b) {

            if (!isa<Instruction>(&inst))
            {
              continue;
            }

            Instruction *i = cast<Instruction>(&inst);

            if (in.find(i) == in.end())
            {
              set<Instruction *> newgen = {};
              in.insert({i, newgen});
            }

            if (out.find(i) == out.end())
            {
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
      
      prev_out = out;
        

     } while (prev_out != out);
      

      for (map<Instruction *, set<Instruction *>>::iterator it = in.begin(); it != in.end(); ++it)
      {
        errs () << "INSTRUCTION:   ";
        it->first->print(errs());
        errs() << "\n***************** IN\n{\n";

        for (Instruction *inst : it->second)
        {
          inst->print(errs());
          errs() << "\n"; // Optional: to separate the items in the set
        }
        errs() << "}\n";

        errs() << "**************************************\n";
        errs() << "***************** OUT\n{\n";

        for (Instruction *inst : out[it->first])
        {
          if (isa<ReturnInst>(inst)) {
            continue;
          }
          inst->print(errs());
          errs() << "\n"; // Optional: to separate the items in the set
        }
        errs() << "}\n";
        errs() << "**************************************\n";
        errs() << "\n\n\n";
      }



      return false;
    };

    // We don't modify the program, so we preserve all analyses.
    // The LLVM IR of functions isn't ready at this point
    void getAnalysisUsage(AnalysisUsage &AU) const override
    {
      // errs() << "Hello LLVM World at \"getAnalysisUsage\"\n" ;
      AU.setPreservesAll();
    }
  };
}

// Next there is code to register your pass to "opt"
char CAT::ID = 0;
static RegisterPass<CAT> X("CAT", "Homework for the CAT class");

// Next there is code to register your pass to "clang"
static CAT *_PassMaker = NULL;
static RegisterStandardPasses _RegPass1(PassManagerBuilder::EP_OptimizerLast,
                                        [](const PassManagerBuilder &, legacy::PassManagerBase &PM)
                                        {
        if(!_PassMaker){ PM.add(_PassMaker = new CAT());} }); // ** for -Ox
static RegisterStandardPasses _RegPass2(PassManagerBuilder::EP_EnabledOnOptLevel0,
                                        [](const PassManagerBuilder &, legacy::PassManagerBase &PM)
                                        {
        if(!_PassMaker){ PM.add(_PassMaker = new CAT()); } }); // ** for -O0
