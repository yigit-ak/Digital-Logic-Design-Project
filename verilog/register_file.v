module register_file (
  input [17:0] data_to_write,
  input [3:0] reg_to_write,
  input [3:0] reg_to_read1,
  input [3:0] reg_to_read2,
  input clock,
  input enable,
  input load,
  output reg [17:0] data_to_read1,
  output reg [17:0] data_to_read2
);

  reg [17:0] registers [15:0];

  always @(posedge clock) begin
    if (enable) begin
      if (load) begin
        registers[reg_to_write] <= data_to_write;
      end
      data_to_read1 <= registers[reg_to_read1];
      data_to_read2 <= registers[reg_to_read2];
    end
  end

endmodule
