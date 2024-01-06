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

module register_file_tb();

  reg [17:0] data_to_write;
  reg [3:0] reg_to_write;
  reg [3:0] reg_to_read1;
  reg [3:0] reg_to_read2;
  reg clock;
  reg enable;
  reg load;
  wire [17:0] data_to_read1;
  wire [17:0] data_to_read2;

register_file dut(.data_to_write(data_to_write), .reg_to_write(reg_to_write), .reg_to_read1(reg_to_read1),
.reg_to_read2(reg_to_read2), .clock(clock), .enable(enable), .load(load), .data_to_read1(data_to_read1),
.data_to_read2(data_to_read2));

initial begin

// Test1
step clock = 0;
data_to_write = 18'b000000000000000011;
reg_to_write = 4'b0000;
enable = 1;
load = 1;
#3
clock = 1;
#3
load = 0;
#3

// Test2
clock = 0;
reg_to_read1 = 4'b0000;
reg_to_read2 = 4'b0000;
enable = 1;
load = 1;
#3
clock = 1;
#3
load = 0;
#3
$finish();
end
endmodule
