module twoToOneMux(a, select_bit, out);
// Inputs
input [2:0] a;
input select_bit;
// Ouput
output [2:0] out;
// Assignments
wire [2:0] b;
assign b[0] = 0;
assign b[1] = 0;
assign b[2] = 0;
assign out = (select_bit) ? a:b;

endmodule

// Testbench
module twoToOneMux_tb();
reg a, select_bit;
wire out;

twoToOneMux dut(.a(a), .select_bit(select_bit), .out(out));

initial begin

// Test1
a = 3'b000;
select_bit = 1'b0;
#3
$display("Out is %b", out);

// Test2
a = 3'b010;
select_bit = 1'b0;
#3
$display("Out is %b", out);

// Test3
a = 3'b110;
select_bit = 1'b1;
#3
$display("Out is %b", out);

// Test4
a = 3'b111;
select_bit = 1'b1;
#3
$display("Out is %b", out);
$finish();
end
endmodule 