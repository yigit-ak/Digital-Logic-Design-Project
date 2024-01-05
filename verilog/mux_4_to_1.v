`timescale 1ns / 1ns

module FourToOneMux
  (
    output wire [17:0] out,
    input wire [17:0] a,
    input wire [17:0] b,
    input wire [17:0] c,
    input wire [17:0] d,
    input wire [1:0] select_bit 
  );
  
  assign out = select_bit[1]? (select_bit[0]? d:c) : (select_bit[0]? b:a);
endmodule

module tb_FourToOneMux;

  // Inputs
  reg [17:0] a, b, c, d;
  reg [1:0] select_bit;

  // Outputs
  wire [17:0] out;

  // Continuous stimulus generation using always block
  initial begin
    // Test case 1: select_bit = 2'b00
    a = 18'h1234;
    b = 18'h5678;
    c = 18'h9abc;
    d = 18'hdef0;
    select_bit = 2'b00;
    #50; // Wait for 50 time units

    // Test case 2: select_bit = 2'b01
    a = 18'h1234;
    b = 18'h5678;
    c = 18'h9abc;
    d = 18'hdef0;
    select_bit = 2'b01;
    #50; // Wait for 50 time units

    // Test case 3: select_bit = 2'b10
    a = 18'h1234;
    b = 18'h5678;
    c = 18'h9abc;
    d = 18'hdef0;
    select_bit = 2'b10;
    #50; // Wait for 50 time units

    // Test case 4: select_bit = 2'b11
    a = 18'h1234;
    b = 18'h5678;
    c = 18'h9abc;
    d = 18'hdef0;
    select_bit = 2'b11;
    #50; // Wait for 50 time units

    // End simulation
    $finish;
  end
  
  FourToOneMux uut (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .select_bit(select_bit),
    .out(out)
  );

endmodule