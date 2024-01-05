module signExtender6To18bits(inp, out);
parameter inputSize = 6;
parameter outputSize = 18;
input wire [(inputSize-1):0] inp;
output wire [(outputSize-1):0] out;

assign out = {{outputSize-inputSize{inp[inputSize-1]}}, inp};
endmodule

module tb_signExtender6To18bits;
reg [5:0] inp;
wire [17:0] out;

signExtender6To18bits dut(.inp(inp), .out(out));

initial begin
inp = 6'b000000;
#5
$display("The sign extended version of %b is %b", inp, out);

inp = 6'b100000;
#5
$display("The sign extended version of %b is %b", inp, out);

$finish;
end
endmodule