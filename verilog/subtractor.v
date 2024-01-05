`timescale 1ns / 1ps

module Subtractor(
  output wire newCarry, result,
  input wire n1, n2, carry
);
wire x1, x2, x3, x4;

xor A1(x1, n1, n2);
xor A2(result, x1, carry);
not A3(n1_n, n1);
and A4(x2, n1_n, carry);
and A5(x3, n1_n, n2);
and A6(x4, n2, carry);
or A7(newCarry, x2, x3, x4);
endmodule 

module tb_Subtractor;
  wire newCarry;
  wire result;
  reg n1, n2;
  reg carry;

  initial begin
    // Test 1: n1 > n2 (newCarry = 0, result = 1)
    n1 = 1;
    n2 = 0;
    carry = 0;
    #10;

    // Test 2: n1 < n2 (newCarry = 1, result = 1)
    n1 = 0;
    n2 = 1;
    carry = 0;
    #10;

    // Test 3: n1 == n2 (newCarry = 1, result = 1) if carry = 1
    n1 = 1;
    n2 = 1;
    carry = 1;
    #10;
    
    // Test 4: n1 == n2 (newCarry = 0, result = 0) if carry = 0
    n1 = 1;
    n2 = 1;
    carry = 0;
    #10;

    $finish;
  end
  
  // Instantiate the Subtractor module
  Subtractor subtractor (
    .newCarry(newCarry),
    .result(result),
    .n1(n1),
    .n2(n2),
    .carry(carry)
  );
endmodule