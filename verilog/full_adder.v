module FullAdder(
  input wire a, b, carryIn,
  output wire sum, carryOut
);

wire a1, a2, a3;
and A1(a1, a, b);
and A2(a2, b, carryIn);
and A3(a3, a, carryIn);
xor A4(sum, a, b, carryIn);
or A5(carryOut, a1, a2, a3);
endmodule

module tb_FullAdder;
reg a, b, carryIn;
wire sum, carryOut;

FullAdder dut(.a(a), .b(b), .carryIn(carryIn), .sum(sum), .carryOut(carryOut));
initial begin
a = 1'b0;
b = 1'b0;
carryIn = 1'b0;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b1;
b = 1'b0;
carryIn = 1'b0;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b0;
b = 1'b1;
carryIn = 1'b0;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b1;
b = 1'b1;
carryIn = 1'b0;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b0;
b = 1'b0;
carryIn = 1'b1;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b1;
b = 1'b0;
carryIn = 1'b1;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b0;
b = 1'b1;
carryIn = 1'b1;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);

a = 1'b1;
b = 1'b1;
carryIn = 1'b1;
#3
$display("The sum of two inputs %b and %b and carryIn %b is %b and carryOut is %b", a, b, carryIn, sum, carryOut);
#3

$finish;
end
endmodule