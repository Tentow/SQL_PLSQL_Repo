Script started on 2024-10-04 20:36:25+00:00 [TERM="xterm-256color" TTY="/dev/pts/0" COLUMNS="219" LINES="15"]
[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ cat payrollcasestudy.cpp
#include <iostream>
#include <fstream>
#include <iomanip>  // for formatted output
#include <string>
#include <vector>

using namespace std;

// Structure to hold employee data
struct Employee {
    string name;
    string id;
    vector<int> hoursWorked;
    float hourlyWage;
    int deductions;
};

// Function prototypes
Employee readEmployeeData(ifstream& infile);
bool validateHours(const vector<int>& hoursWorked);
float calculateTotalSalary(const vector<int>& hoursWorked, float hourlyWage);
float calculateWithholding(float totalSalary, int deductions);
void generatePayStub(const Employee& emp, float totalHours, float totalSalary, float withholding, float netSalary);

// Main program function
int main() {
    ifstream infile("payroll_data.txt");
    ofstream outfile("pay_stubs.txt");
    
    if (!infile.is_open() || !outfile.is_open()) {
        cerr << "Error: Unable to open file." << endl;
        return 1;
    }

    // Process each employee record
    while (!infile.eof()) {
        Employee emp = readEmployeeData(infile);
        
        // Validate employee hours
        if (!validateHours(emp.hoursWorked)) {
            outfile << "Error: Invalid hours worked for employee " << emp.name << endl;
            continue;  // Skip to next record
        }

        // Calculate total hours worked, salary, withholding, and net salary
        float totalHours = 0;
        for (int hours : emp.hoursWorked) totalHours += hours;
        float totalSalary = calculateTotalSalary(emp.hoursWorked, emp.hourlyWage);
        float withholding = calculateWithholding(totalSalary, emp.deductions);
        float netSalary = totalSalary - withholding;

        // Generate pay stub
        generatePayStub(emp, totalHours, totalSalary, withholding, netSalary);
    }

    infile.close();
    outfile.close();
    return 0;
}

// Function to read employee data from input file
Employee readEmployeeData(ifstream& infile) {
    Employee emp;
    infile >> emp.name >> emp.id;
    for (int i = 0; i < 5; i++) {
        int hours;
        infile >> hours;
        emp.hoursWorked.push_back(hours);
    }
    infile >> emp.hourlyWage >> emp.deductions;
    return emp;
}

// Function to validate hours worked
bool validateHours(const vector<int>& hoursWorked) {
    for (int hours : hoursWorked) {
        if (hours < 0 || hours > 16) return false;
    }
    return true;
}

// Function to calculate total salary
float calculateTotalSalary(const vector<int>& hoursWorked, float hourlyWage) {
    float totalHours = 0;
    for (int hours : hoursWorked) totalHours += hours;
    return totalHours * hourlyWage;
}

// Function to calculate withholding
float calculateWithholding(float totalSalary, int deductions) {
    const float WITHHOLDING_RATE = 0.10;
    return totalSalary * WITHHOLDING_RATE * deductions;
}

// Function to generate and print pay stub
void generatePayStub(const Employee& emp, float totalHours, float totalSalary, float withholding, float netSalary) {
    ofstream outfile("pay_stubs.txt", ios::app);
    outfile << left << setw(20) << emp.name 
            << setw(8) << emp.id
            << setw(6) << totalHours
            << setw(8) << fixed << setprecision(2) << totalSalary
            << setw(8) << withholding
            << setw(8) << netSalary
            << endl;
    outfile.close();
}
[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ g++ -o payrollcasestudy payrollcasestudy.cpp
[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ ./payrollcasestudy
Error: Unable to open file.
[0;32m@dkubuo [1;31m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ ./payrollcasestudyg++ -o payrollcasestudy payrollcasestudy.cpp[20Pcat[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C[C
Script started on 2024-10-04 20:36:25+00:00 [TERM="xterm-256color" TTY="/dev/pts/0" COLUMNS="219" LINES="15"]
[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ cat payrollcasestudy.cpp
#include <iostream>
#include <fstream>
#include <iomanip>  // for formatted output
#include <string>
#include <vector>

using namespace std;

// Structure to hold employee data
struct Employee {
    string name;
    string id;
    vector<int> hoursWorked;
    float hourlyWage;
    int deductions;
};

// Function prototypes
Employee readEmployeeData(ifstream& infile);
bool validateHours(const vector<int>& hoursWorked);
float calculateTotalSalary(const vector<int>& hoursWorked, float hourlyWage);
float calculateWithholding(float totalSalary, int deductions);
void generatePayStub(const Employee& emp, float totalHours, float totalSalary, float withholding, float netSalary);

// Main program function
int main() {
    ifstream infile("payroll_data.txt");
    ofstream outfile("pay_stubs.txt");
    
    if (!infile.is_open() || !outfile.is_open()) {
        cerr << "Error: Unable to open file." << endl;
        return 1;
    }

    // Process each employee record
    while (!infile.eof()) {
        Employee emp = readEmployeeData(infile);
        
        // Validate employee hours
        if (!validateHours(emp.hoursWorked)) {
            outfile << "Error: Invalid hours worked for employee " << emp.name << endl;
            continue;  // Skip to next record
        }

        // Calculate total hours worked, salary, withholding, and net salary
        float totalHours = 0;
        for (int hours : emp.hoursWorked) totalHours += hours;
        float totalSalary = calculateTotalSalary(emp.hoursWorked, emp.hourlyWage);
        float withholding = calculateWithholding(totalSalary, emp.deductions);
        float netSalary = totalSalary - withholding;

        // Generate pay stub
        generatePayStub(emp, totalHours, totalSalary, withholding, netSalary);
    }

    infile.close();
    outfile.close();
    return 0;
}

// Function to read employee data from input file
Employee readEmployeeData(ifstream& infile) {
    Employee emp;
    infile >> emp.name >> emp.id;
    for (int i = 0; i < 5; i++) {
        int hours;
        infile >> hours;
        emp.hoursWorked.push_back(hours);
    }
    infile >> emp.hourlyWage >> emp.deductions;
    return emp;
}

// Function to validate hours worked
bool validateHours(const vector<int>& hoursWorked) {
    for (int hours : hoursWorked) {
        if (hours < 0 || hours > 16) return false;
    }
    return true;
}

// Function to calculate total salary
float calculateTotalSalary(const vector<int>& hoursWorked, float hourlyWage) {
    float totalHours = 0;
    for (int hours : hoursWorked) totalHours += hours;
    return totalHours * hourlyWage;
}

// Function to calculate withholding
float calculateWithholding(float totalSalary, int deductions) {
    const float WITHHOLDING_RATE = 0.10;
    return totalSalary * WITHHOLDING_RATE * deductions;
}

// Function to generate and print pay stub
void generatePayStub(const Employee& emp, float totalHours, float totalSalary, float withholding, float netSalary) {
    ofstream outfile("pay_stubs.txt", ios::app);
    outfile << left << setw(20) << emp.name 
            << setw(8) << emp.id
            << setw(6) << totalHours
            << setw(8) << fixed << setprecision(2) << totalSalary
            << setw(8) << withholding
            << setw(8) << netSalary
            << endl;
    outfile.close();
}
[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ g++ -o payrollcasestudy payrollcasestudy.cpp
[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ ./payrollcasestudy
Error: Unable to open file.
[0;32m@dkubuo [1;31m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ ./payrol[0;32m@dkubuo [0m➜ [1;34m/workspaces/SQL_PLSQL_Repo/SCSU/CSCI201 [0;36m([1;31mmain[0;36m) [0m$ cat payrollcasestudy.cpp[6P./payrollcasestudycat payrollcasestudy.cpp[Kexit
exit

Script done on 2024-10-04 20:52:06+00:00 [COMMAND_EXIT_CODE="0"]
