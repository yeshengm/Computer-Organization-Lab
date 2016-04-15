#include "gtest/gtest.h"
#include "alucontrol.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(alu, control)
{
    ALUControl aluctl;
    // Line 1
    aluctl.input(aluOp, 0);
    aluctl.input(funct, 20);
    EXPECT_EQ(2, aluctl.output(aluCtr));
    aluctl.input(funct, 14);
    EXPECT_EQ(2, aluctl.output(aluCtr));
    // Line 2
    aluctl.input(aluOp, 1);
    aluctl.input(funct, 20);
    EXPECT_EQ(6, aluctl.output(aluCtr));
    aluctl.input(funct, 10);
    EXPECT_EQ(6, aluctl.output(aluCtr));
    // Line 3
    aluctl.input(aluOp, 2);
    aluctl.input(funct, 0);
    EXPECT_EQ(2, aluctl.output(aluCtr));
    // Line 4
    aluctl.input(funct, 2);
    EXPECT_EQ(6, aluctl.output(aluCtr));
    // Line 5
    aluctl.input(funct, 4);
    EXPECT_EQ(0, aluctl.output(aluCtr));
    // Line 6
    aluctl.input(funct, 5);
    EXPECT_EQ(1, aluctl.output(aluCtr));
    // Line 7
    aluctl.input(funct, 10);
    EXPECT_EQ(7, aluctl.output(aluCtr));
}
