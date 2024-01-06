`timescale 1ns / 1ps
module instructionMemory(
// Input
input [17:0] hexAddress,
// Output
output [17:0] dataO
);
reg [17:0] mem[0:262143];
// file of input data
parameter data_file = "C:/Users/Servisport/output.txt";

// Read data from txt file
integer i;
initial begin
$readmemh(data_file, mem);
end
// Assign output to be data in particular address
assign dataO = mem[hexAddress];
endmodule

// Testbench
module instructionMemory_tb();
reg [17:0] hexAddress;
wire [17:0] dataO;

instructionMemory dut(.hexAddress(hexAddress), .dataO(dataO));

initial begin
// Test1
hexAddress = 18'b000000000000000000;
#3

// Test2
hexAddress = 18'b000000000000000001;
#3

// Test3
hexAddress = 18'b000000000000000010;
#3

// Test4
hexAddress = 18'b000000000000000011;
#3

// Test5
hexAddress = 18'b000000000000000100;
#3

// Test6
hexAddress = 18'b000000000000000101;
#3

// Test7
hexAddress = 18'b000000000000000110;
#3

// Test8
hexAddress = 18'b000000000000000111;
#3

// Test9
hexAddress = 18'b000000000000001000;
#3

// Test10
hexAddress = 18'b000000000000001001;
#3

// Test11
hexAddress = 18'b000000000000001010;
#3

// Test12
hexAddress = 18'b000000000000001011;
#3

// Test13
hexAddress = 18'b000000000000001100;
#3

// Test14
hexAddress = 18'b000000000000001101;
#3

// Test15
hexAddress = 18'b000000000000001110;
#3
$stop();
end
endmodule 
