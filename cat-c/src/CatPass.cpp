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
#include "llvm/IR/Constants.h"

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

      for (map<Value*, set<Instruction *>>::iterator it = var_to_inst.begin(); it != var_to_inst.end(); ++it)
      {
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
     prev_out = {};
     do {

      prev_out = out;

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
      
        

     } while (prev_out != out);


    set<Instruction *> constants = {};

    for (auto &b : F) {
      for (auto &inst : b) {
        errs() << "\n\n\n\nNEW INSTRUCTION\n";
	      inst.print(errs());
        errs() << "\n";
        /*
        errs() << "begining of out!\n";
        for (auto &outinst: out[&inst]) {
          outinst->print(errs());
          errs() << "\n";
        }
        errs() << "end of out!!\n\n";
        */
        
        errs() << "\n\nCONSTANTS---\n";

        for (auto &consta : constants) {
            consta->print(errs());
        }
        errs() << "\n!---!\n\n";

        set<Instruction *> eraseQueue = {};
        bool newConstant = false;
        CallInst* callinst = NULL;
        if (isa<CallInst>(inst)) {
            callinst = &(cast<CallInst>(inst));
            if (isa<ConstantInt>(inst.getOperand(0))) {
                newConstant = true;
                errs() << "CONSTANT INT FOUND!\n";
                constants.insert(&inst);
            }
          
            for (auto &constant : constants) {
                bool flag = false;
                for (auto &outinst : out[&inst]) {
                    if (outinst == constant) {
                        flag = true;
                        break;
                    }
                }
                if (!flag) {
                    eraseQueue.insert(constant);
                    inst.print(errs());
                    errs() << "this killed ";
                    constant->print(errs());
                    errs() << "\n";
                }
            }
        }

        for (auto &erased : eraseQueue) {
          errs() << "errased ";
          erased->print(errs());
	        errs() << "\n";
          constants.erase(erased);
        }


        if (callinst && !newConstant) {
          errs() << "STARTING TO REPLACE\n";
          callinst->print(errs());
          errs() << "\n";
          for (int i = 0; i < callinst->arg_size(); i++) {
            Value* operand = callinst->getOperand(i);
            if (!operand) continue;

            for (auto &constantElem : constants) {
                CallInst* constantCall = dyn_cast<CallInst>(constantElem);
                if (!constantCall) continue;

                Value* potentialVar = (constantCall->arg_size() == 1) ? 
                                        static_cast<Value*>(constantCall) : 
                                        constantCall->getOperand(1);
                if (!potentialVar) continue;

                if (operand == potentialVar) {
                  if (auto constValue = dyn_cast<ConstantInt>(constantCall->getOperand(0))) {
                      LLVMContext& context = operand->getContext();
                      Type* operandType = operand->getType();

                      Constant* newConstant = nullptr;
                      if (operandType->isPointerTy() && cast<PointerType>(operandType)->getElementType()->isIntegerTy()) {
                          newConstant = ConstantExpr::getIntToPtr(constValue, operandType);
                      } else {
                          // TODO: non integer types
                          newConstant = constValue;
                      }

                      if (newConstant) {
                          errs() << "\nbefore\n";
                          callinst->print(errs());
                          callinst->setOperand(i, newConstant);
                          errs() << "\nafter\n";
                          callinst->print(errs());
                          errs() << "-\n";
                      } else {
                          errs() << "Failed to create a new constant for operand type: " << *operandType << "\n";
                      }
                }
            }

        }
    }
}


        // TODO: replacing constants for return inst

      }
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
