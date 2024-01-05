`timescale 1ns / 1ps

module register_18bit (
  input reg [17:0] data_input,
  input reg enable,
  input reg load,
  input reg clock,
  output reg [17:0] output_data
);

always @(posedge clock) begin
  if (enable && load) begin
    output_data <= data_input;
  end else begin
    output_data <= 18'b000000000000000000;
  end
end

endmodule

module tb_register_18bit;
  reg [17:0] data_input;
  reg enable, load, clock;
  wire [17:0] output_data;
  
  register_18bit register(
    .data_input(data_input), .enable(enable), .load(load), .clock(clock), .output_data(output_data)
  );
  
  initial begin
    // Test 0: Initialize the register to zeros
    load = 0;
    enable = 0;
    clock = 0;
    #5 clock = 1;
    #5;
  	 
    // Test 1: Load data_input when enable and load are high
    enable = 1;
    load = 1;
    data_input = 18'b101010101010101010;
    clock = 0;
    #5 clock = 1; // Rising edge, trigger the register

    // Test 2: Clear the register when enable is high and load is low
    load = 0;
    enable = 0;
    #5 clock = 0;
    #5 clock = 1;

    // Test 3: Load new data when enable and load are high
    load = 1;
    enable = 1;
    data_input = 18'b110011001100110011;
    #5 clock = 0;
    #5 clock = 1;

    $finish;
  end
endmodule