module signExtender4To18bits(inp, out);
parameter inputSize = 4;
parameter outputSize = 18;
input wire [(inputSize-1):0] inp;
output wire [(outputSize-1):0] out;

assign out = {{outputSize-inputSize{inp[inputSize-1]}}, inp};
endmodule

module tb_signExtender4To18bits;
reg [3:0] inp;
wire [17:0] out;

signExtender4To18bits dut(.inp(inp), .out(out));

initial begin
inp = 4'b0000;
#5
$display("The sign extended version of %b is %b", inp, out);

inp = 4'b1000;
#5
$display("The sign extended version of %b is %b", inp, out);
$finish();
end
endmodule