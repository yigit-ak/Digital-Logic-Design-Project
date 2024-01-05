module ALU
  (
    output wire [17:0] result, 
    output wire carryOut,
    input wire [17:0] a,
    input wire [17:0] b, 
    input wire [1:0] select
  );
  
  wire [17:0] w0, w1, w2, w3;
  
  bit18Adder adder(
    .operand1(a), .operand2(b), .carryOut(carryOut), .sum(w0)
  );
  
  // and 
  assign w1 = (a & b);
  
  // nand
  assign w2 = ~(a & b);
  
  //nor
  assign w3 = ~(a | b);
  
  FourToOneMux mux(
    .a(w0), .b(w1), .c(w2), .d(w3), .select_bit(select), .out(result)
  );
  
endmodule

module tb_ALU;
  
  reg [17:0] a, b;
  reg [1:0] s;
  wire [17:0] result;
  wire carryOut;
  

  // Initial block for simulation
  initial begin
    // Case 1: select bit = 00, perform adder with arbitrary values resulting in carry out
    a = 18'b110110000010101000;
    b = 18'b110001111101010001;
    s = 2'b00;
    #10;
  
    // Case 2: select = 01, AND
    a = 18'b001100101010101000;
    b = 18'b001011011011100111;
    s = 2'b01;
    #10;
  
    // Case 3: select = 10, NAND
    a = 18'b111000010101010110;
    b = 18'b100110010110101011;
    s = 2'b10;
    #10;
  
    // Case 4: select = 11, NOR
    a = 18'b111000010101010110;
    b = 18'b100110010110101011;
    s = 2'b11;
    #10;
  
    $finish;
  end
  
  // Instantiate the ALU module
  ALU alu(
    .result(result), .carryOut(carryOut), .a(a), .b(b), .select(s)
  );
  
endmodule