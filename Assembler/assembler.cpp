#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <algorithm>
using namespace std;

#define ll long long

map<string, string> opcode = {
    {"NOP", "0000000"},
    {"OUT", "0011000"},
    {"IN", "0011001"},
    {"PUSH", "0100110"},
    {"POP", "0100100"},
    {"STD", "1100010"},
    {"LDD", "1100000"},
    {"PROTECT", "0101000"},
    {"FREE", "0101000"},
    {"CALL", "0110000"},
    {"RET", "0110100"},
    {"RTI", "0110101"},
    {"JZ", "0111000"},
    {"JMP", "0111001"},
    {"NOT", "0010011"},
    {"NEG", "0010010"},
    {"INC", "0010000"},
    {"DEC", "0010001"},
    {"MOV", "0001111"},
    {"SWAP", "0001110"},
    {"ADD", "0001000"},
    {"SUB", "0001001"},
    {"AND", "0001011"},
    {"OR", "0001100"},
    {"XOR", "0001101"},
    {"CMP", "0001010"},
    {"ADDI", "1001000"},
    {"SUBI", "1001001"},
    {"LDM", "1001111"}};

map<string, string> registers = {
    {"R0", "000"},
    {"R1", "001"},
    {"R2", "010"},
    {"R3", "011"},
    {"R4", "100"},
    {"R5", "101"},
    {"R6", "110"},
    {"R7", "111"}};

int num_operands(string instr)
{
    if (instr == "NOP" || instr == "RET" || instr == "RTI")
        return 0;
    if (instr == "NOT" || instr == "NEG" || instr == "INC" || instr == "DEC" || instr == "OUT" || instr == "IN" || instr == "PUSH" || instr == "POP" || instr == "PROTECT" || instr == "FREE" || instr == "JZ" || instr == "JMP" || instr == "CALL")
        return 1;
    if (instr == "ADD" || instr == "ADDI" || instr == "SUB" || instr == "SUBI" || instr == "AND" || instr == "OR" || instr == "XOR")
        return 3;
    return 2;
}

bool checkNeedsR1(string instr)
{
    std::vector<string> temp{"OUT", "STD", "LDD", "PROTECT", "FREE", "CALL", "JZ", "JMP", "NOT", "NEG", "INC", "DEC", "SWAP", "ADD", "SUB", "AND", "OR", "XOR", "CMP", "ADDI", "SUBI"};
    return find(temp.begin(), temp.end(), instr) != temp.end();
}

bool checkNeedsR2(string instr)
{
    std::vector<string> temp{"PUSH", "STD", "MOV", "SWAP", "ADD", "SUB", "AND", "OR", "XOR", "CMP", "ADDI", "SUBI"};
    return find(temp.begin(), temp.end(), instr) != temp.end();
}

bool checkNeedsR3(string instr)
{
    std::vector<string> temp{"IN", "POP", "LDD", "NOT", "NEG", "INC", "DEC", "MOV", "SWAP", "ADD", "SUB", "AND", "OR", "XOR", "ADDI", "SUBI", "LDM"};
    return find(temp.begin(), temp.end(), instr) != temp.end();
}

string convertHexToBin(string hex)
{
    string bin = "";
    // if hex is less than 4 digits, add zeroes to the start to make it 4 hex digits -> 16 bits
    while (hex.size() < 4)
    {
        hex = "0" + hex;
    }
    for (int i = 0; i < hex.size(); i++)
    {
        switch (hex[i])
        {
        case '0':
            bin += "0000";
            break;
        case '1':
            bin += "0001";
            break;
        case '2':
            bin += "0010";
            break;
        case '3':
            bin += "0011";
            break;
        case '4':
            bin += "0100";
            break;
        case '5':
            bin += "0101";
            break;
        case '6':
            bin += "0110";
            break;
        case '7':
            bin += "0111";
            break;
        case '8':
            bin += "1000";
            break;
        case '9':
            bin += "1001";
            break;
        case 'A':
            bin += "1010";
            break;
        case 'B':
            bin += "1011";
            break;
        case 'C':
            bin += "1100";
            break;
        case 'D':
            bin += "1101";
            break;
        case 'E':
            bin += "1110";
            break;
        case 'F':
            bin += "1111";
            break;
        }
    }
    return bin;
}

string convertIntToHex(int n)
{
    string hex = "";
    if (n == 0)
        return "0";
    while (n)
    {
        int rem = n % 16;
        if (rem < 10)
            hex += (char)(rem + 48);
        else
            hex += (char)(rem + 87);
        n /= 16;
    }
    reverse(hex.begin(), hex.end());
    return hex;
}

ll convertHexToInt(string hex)
{
    ll num = 0;
    for (int i = 0; i < hex.size(); i++)
    {
        if (hex[i] >= '0' && hex[i] <= '9')
            num = num * 16 + (hex[i] - '0');
        else
            num = num * 16 + (hex[i] - 'A' + 10);
    }
    return num;
}

int main()
{
    string filename;
    cout << "Enter the filename (without extension): ";
    cin >> filename;
    std::ifstream fin(filename + ".txt");
    if (!fin)
    {
        cout << "Error opening file" << endl;
        return -1;
    }
    std::ofstream fout("output.txt");
    map<int, string> instructions; // Store the instructions for the mem file
    std::string line, curr_instr, curr_imm;
    bool flag;
    int count = 0, max_count = INT_MIN;
    while (getline(fin, line))
    {
        curr_instr = "", curr_imm = "", flag = false;
        // If the line contains '#' or is empty, ignore it
        if (line.size() == 0 || find(line.begin(), line.end(), '#') != line.end())
            continue;
        // Remove leading whitespaces
        line.erase(line.begin(), find_if(line.begin(), line.end(), [](int ch)
                                         { return !isspace(ch); }));
        // convert each letter to caps
        for (int i = 0; i < line.size(); i++)
        {
            if (line[i] >= 'a' && line[i] <= 'z')
                line[i] = toupper(line[i]);
        }
        // Get the instruction
        int index = line.find(' ');
        string instr = line.substr(0, index);
        // Remove all whitespaces from the line
        line.erase(remove_if(line.begin() + index, line.end(), ::isspace), line.end());
        if (instr == ".ORG")
        {
            count = convertHexToInt(line.substr(index, line.size() - index));
            continue;
        }
        if (opcode.find(instr) == opcode.end())
        {
            cout << "Invalid instruction: " << instr << endl;
            return -1;
        }
        // Get the opcode
        string op = opcode[instr];
        curr_instr += op;
        fout << line << endl
             << op << ' ';
        // Get the number of operands
        int n = num_operands(instr);
        if (n == 0)
        {
            fout << "000000000" << endl;
            curr_instr += "000000000";
            continue;
        }
        else if (n == 1)
        {
            string operand = line.substr(index, 2);
            if (registers.find(operand) == registers.end())
            {
                cout << "Invalid register: " << operand << endl;
                return -1;
            }
            string reg = registers[operand];
            fout << (checkNeedsR1(instr) ? reg : "000") << (checkNeedsR2(instr) ? reg : "000") << (checkNeedsR3(instr) ? reg : "000") << endl;
            curr_instr += (checkNeedsR1(instr) ? reg : "000") + (checkNeedsR2(instr) ? reg : "000") + (checkNeedsR3(instr) ? reg : "000");
        }
        else if (n == 2)
        {
            // Check if immediate instruction
            if (op[0] == '1')
            { // LDM, LDD, STD
                flag = true;
                string operand1 = line.substr(index, 2);
                string operand2 = line.substr(index + 3, line.size() - index - 3);
                if (registers.find(operand1) == registers.end())
                {
                    cout << "Invalid register: " << operand1 << endl;
                    return -1;
                }
                if (operand2.size() > 4)
                {
                    cout << "Invalid immediate value: " << operand2 << endl;
                    return -1;
                }
                string reg = registers[operand1];
                if (instr == "LDM")
                { // LDM Rdest, IMM -> 000 000 Rdest << endl << imm
                    fout << "000" << "000" << reg << endl
                         << convertHexToBin(operand2) << endl;
                    curr_instr += "000000" + reg;
                    curr_imm = convertHexToBin(operand2);
                }
                else
                {
                    // remove last 4 characters from operand2
                    string imm = operand2.substr(0, operand2.size() - 4);
                    string operand3 = operand2.substr(operand2.size() - 3, 2);
                    if (registers.find(operand3) == registers.end())
                    {
                        cout << "Invalid register: " << operand3 << endl;
                        return -1;
                    }
                    string reg2 = registers[operand3];
                    if (instr == "LDD")
                    { // LDD Rdest, EA(Rsrc1) -> Rsrc1 000 Rdest << endl << imm
                        fout << reg2 << "000" << reg << endl
                             << convertHexToBin(imm) << endl;
                        curr_instr += reg2 + "000" + reg;
                        curr_imm = convertHexToBin(imm);
                    }
                    else if (instr == "STD")
                    { // STD Rsrc1, EA(Rsrc2) -> Rsrc1 Rsrc2 000 << endl << imm
                        fout << reg << reg2 << "000" << endl
                             << convertHexToBin(imm) << endl;
                        curr_instr += reg + reg2 + "000";
                        curr_imm = convertHexToBin(imm);
                    }
                }
            }
            else
            { // MOV, SWAP, CMP
                string operand1 = line.substr(index, 2);
                string operand2 = line.substr(index + 3, 2);
                if (registers.find(operand1) == registers.end() || registers.find(operand2) == registers.end())
                {
                    cout << "Invalid register: " << operand1 << " or " << operand2 << endl;
                    return -1;
                }
                string reg1 = registers[operand1];
                string reg2 = registers[operand2];
                if (instr == "MOV")
                { // MOV Rdest, Rsrc1 -> 000 Rsrc1 Rdest
                    fout << "000" << reg2 << reg1 << endl;
                    curr_instr += "000" + reg2 + reg1;
                }
                else if (instr == "SWAP")
                { // SWAP Rsrc1, Rsrc2 -> Rsrc1 Rsrc2 Rsrc2
                    fout << reg1 << reg2 << reg2 << endl;
                    curr_instr += reg1 + reg2 + reg2;
                }
                else if (instr == "CMP")
                { // CMP Rsrc1, Rsrc2 -> Rsrc1 Rsrc2 000
                    fout << reg1 << reg2 << "000" << endl;
                    curr_instr += reg1 + reg2 + "000";
                }
            }
        }
        else
        {
            if (instr[0] == '1')
            { // ADDI, SUBI
                flag = true;
                string operand1 = line.substr(index, 2);
                string operand2 = line.substr(index + 3, 2);
                string operand3 = line.substr(index + 6, line.size() - index - 6);
                if (registers.find(operand1) == registers.end() || registers.find(operand2) == registers.end())
                {
                    cout << "Invalid register: " << operand1 << " or " << operand2 << endl;
                    return -1;
                }
                if (operand3.size() > 4)
                {
                    cout << "Invalid immediate value: " << operand3 << endl;
                    return -1;
                }
                string reg1 = registers[operand1];
                string reg2 = registers[operand2];
                // ADDI & SUBI Rdest, Rsrc1, IMM -> Rsrc1 000 Rdest << endl << imm
                fout << reg2 << "000" << reg1 << endl
                     << convertHexToBin(operand3) << endl;
                curr_instr += reg2 + "000" + reg1;
                curr_imm = convertHexToBin(operand3);
            }
            else
            { // ADD, SUB, AND, OR, XOR
                string operand1 = line.substr(index, 2);
                string operand2 = line.substr(index + 3, 2);
                string operand3 = line.substr(index + 6, 2);
                if (registers.find(operand1) == registers.end() || registers.find(operand2) == registers.end() || registers.find(operand3) == registers.end())
                {
                    cout << "Invalid register: " << operand1 << " or " << operand2 << " or " << operand3 << endl;
                    return -1;
                }
                string reg1 = registers[operand1];
                string reg2 = registers[operand2];
                string reg3 = registers[operand3];
                // ADD, SUB, AND, OR, XOR Rdest, Rsrc1, Rsrc2 -> Rsrc1 Rsrc2 Rdest
                fout << reg2 << reg3 << reg1 << endl;
                curr_instr += reg2 + reg3 + reg1;
            }
        }
        instructions[count++] = curr_instr;
        if (flag)
            instructions[count++] = curr_imm;
        max_count = max(max_count, count);
    }
    fin.close();
    fout.close();
    std::ofstream memfile("memfile.mem");
    memfile << "// memory data file (do not edit the following line - required for mem load use)" << endl
            << "// instance=/integration/Fetch1/InstructionCache1/inst" << endl
            << "// format=mti addressradix=h dataradix=b version=1.0 wordsperline=1" << endl;
    // std::sort(instructions.begin(), instructions.end());
    for (int i = 0; i < max_count + 5; i++)
        if (instructions.find(i) != instructions.end())
            memfile << convertIntToHex(i) << " : " << instructions[i] << endl;
        else
            memfile << convertIntToHex(i) << " : 0000000000000000" << endl;
    memfile.close();
}