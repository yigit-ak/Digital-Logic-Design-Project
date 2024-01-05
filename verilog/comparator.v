module Comparator (
  output wire zero_flag,
  output wire carry_flag,
  input wire [17:0] number1,
  input wire [17:0] number2
);
  
  wire [17:0] borrow;
  wire [17:0] difference;
  
  wire w0, w1, w2, w3, w4;
  wire zero_flag_without_neg;
  
  // instantiate the LSB
  Subtractor subtractor_0 (
    .newCarry(borrow[0]), .result(difference[0]),
    .n1(number1[0]), .n2(number2[0]),
    .carry(1'b0)
  );

  Subtractor subtractor_1 (
    .newCarry(borrow[1]), .result(difference[1]),
    .n1(number1[1]), .n2(number2[1]),
    .carry(borrow[0])
  );

  Subtractor subtractor_2 (
    .newCarry(borrow[2]), .result(difference[2]),
    .n1(number1[2]), .n2(number2[2]),
    .carry(borrow[1])
  );
  
  Subtractor subtractor_3 (
    .newCarry(borrow[3]), .result(difference[3]),
    .n1(number1[3]), .n2(number2[3]),
    .carry(borrow[2])
  );
  
  or(w0, difference[0], difference[1], difference[2], difference[3]);
  
  Subtractor subtractor_4 (
    .newCarry(borrow[4]), .result(difference[4]),
    .n1(number1[4]), .n2(number2[4]),
    .carry(borrow[3])
  );
  
  Subtractor subtractor_5 (
    .newCarry(borrow[5]), .result(difference[5]),
    .n1(number1[5]), .n2(number2[5]),
    .carry(borrow[4])
  );
  
  Subtractor subtractor_6 (
    .newCarry(borrow[6]), .result(difference[6]),
    .n1(number1[6]), .n2(number2[6]),
    .carry(borrow[5])
  );
  
  Subtractor subtractor_7 (
    .newCarry(borrow[7]), .result(difference[7]),
    .n1(number1[7]), .n2(number2[7]),
    .carry(borrow[6])
  );
  
  or(w1, difference[4], difference[5], difference[6], difference[7]);
  
  Subtractor subtractor_8 (
    .newCarry(borrow[8]), .result(difference[8]),
    .n1(number1[8]), .n2(number2[8]),
    .carry(borrow[7])
  );
  
  Subtractor subtractor_9 (
    .newCarry(borrow[9]), .result(difference[9]),
    .n1(number1[9]), .n2(number2[9]),
    .carry(borrow[8])
  );
  
  Subtractor subtractor_10 (
    .newCarry(borrow[10]), .result(difference[10]),
    .n1(number1[10]), .n2(number2[10]),
    .carry(borrow[10])
  );
  
  Subtractor subtractor_11 (
    .newCarry(borrow[11]), .result(difference[11]),
    .n1(number1[11]), .n2(number2[11]),
    .carry(borrow[10])
  );
  
  or(w2, difference[8], difference[9], difference[10], difference[11]);
  
  Subtractor subtractor_12 (
    .newCarry(borrow[12]), .result(difference[12]),
    .n1(number1[12]), .n2(number2[12]),
    .carry(borrow[11])
  );
  
  Subtractor subtractor_13 (
    .newCarry(borrow[13]), .result(difference[13]),
    .n1(number1[13]), .n2(number2[13]),
    .carry(borrow[12])
  );
  
  Subtractor subtractor_14 (
    .newCarry(borrow[14]), .result(difference[14]),
    .n1(number1[14]), .n2(number2[14]),
    .carry(borrow[13])
  );
  
  Subtractor subtractor_15 (
    .newCarry(borrow[15]), .result(difference[15]),
    .n1(number1[15]), .n2(number2[15]),
    .carry(borrow[14])
  );
  
  or(w3, difference[12], difference[13], difference[14], difference[15]);
  
  Subtractor subtractor_16 (
    .newCarry(borrow[16]), .result(difference[16]),
    .n1(number1[16]), .n2(number2[16]),
    .carry(borrow[15])
  );
  
  Subtractor subtractor_17 (
    .newCarry(borrow[17]), .result(difference[17]),
    .n1(number1[17]), .n2(number2[17]),
    .carry(borrow[16])
  );
  
  or(w4, difference[16], difference[17]);
  
  // set flags
  assign zero_flag_without_neg = |{w0, w1, w2, w3, w4};
  assign zero_flag = ~zero_flag_without_neg;
  assign carry_flag = borrow[17] & zero_flag_without_neg;
endmodule
 
module tb_Comparator;

  reg [17:0] number1, number2;
  wire zero_flag, carry_flag;

  initial begin
    // Test 1: number1 > number2 (zero_flag = 0, carry_flag = 0)
    number1 = 18'b101010101010101010;
    number2 = 18'b010101010101010101;
    #10;
    
    // Test 2: number1 < number2 (zero_flag = 0, carry_flag = 1)
    number1 = 18'b010101010101010101;
    number2 = 18'b101010101010101010;
    #10;

    // Test 3: number1 == number2 (expecting zero_flag = 1, carry_flag = 0)
    number1 = 18'b110011001100110011;
    number2 = 18'b110011001100110011;
    #10;

    $finish;
  end
  
  // Instantiate the Comparator module
  Comparator comp (
    .zero_flag(zero_flag),
    .carry_flag(carry_flag),
    .number1(number1),
    .number2(number2)
  );
  
endmodule