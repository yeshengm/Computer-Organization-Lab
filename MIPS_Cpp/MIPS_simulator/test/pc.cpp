#include "gtest/gtest.h"
#include "pc.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(pc, pc)
{
	PC pc(0);
	pc.clock();
	EXPECT_EQ(4, pc.output(newPC));
	pc.input(immData, -1);
	pc.clock();
	EXPECT_EQ(8, pc.output(newPC));
	pc.input(zero, 1);
	pc.input(branch, 1);
	pc.clock();
	EXPECT_EQ(8, pc.output(newPC));
}
