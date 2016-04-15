#include <string>
#include <fstream>
#include "memory.hpp"
#include "parser.hpp"
using std::string;
using std::ifstream;
namespace MIPS {
struct Register {
    enum {REG, RELATIVE} address_method;
    int regNum;
    int immData;
}
struct Instrcution {
    string op;
    enum {RTYPE, ITYPE, JTYPE} type;
    Register reg1;
    Register reg2;
    Register reg3;
    int imm;
}

bool ch(char *&str, char c)
{
    // Look ahear
    // Jump all white spaces
    if (c != ' ')
    {
	while (*str && *str == ' ') str++;
    }
    if (*str == c)
    {
	str++;
	return true;
    }
    return false;
}

int Int(char *&str)
{
    int flag = 1;
    if (ch(str, '-'))
	flag = -1;
    char *endPtr = NULL;
    int num = strtol(str, &endPtr, 10);
    return num;
}

Register parserReg(char *&str)
{
    Register r;
    if (ch(str, 'r'))
    {
	r.address_method = REG;
	r.regNum = Int(str);
    }
    else
    {
	r.address_method = RELATIVE;
	r.immData = Int(str);
	ch(str, '(');
	ch(str, 'r');
	r.regNum = Int(str);
	ch(str, ')');
    }
    return r;
}

Instrcution parser(char *str)
{
    Instrcution result;
    // Jump whitespace
    while (ch(str, ' '));
    // Get opcode
    result.op.push_back(*str);
    while (!ch(str, ' '))
    {
	result.op.push_back(*str);
    }
    if (result.op == "lw" || result.op == "sw" || result.op.find_last_of('i') != result.op.end() || result[0] == 'b')
    {
	result.type = ITYPE;
    }
    else if (result.op == "j")
    {
	result.type == JTYPE;
    }
    else
    {
	result.type = RTYPE;
    }
    // Get register
    result.reg1 = parserReg(str);
    ch(str, ',');
    result.reg2 = parserReg(str);
    if (result.type == ITYPE)
    {
	result.imm = result.reg2.immData;
    }
    if (ch(str, ','))
    {
	result.reg3 = parserReg(str);
	if (result.type == ITYPE)
	{
	    result.imm = result.reg3.immData;
	}
    }
    return result;
}

string Int2Binary(int data, int len = 5)
{
    string result = "";
    for (int i = 0 ; i != len ; ++i)
    {
	if (data & (1 << i))
	{
	    result = "1" + result;
	}
	else
	{
	    result = "0" + result;
	}
    }
    return result;
}

#define CASE(a, b) if (inst == #a) return #b
string getOpCode(string inst)
{
    CASE(add, 000000);
    CASE(addi, 001000);
    CASE(sub, 000000);
    CASE(lw, 100011);
    CASE(sw, 101011);
    CASE(j, 000010);
    CASE(beq, 000100);
}
#undef CASE

void Builder(string codeFile, string memFile, Memory instMem, Memory dataMem)
{
    ifstream file(codeFile);
    string temp;
    int addr = 0;
    while (getline(file, temp))
    {
	Instrcution inst = parser(temp.c_str());
	string instStr = "";
	switch (inst.type)
	{
	    case RTYPE:
		string funct = "00000100000";
		if (inst.op == "sub")
		{
		    funct = "00000100010"
		}
		instStr = getOpCode(inst.op) + Int2Binary(inst.reg2.regNum) + Int2Binary(inst.reg3.regNum)
		        + Int2Binary(inst.reg1.regNum) + funct;
		break;
	    case ITYPE:
		instStr = getOpCode(inst.op) + Int2Binary(inst.reg2.regNum) + Int2Binary(inst.reg1.regNum)
		        + Instrcution(inst.imm, 16);
		break;
	    case JTYPE:
		instStr = getOpCode(inst.op) + Int2Binary(inst.reg1.immData, 26);
		break;
	}
	instMem.loadMemory(addr, B(instStr.c_str()));
	addr = addr + 4;
    }
}

}
