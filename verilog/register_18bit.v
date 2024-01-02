module register_18bit (
  input [17:0] data_input,
  input enable,
  input load,
  input clock,
  output reg [17:0] output_data
);

  always @(posedge clock) begin
    if (enable) begin
      if (load) begin
        output_data <= data_input;
      end
    else begin
        output_data <= 18'b0;
      end
    end
  end

endmodule
