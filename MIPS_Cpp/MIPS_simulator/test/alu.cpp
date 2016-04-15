#include "gtest/gtest.h"
#include "alu.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(alu, math)
{
    ALU alu;
    alu.input(input1, 6);
    alu.input(input2, 3);
    // And
    alu.input(aluCtr, 0);
    EXPECT_EQ(2, alu.output(aluRes));
    // Or
    alu.input(aluCtr, 1);
    EXPECT_EQ(7, alu.output(aluRes));
    // Add
    alu.input(aluCtr, 2);
    EXPECT_EQ(9, alu.output(aluRes));
    // Sub
    alu.input(aluCtr, 6);
    EXPECT_EQ(3, alu.output(aluRes));
    alu.input(input2, 6);
    EXPECT_EQ(1, alu.output(zero));
    alu.input(input2, 3);
    // Set on less than
    alu.input(aluCtr, 7);
    EXPECT_EQ(0, alu.output(aluRes));
    alu.input(input1, 1);
    EXPECT_EQ(1, alu.output(aluRes));
    // Nor
    alu.input(input1, 3);
    alu.input(input2, 4);
    alu.input(aluCtr, 12);
    EXPECT_EQ(~7, alu.output(aluRes));
    // Zero
}
