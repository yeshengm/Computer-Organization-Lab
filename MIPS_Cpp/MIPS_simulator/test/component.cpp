#include "gtest/gtest.h"
#include "component.hpp"
#include <stdio.h>
using namespace MIPS;
using std::string;

class A: public BaseComponent {
public:
	virtual void onChange()
	{
		for (auto it = in.begin() ; it != in.end() ; ++it)
		{
			setOutput(it->first, it->second);
		}
	}
	EventListener getListener(string name)
	{
		return [=](LineData data){
			this->setOutput(name, data);
		};
	}
};

TEST(component, bind)
{
	A a1, a2, a3;
	a1.bind("a1testsin", a2.getListener("a2testsin"));
	a1.bind("a1testmul", a2.getListener("a2testmul"));
	a1.bind("a1testmul", a3.getListener("a3testmul"));
	a1.input("a1testsin", 1);
	a1.input("a1testmul", 2);
	EXPECT_EQ(1, a2.output("a2testsin"));
	EXPECT_EQ(2, a2.output("a2testmul"));
	EXPECT_EQ(2, a3.output("a3testmul"));
}
