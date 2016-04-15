#include "gtest/gtest.h"
#include "ctr.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(ctr, ctr)
{
    Ctr ctr;
    ctr.input(opCode, B("000000"));
    EXPECT_EQ(1, ctr.output(regWrite));
    EXPECT_EQ(0, ctr.output(branch));
    ctr.input(opCode, B("100011"));
    EXPECT_EQ(1, ctr.output(memRead));
    EXPECT_EQ(0, ctr.output(aluOp));
    ctr.input(opCode, B("101011"));
    EXPECT_EQ(1, ctr.output(ALUSrc));
    EXPECT_EQ(0, ctr.output(aluOp));
    ctr.input(opCode, B("000100"));
    EXPECT_EQ(1, ctr.output(aluOp));
    EXPECT_EQ(0, ctr.output(memWrite));
    ctr.input(opCode, B("000010"));
    EXPECT_EQ(1, ctr.output(jump));
    EXPECT_EQ(0, ctr.output(memWrite));
}
