module controller(opcode, enable, clk, enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);

// inputs
input[3:0] opcode;
input enable;
input clk;
//outputs
output enable_registers;
output pc_load;
output ir_load;
output st_mux_s;
output rf_load;
output flag_load;
output ld_mux_s;
output data_memo_str;
output[2:0] jump_select;
wire [2:0] st_1;
wire [2:0] cl_1;

// Declaring "StateReg" module
StateReg st(cl_1[2:0], enable, clk, st_1[2:0]);
// Declaring "controller_combinational_logic" module
controller_combinational_logic cl(.state(st_1[2:0]), .opcode(opcode[3:0]), .enable_register(enable_registers), .pc_load(pc_load), 
.ir_load(ir_load), .rf_load(rf_load), .flag_load(flag_load), .ld_mux_s(ld_mux_s), .st_mux_s(st_mux_s),  .data_memo_stre(data_memo_str), .jump_select(jump_select), .next_state(cl_l[2:0]) );

endmodule

// Testbench
module controller_tb();

reg [3:0] opcode;
reg enable;
reg clk;
wire enable_registers;
wire pc_load;
wire ir_load;
wire st_mux_s;
wire rf_load;
wire flag_load;
wire ld_mux_s;
wire data_memo_str;
wire [2:0] jump_select;

controller dut(.opcode(opcode), .enable(enable), .clk(clk), .enable_registers(enable_registers), .pc_load(pc_load), 
.ir_load(ir_load),.st_mux_s(st_mux_s), .rf_load(rf_load), .flag_load(flag_load), .ld_mux_s(ld_mux_s), .data_memo_str(data_memo_str), 
.jump_select(jump_select));

initial begin
// Test1
clk = 1'b0;
opcode = 4'b0000;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test2
clk = 1'b0;
opcode = 4'b0001;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test3
clk = 1'b0;
opcode = 4'b0010;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test4
clk = 1'b0;
opcode = 4'b0011;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test5
clk = 1'b0;
opcode = 4'b0100;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test6
clk = 1'b0;
opcode = 4'b0101;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test7
clk = 1'b0;
opcode = 4'b0110;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test8
clk = 1'b0;
opcode = 4'b0111;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test9
clk = 1'b0;
opcode = 4'b1000;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test10
clk = 1'b0;
opcode = 4'b1001;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test11
clk = 1'b0;
opcode = 4'b1010;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test12
clk = 1'b0;
opcode = 4'b1011;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test13
clk = 1'b0;
opcode = 4'b1100;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test14
clk = 1'b0;
opcode = 4'b1101;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
#10

//Test15
clk = 1'b0;
opcode = 4'b1110;
enable = 1'b1;
#10
clk = 1'b1;
#10
$display("ER is %b, PL is %b, IR is %b, SMUX is %b, RFL is %b, FL is %b, DMS is %b and JS is %b", enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select);
$finish();
end
endmodule

