#include "gtest/gtest.h"
#include "other.hpp"
#include "env.hpp"
#include <stdio.h>
using namespace MIPS;
using namespace Env;
using std::string;

TEST(other, mux)
{
	Multiplexer mux;
	mux.input(input1, 12);
	mux.input(input2, 20);
	mux.input(input3, 13);
	mux.input(input4, 10);
	mux.input(muxSel, 0);
	EXPECT_EQ(12, mux.output(muxOut));
	mux.input(muxSel, 1);
	EXPECT_EQ(20, mux.output(muxOut));
	mux.input(muxSel, 2);
	EXPECT_EQ(13, mux.output(muxOut));
	mux.input(muxSel, 3);
	EXPECT_EQ(10, mux.output(muxOut));
}

TEST(other, sign)
{
	SignExtener sign;
	sign.input(immInput, 7);
	EXPECT_EQ(7, sign.output(immData));
	sign.input(immInput, 0xFFF9);
	EXPECT_EQ(-7, sign.output(immData));
}
