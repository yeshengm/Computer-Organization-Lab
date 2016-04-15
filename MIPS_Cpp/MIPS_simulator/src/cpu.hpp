#pragma once
#include <memory>
#include "ctr.hpp"
#include "pc.hpp"
#include "reg.hpp"
#include "memory.hpp"
#include "other.hpp"
#include "alucontrol.hpp"
#include "alu.hpp"
#include "pc.hpp"
#include "component.hpp"
#include "env.hpp"

namespace MIPS {
using std::auto_ptr;
struct CPU {
    Ctr ctr;
    PC pc;
    Reg reg;
    Memory instMem, dataMem;
    ALU alu;
    ALUControl aluControl;
    Multiplexer muxAlu, muxRegDes, muxMem2Reg;
    SignExtener signExtend;
    // Initializer
    CPU();
    // run program and retrive res
    LineData run();
    // Reset cpu
    void reset();
};
}
