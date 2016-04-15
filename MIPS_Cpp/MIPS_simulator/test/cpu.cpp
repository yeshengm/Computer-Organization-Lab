#include "gtest/gtest.h"
#include "cpu.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(cpu, addi)
{
    CPU cpu;
    // <input:0> addi $v0, $v0, 32
    cpu.instMem.loadMemory(0x00000000, 0x20420020);
    // End of program
    cpu.instMem.loadMemory(0x00000004, 0xFFFFFFFF);
    EXPECT_EQ(32, cpu.run());
}

TEST(cpu, add)
{
    CPU cpu;
    // <input:0> addi $v0, $v0, 32
    cpu.instMem.loadMemory(0x00000000, 0x20420020);
    // <input:1> add $v0, $v0, $v0
    cpu.instMem.loadMemory(0x00000004, 0x00421020);
    // End of program
    cpu.instMem.loadMemory(0x00000008, 0xFFFFFFFF);
    EXPECT_EQ(64, cpu.run());
}

TEST(cpu, sub)
{
    CPU cpu;
    // <input:0> addi $v0, $v0, 8
    cpu.instMem.loadMemory(0x00000000, 0x20420008);
    // <input:1> addi $v1, $v1, -8
    cpu.instMem.loadMemory(0x00000004, 0x2063fff8);
    // <input:2> sub $v0, $v0, $v1
    cpu.instMem.loadMemory(0x00000008, 0x00431022);
    // End of program
    cpu.instMem.loadMemory(0x0000000c, 0xFFFFFFFF);
    EXPECT_EQ(16, cpu.run());
}

TEST(cpu, lw)
{
    CPU cpu;
    cpu.dataMem.loadMemory(0x00000000, 4);
    cpu.dataMem.loadMemory(0x00000004, 5);
    // <input:0> lw $v1, 0($v0)
    cpu.instMem.loadMemory(0x00000000, 0x8c430000);
    // <input:1> lw $v2, 4($v0)
    cpu.instMem.loadMemory(0x00000004, 0x8c440004);
    // <input:2> sub $v0, $v1, $v2
    cpu.instMem.loadMemory(0x00000008, 0x00641022);
    // End of program
    cpu.instMem.loadMemory(0x0000000c, 0xFFFFFFFF);
    EXPECT_EQ(-1, cpu.run());
}

TEST(cpu, sw)
{
    CPU cpu;
    // <input:0> addi $v1, $v1, 90
    cpu.instMem.loadMemory(0x00000000, 0x2063005a);
    // <input:1> sw $v1, 0($v0)
    cpu.instMem.loadMemory(0x00000004, 0xac430000);
    // <input:2> lw $v0, 0($v0)
    cpu.instMem.loadMemory(0x00000008, 0x8c420000);
    // End of program
    cpu.instMem.loadMemory(0x0000000c, 0xFFFFFFFF);
    EXPECT_EQ(90, cpu.run());
}

TEST(cpu, branch_succ)
{
    CPU cpu;
    cpu.dataMem.loadMemory(0, 4);
    cpu.dataMem.loadMemory(4, 4);
    // <input:0> lw $v1, 0($v0)
    cpu.instMem.loadMemory(0x00000000, 0x8c430000);
    // <input:1> lw $v2, 4($v0)
    cpu.instMem.loadMemory(0x00000004, 0x8c440004);
    // <input:2> beq $v1, $v2, babel
    cpu.instMem.loadMemory(0x00000008, 0x10640001);
    // <input:3> addi $v0, $v0, 1
    cpu.instMem.loadMemory(0x0000000c, 0x20420001);
    // <input:5> addi $v0, $v0, 1
    cpu.instMem.loadMemory(0x00000010, 0x20420001);
    // End of program
    cpu.instMem.loadMemory(0x00000018, 0xFFFFFFFF);
    EXPECT_EQ(1, cpu.run());
}

TEST(cpu, branch_fail)
{
    CPU cpu;
    cpu.dataMem.loadMemory(0, 4);
    cpu.dataMem.loadMemory(4, 5);
    // <input:0> lw $v1, 0($v0)
    cpu.instMem.loadMemory(0x00000000, 0x8c430000);
    // <input:1> lw $v2, 4($v0)
    cpu.instMem.loadMemory(0x00000004, 0x8c440004);
    // <input:2> beq $v1, $v2, babel
    cpu.instMem.loadMemory(0x00000008, 0x10640001);
    // <input:3> addi $v0, $v0, 1
    cpu.instMem.loadMemory(0x0000000c, 0x20420001);
    // <input:5> addi $v0, $v0, 1
    cpu.instMem.loadMemory(0x00000010, 0x20420001);
    // End of program
    cpu.instMem.loadMemory(0x00000018, 0xFFFFFFFF);
    EXPECT_EQ(2, cpu.run());
}

TEST(cpu, feb)
{
    CPU cpu;
    cpu.dataMem.loadMemory(0, 10);
    // <input:0> addi $v1, $v0, 1
    cpu.instMem.loadMemory(0x00000000, 0x20430001);
    // <input:1> addi $v2, $v0, 1
    cpu.instMem.loadMemory(0x00000004, 0x20440001);
    // <input:2> addi $v4, $v0, 1
    cpu.instMem.loadMemory(0x00000008, 0x20460001);
    // <input:3> lw $v3, 0($v0)
    cpu.instMem.loadMemory(0x0000000c, 0x8c450000);
    // <input:5> beq $v4, $v3, next
    cpu.instMem.loadMemory(0x00000010, 0x10c50005);
    // <input:6> add $v5, $v1, $v2
    cpu.instMem.loadMemory(0x00000014, 0x00643820);
    // <input:7> addi $v1, $v2, 0
    cpu.instMem.loadMemory(0x00000018, 0x20830000);
    // <input:8> addi $v2, $v5, 0
    cpu.instMem.loadMemory(0x0000001c, 0x20e40000);
    // <input:9> addi $v4, $v4, 1
    cpu.instMem.loadMemory(0x00000020, 0x20c60001);
    // <input:10> beq $v0, $v0, label
    cpu.instMem.loadMemory(0x00000024, 0x1042fffa);
    // <input:12> addi $v0, $v1, 0
    cpu.instMem.loadMemory(0x00000028, 0x20620000);
    // End of program
    cpu.instMem.loadMemory(0x00000034, 0xFFFFFFFF);
    EXPECT_EQ(55, cpu.run());
}
