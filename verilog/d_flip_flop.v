module DFlipFlop(D, clk, Q);
input wire D, clk;
output reg Q;

always @(posedge clk) begin
Q <= D;
end

endmodule

module tb_DFlipFlop;
reg D, clk;
wire Q;
DFlipFlop dut(.D(D), .clk(clk), .Q(Q));
initial begin
clk = 0;
forever #1 clk = ~clk;
end

initial begin
D = 0;
#2
D = 1;
#2
D = 0;
#2
D = 1;
#2
$finish;
end
endmodule