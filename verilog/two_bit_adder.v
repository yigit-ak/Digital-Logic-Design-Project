`timescale 1ns / 1ps

module twoBitAdder(
  input wire [1:0] a,
  input wire [1:0] b,
  input wire carryIn,
  output wire [1:0] sum,
  output wire carryOut
);
  wire w1;
  FullAdder fa1(.a(a[0]), .b(b[0]), .carryIn(carryIn), .sum(sum[0]), .carryOut(w1)); 
  FullAdder fa2(.a(a[1]), .b(b[1]), .carryIn(w1), .sum(sum[1]), .carryOut(carryOut));
endmodule

module tb_twoBitAdder;
  reg [1:0] a, b;
  reg carryIn;
  wire [1:0] sum;
  wire carryOut;
  
  initial begin
    // Test case 1: 00 + 11 -> sum = 11, carryOut = 0
    a[1] = 0; a[0] = 0;
    b[1] = 1; b[0] = 1;
    carryIn = 0;
    #10;
    
    // Test case 2: 11 + 01 -> sum = 00, carryOut = 1
    a[1] = 1; a[0] = 1;
    b[1] = 0; b[0] = 1;
    carryIn = 0;
    #10;
    
    // Test  case 3: 11 + 10 -> sum = 01, carryOut = 1
    a[1] = 1; a[0] = 1;
    b[1] = 1; b[0] = 0;
    carryIn = 0;
    #10;
    
    // Test case 4: 11 + 11 -> sum = 10, carryOut = 1
    a[1] = 1; a[0] = 1;
    b[1] = 1; b[0] = 1;
    carryIn = 0;
    #10;
    
    // Test case 5: 00 + 11 with carryIn = 1 -> sum = 00, carryOut = 1
    a[1] = 0; a[0] = 0;
    b[1] = 1; b[0] = 1;
    carryIn = 1;
    #10;
    
    // Test case 6: 11 + 01 -> sum = 01, carryOut = 1
    a[1] = 1; a[0] = 1;
    b[1] = 0; b[0] = 1;
    carryIn = 1;
    #10;
    
    // Test  case 7: 11 + 10 -> sum = 10, carryOut = 1
    a[1] = 1; a[0] = 1;
    b[1] = 1; b[0] = 0;
    carryIn = 1;
    #10;
    
    // Test case 8: 11 + 11 -> sum = 11, carryOut = 1
    a[1] = 1; a[0] = 1;
    b[1] = 1; b[0] = 1;
    carryIn = 1;
    #10 
    
    $finish;
  end
  
  twoBitAdder adder2Bit(
    .a(a), .b(b), .carryIn(carryIn), .sum(sum), .carryOut(carryOut)
  );
endmodule