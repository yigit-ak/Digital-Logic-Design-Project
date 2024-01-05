module HalfAdder(
  output wire sum, carryOut,
  input wire a, b
);

xor A1(sum, a, b);
and A2(carryOut, a, b);
endmodule

module tb_HalfAdder;
  reg a, b;
  wire sum, carryOut;

  HalfAdder dut(.a(a), .b(b), .sum(sum), .carryOut(carryOut));
  initial begin
  a = 1'b0;
  b = 1'b0;
  #3
  $display("The sum of two inputs %b and %b is %b and carryOut is %b", a, b, sum, carryOut);

  a = 1'b1;
  b = 1'b0;
  #3
  $display("The sum of two inputs %b and %b is %b and carryOut is %b", a, b, sum, carryOut);

  a = 1'b0;
  b = 1'b1;
  #3
  $display("The sum of two inputs %b and %b is %b and carryOut is %b", a, b, sum, carryOut);

  a = 1'b1;
  b = 1'b1;
  #3
  $display("The sum of two inputs %b and %b is %b and carryOut is %b", a, b, sum, carryOut);
  $finish;
  end
endmodule