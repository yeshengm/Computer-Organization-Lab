
#include "gtest/gtest.h"
#include "reg.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(reg, reg)
{
	Reg reg;
	reg.input(regWrite, 1);
	reg.input(writeReg, 2);
	reg.input(writeData, 4);
	reg.input(clock_in, 1);
	reg.input(readReg1, 2);
	EXPECT_EQ(4, reg.output(readData1));
	reg.input(regWrite, 1);
	reg.input(writeReg, 2);
	reg.input(writeData, 2);
	// No clock_in
	reg.input(readReg1, 2);
	EXPECT_EQ(4, reg.output(readData1));
}
