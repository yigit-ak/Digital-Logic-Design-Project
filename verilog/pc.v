module PC (
  input signed [9:0] immediate,
  input clock,
  input enable,
  input load,
  input [2:0] jump_select,
  input ZF,
  input CF,
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

  always @(posedge clock or posedge enable) begin
    if (load && enable)
      pc_value <= 10'b0; // Reset PC value when load is asserted
  end

endmodule
