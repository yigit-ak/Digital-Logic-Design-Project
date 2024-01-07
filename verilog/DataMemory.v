module DataMemory (
  input wire [9:0] address,
  input wire [17:0] data_input,
  input wire clock,
  input wire data_memo_str, // if 1, write, else read data
  output reg [17:0] data_output
);

  reg [17:0] memory [0:1023]; // 2^10 = 1024 locations, each with 18 bits of data

  always @(posedge clock) begin
      if (data_memo_str == 1) begin
        // Write
        memory[address] <= data_input; 
      end
	
	assign data_output = memory[address];
  end

endmodule

module tb_DataMemory();
  reg [9:0] address;
  reg [17:0] data_input;
  reg clock;
  reg data_memo_str; // if 1, write, else read data
  wire [17:0] data_output;
  
  DataMemory dataMemo(
    .address(address), .data_input(data_input), .clock(clock), .data_memo_str(data_memo_str), 
    .data_output(data_output)
  );
  

  // Test cases
  initial begin
    // Test 1: Write data to memory
    clock = 0;
    address = 10'b0000000000;
    data_input = 18'b101010101010101010;
    data_memo_str = 1; #3;
    clock = 1; #3;
    data_memo_str = 0; #3;

    // Test 2: Read data from memory
    clock = 0;
    address = 10'b0000000000;
    data_input = 18'b000000000000000000;
    clock = 1; #3;
    data_memo_str = 0; #3;

    // Test 3: Write and read different data
    clock = 0;
    address = 10'b0000000001;
    data_input = 18'b110011001100110011;#3;
    clock = 1;
    data_memo_str = 1;
    clock = 0; #3;
    data_memo_str = 0;#3;


    $finish;
  end
endmodule