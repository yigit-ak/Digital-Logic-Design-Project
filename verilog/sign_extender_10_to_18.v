module signExtender10To18bits(inp, out);
parameter inputSize = 10;
parameter outputSize = 18;
input wire [(inputSize-1):0] inp;
output wire [(outputSize-1):0] out;

// replicates the MSB outputSize-inputSize times
assign out = {{outputSize-inputSize{inp[inputSize-1]}}, inp};
endmodule

module tb_signExtender10To18bits;
reg [9:0] inp;
wire [17:0] out;

signExtender10To18bits dut(.inp(inp), .out(out));

initial begin
inp = 10'b0000000000;
#5
$display("The sign extended version of %b is %b", inp, out);

inp = 10'b1000000000;
#5
$display("The sign extended version of %b is %b", inp, out);

$finish();
end
endmodule