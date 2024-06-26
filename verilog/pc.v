`timescale 1ns / 1ps
module PC (
  input signed [9:0] immediate,
  input wire clock,
  input wire enable,
  input wire load,
  input wire [2:0] jump_select,
  input wire ZF,
  input wire CF,
  output reg signed [9:0] pc_value
);

  always @(posedge clock) begin
    if (enable) begin
      case (jump_select)
        3'b000: pc_value <= 10'b0;
        3'b001: pc_value <= pc_value + immediate;
        3'b010: begin
                  if (ZF && !CF)
                    pc_value <= pc_value + immediate;
                  else
                    pc_value <= pc_value + 1;
                end
        3'b011: begin
                  if (!ZF && !CF)
                    pc_value <= pc_value + immediate;
                  else
                    pc_value <= pc_value + 1;
                end
        3'b100: begin
                  if (!ZF && CF)
                    pc_value <= pc_value + immediate;
                  else
                    pc_value <= pc_value + 1;
                end
        3'b101: begin
                  if (!CF)
                    pc_value <= pc_value + immediate;
                  else
                    pc_value <= pc_value + 1;
                end
        3'b110: begin
                  if (ZF && CF)
                    pc_value <= pc_value + immediate;
                  else
                    pc_value <= pc_value + 1;
                end
        3'b111: pc_value <= pc_value + 1;
        default: pc_value <= pc_value; // No change for invalid jump_select values
      endcase
    end
  end

endmodule

module tb_pc;
  reg [9:0] immediate;
  reg clock, enable, load, ZF, CF;
  reg [2:0] jump_select;
  wire [9:0] pc_value;
  
  PC pc(
    .immediate(immediate), .clock(clock), .enable(enable), .load(load), 
    .ZF(ZF), .CF(CF), .jump_select(jump_select), .pc_value(pc_value)
  );
  
  initial begin
    // Test case 1: set PC to zero (initialization)
    clock = 0;
    immediate = 10'b0;
    load = 1;
    enable = 1; 
    jump_select = 3'b000; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 2: unconditional jump #10
    clock = 0;
    immediate = 10'b1010;
    load = 1;
    enable = 1;
    jump_select = 3'b001; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 3: JE #10
    clock = 0;
    ZF = 1;
    CF = 0;
    immediate = 10'b1010;
    load = 1;
    enable = 1;
    jump_select = 3'b010; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 4: JA #10
    clock = 0;
    ZF = 0;
    CF = 0;
    immediate = 10'b1010;
    load = 1;
    enable = 1;
    jump_select = 3'b011; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 5: JB #10
    clock = 0;
    ZF = 0; 
    CF = 1;
    immediate = 10'b1010;
    load = 1;
    enable = 1;
    jump_select = 3'b100; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 6: JAE #10
    clock = 0;
    ZF = 1; 
    CF = 0;
    immediate = 10'b1010;
    load = 1;
    enable = 1;
    jump_select = 3'b101; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 7: JBE #10
    clock = 0;
    ZF = 1;
    CF = 1;
    immediate = 10'b1010;
    load = 1;
    enable = 1;
    jump_select = 3'b110; #5;
    clock = 1; #5;
    load = 0; #5;
    
    // Test case 8: PC++
    clock = 0;
    load = 1;
    enable = 1;
    jump_select = 3'b111; #5;
    clock = 1; #5;
    load = 0; #5;
    
    $finish;
  end
endmodule


