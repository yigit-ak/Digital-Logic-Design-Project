module StateReg(I, enable, clk, Q);

// Inputs
input wire [2:0] I;
input wire enable;
input wire clk;
// Outputs
output wire [2:0] Q;
// Others
wire [2:0] s;
wire [2:0] out_dff;

// Declaring "twoToOneMux" module
twoToOneMux mux1(I[2:0], enable, s[2:0]);
// Declaring "DFlipFlop" modules
DFlipFlop dff1(s[0], clk, out_dff[0]);
DFlipFlop dff2(s[1], clk, out_dff[1]);
DFlipFlop dff3(s[2], clk, out_dff[2]);
// Declaring "twoToOneMux" module
twoToOneMux mux2(out_dff[2:0], enable, Q[2:0]);

endmodule 

// Testbench
module tb_StateReg;
reg [2:0] I;
reg enable;
reg clk;
wire [2:0] Q;

StateReg dut(.I(I), .enable(enable), .clk(clk), .Q(Q));

initial begin

// Test1
clk = 0;
I = 3'b000;
enable = 1'b1; #3;
clk = 1; #3;
$display("Q is %b", Q);

// Test2
clk = 0;
I = 3'b001;
enable = 1'b1; #3;
clk = 1; #3;
$display("Q is %b", Q);

// Test3
clk = 0;
I = 3'b010;
enable = 1'b1; #3;
clk = 1; #3;
$display("Q is %b", Q);

// Test4
clk = 0;
I = 3'b100;
enable = 1'b1; #3;
clk = 1; #3
$display("Q is %b", Q);

// Test5
clk = 0;
I = 3'b111;
enable = 1'b1; #3;
clk = 1; #3
$display("Q is %b", Q);
$finish;
end
endmodule





