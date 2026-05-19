#include <iostream>
#include <fstream>
#include <string>
#include <sys/stat.h>

#include "pin.H"
#include "utils.h"
#include "instselector.h"

KNOB<std::string> out_file(
    KNOB_MODE_WRITEONCE, "pintool", "o", "instruction_counts.csv",
    "specify CSV output file name"
);

KNOB<std::string> exe_name(
    KNOB_MODE_WRITEONCE, "pintool", "exe_name", "unknown_executable",
    "specify executable file name"
);

static UINT64 total_count   = 0;
static UINT64 arith_count   = 0;
static UINT64 logic_count   = 0;
static UINT64 cmp_count     = 0;
static UINT64 branch_count  = 0;
static UINT64 call_count    = 0;
static UINT64 ret_count     = 0;
static UINT64 load_count    = 0;
static UINT64 store_count   = 0;
static UINT64 other_count   = 0;

VOID CountArith()  { arith_count++; total_count++; }
VOID CountLogic()  { logic_count++; total_count++; }
VOID CountCmp()    { cmp_count++; total_count++; }
VOID CountBranch() { branch_count++; total_count++; }
VOID CountCall()   { call_count++; total_count++; }
VOID CountRet()    { ret_count++; total_count++; }
VOID CountLoad()   { load_count++; total_count++; }
VOID CountStore()  { store_count++; total_count++; }
VOID CountOther()  { other_count++; total_count++; }

static bool FileExists(const std::string &path) {
    struct stat buffer;
    return stat(path.c_str(), &buffer) == 0;
}

static bool IsArithmetic(INS ins) {
    OPCODE op = INS_Opcode(ins);
    return op == XED_ICLASS_ADD  || op == XED_ICLASS_SUB  ||
           op == XED_ICLASS_IMUL || op == XED_ICLASS_MUL  ||
           op == XED_ICLASS_IDIV || op == XED_ICLASS_DIV  ||
           op == XED_ICLASS_INC  || op == XED_ICLASS_DEC  ||
           op == XED_ICLASS_NEG;
}

static bool IsLogical(INS ins) {
    OPCODE op = INS_Opcode(ins);
    return op == XED_ICLASS_AND || op == XED_ICLASS_OR  ||
           op == XED_ICLASS_XOR || op == XED_ICLASS_NOT ||
           op == XED_ICLASS_SHL || op == XED_ICLASS_SHR ||
           op == XED_ICLASS_SAR;
}

static bool IsCompare(INS ins) {
    OPCODE op = INS_Opcode(ins);
    return op == XED_ICLASS_CMP || op == XED_ICLASS_TEST;
}

VOID CountInst(INS ins, VOID *v)
{
    if (!isValidInst(ins))
        return;

    if (INS_IsMemoryRead(ins) || INS_HasMemoryRead2(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountLoad, IARG_END);
        return;
    }

    if (INS_IsMemoryWrite(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountStore, IARG_END);
        return;
    }

    if (INS_IsCall(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountCall, IARG_END);
        return;
    }

    if (INS_IsRet(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountRet, IARG_END);
        return;
    }

    if (INS_IsBranch(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountBranch, IARG_END);
        return;
    }

    if (IsCompare(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountCmp, IARG_END);
        return;
    }

    if (IsLogical(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountLogic, IARG_END);
        return;
    }

    if (IsArithmetic(ins)) {
        INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountArith, IARG_END);
        return;
    }

    INS_InsertPredicatedCall(ins, IPOINT_BEFORE, (AFUNPTR)CountOther, IARG_END);
}

VOID Fini(INT32 code, VOID *v)
{
    std::string csv_path = out_file.Value();
    bool exists = FileExists(csv_path);

    std::ofstream out(csv_path.c_str(), std::ios::app);

    if (!exists) {
        out << "executable_file_name,"
            << "Total,"
            << "Arith,"
            << "Logic,"
            << "Compare,"
            << "Branch,"
            << "Call,"
            << "Ret,"
            << "Load,"
            << "Store,"
            << "Other\n";
    }

    out << exe_name.Value() << ","
        << total_count      << ","
        << arith_count      << ","
        << logic_count      << ","
        << cmp_count        << ","
        << branch_count     << ","
        << call_count       << ","
        << ret_count        << ","
        << load_count       << ","
        << store_count      << ","
        << other_count      << "\n";

    out.close();
}

INT32 Usage()
{
    std::cerr << "Counts dynamic instruction classes and writes to CSV\n";
    std::cerr << KNOB_BASE::StringKnobSummary() << std::endl;
    return -1;
}

int main(int argc, char *argv[])
{
    PIN_InitSymbols();

    if (PIN_Init(argc, argv))
        return Usage();

    INS_AddInstrumentFunction(CountInst, 0);
    PIN_AddFiniFunction(Fini, 0);

    PIN_StartProgram();
    return 0;
}