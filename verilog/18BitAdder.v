`timescale 1ns / 1ps
module bit18Adder(
input [17:0] operand1,
input [17:0] operand2,
output [17:0] sum,
output carryOut
);
assign carryIn = 0;
wire w1, w2, w3, w4, w5, w6, w7, w8;
twoBitAdder tb1(operand1[1:0], operand2[1:0], carryIn, sum[1:0], w1);
twoBitAdder tb2(operand1[3:2], operand2[3:2], w1, sum[3:2], w2);
twoBitAdder tb3(operand1[5:4], operand2[5:4], w2, sum[5:4], w3);
twoBitAdder tb4(operand1[7:6], operand2[7:6], w3, sum[7:6], w4);
twoBitAdder tb5(operand1[9:8], operand2[9:8], w4, sum[9:8], w5);
twoBitAdder tb6(operand1[11:10], operand2[11:10], w5, sum[11:10], w6);
twoBitAdder tb7(operand1[13:12], operand2[13:12], w6, sum[13:12], w7);
twoBitAdder tb8(operand1[15:14], operand2[15:14], w7, sum[15:14], w8);
twoBitAdder tb9(operand1[17:16], operand2[17:16], w8, sum[17:16], carryOut);
endmodule


module bit18Adder_tb();
reg [17:0] operand1;
reg [17:0] operand2;
wire [17:0] sum;
wire carryOut;

bit18Adder dut(.operand1(operand1), .operand2(operand2), .sum(sum), .carryOut(carryOut));

initial begin
// Test1
operand1 = 18'b111111111111111111;
operand2 = 18'b111111111111111111;
#10

// Test2
operand1 = 18'b111111111000000000;
operand2 = 18'b000111111111111111;
#10

// Test2
operand1 = 18'b111111111000111000;
operand2 = 18'b000111000000111111;
#10
$stop();
end
endmodule 