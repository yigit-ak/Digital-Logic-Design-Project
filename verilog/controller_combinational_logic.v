module controller_combinational_logic(state, opcode, enable_registers, pc_load, 
ir_load,st_mux_s, rf_load, flag_load, ld_mux_s, data_memo_str, jump_select, next_state);

// Inputs
input[2:0] state;
input[3:0] opcode;
// Outputs
output enable_registers;
output pc_load;
output ir_load;
output rf_load;
output flag_load;
output ld_mux_s;
output data_memo_str;
output[2:0] jump_select;
output[2:0] next_state;
output st_mux_s;
// Assignments
assign enable_registers = state[0] || state[1] || state[2];
assign pc_load = (state[0]&&state[1]) || state[2];
assign ir_load = !state[2]&&!state[1]&&state[0];
assign st_mux_s = state[2]&&!state[1]&&state[0];
assign rf_load = (!state[2]&&state[1]&&state[0]) || (state[2]&&!state[1]&&!state[0]);
assign flag_load = state[2]&&state[1]&&!state[0];
assign ld_mux_s = state[2]&&!state[1]&&!state[0];
assign data_memo_str = state[2]&&!state[1]&&state[0];
assign jump_select[2] = (   (opcode[3]&&opcode[2]&&opcode[1]&&opcode[0]&&state[1]) || (!state[2]&&state[1]&&state[0]) || 
(state[2]&&!state[1]) || (state[2]&&!state[0])  || (state[2]&&!opcode[3]) || 
(state[2]&&!opcode[1]&&!opcode[0]) || (state[2]&&opcode[2])  );
assign jump_select[1] =  (state[1]&&opcode[3]&&opcode[2]&&opcode[1]&&opcode[0]) || (!state[2]&&state[1]&&state[0]) || (state[2]&&!state[1]) || (state[2]&&!state[0]) || (state[2]&&!opcode[3]) || (state[2]&&!opcode[2]&&!opcode[0]) || (state[2]&&opcode[1]);
assign jump_select[0] = (state[1]&&opcode[3]&&opcode[2]&&opcode[1]&&opcode[0]) || (!state[2]&&state[1]&&state[0]) || (state[2]&&!state[1]) || (state[2]&&!state[0]) || (state[2]&&!opcode[3]) || state[2]&&!opcode[2]&&!opcode[1] || state[2]&&opcode[0];
assign next_state[2] = (!state[2]&&state[1]&&!state[0]&&!opcode[3]&&opcode[2]&&opcode[1] || !state[2]&&state[1]&&!state[0]&&opcode[3]&&!opcode[2] || !state[2]&&state[1]&&!state[0]&&opcode[3]&&!opcode[0]);
assign next_state[1] = (!state[2]&&!state[1]&&state[0] || !state[2]&&state[1]&&!state[0]&&!opcode[2] || !state[2]&&state[1]&&!state[0]&&!opcode[1] || !state[2]&&state[1]&&!state[0]&&opcode[3]&&!opcode[0]);
assign next_state[0] = ( !state[1]&&!state[0] || !state[0]&&!opcode[3]&&!opcode[2] || !state[0]&&opcode[0] || !state[0]&&opcode[2]&&!opcode[1] || !state[0]&&opcode[3]&&opcode[1] || state[1]&&state[0] || state[2]);

endmodule

// Testbench
module controller_combinational_logic_tb();

reg[2:0] state;
reg[3:0] opcode;
wire enable_registers;
wire pc_load;
wire ir_load;
wire rf_load;
wire flag_load;
wire ld_mux_s;
wire data_memo_str;
wire[2:0] jump_select;
wire[2:0] next_state;
wire st_mux_s;

controller_combinational_logic dut(.state(state), .opcode(opcode), .enable_registers(enable_registers), 
.pc_load(pc_load), .ir_load(ir_load), .rf_load(rf_load), .flag_load(flag_load), .ld_mux_s(ld_mux_s),
 .data_memo_str(data_memo_str),.jump_select(jump_select), .next_state(next_state), .st_mux_s(st_mux_s));

initial begin

// Test1
state= 3'b000;
opcode=4'b0000;
#3
$display("For; state= %b  and opcode= %b ---------> enable_register=%b, pc_load=%b, ir_load=%b, st_mux_s=%b, rf_load=%b, flag_load=%b, ld_mux_s=%b, data_memo_str=%b, next_state=%b, jump_select=%b ",
 state, opcode, enable_registers, pc_load, ir_load, st_mux_s,rf_load, flag_load, ld_mux_s, data_memo_str, next_state, jump_select );

// Test2
state= 3'b001;
opcode=4'b0000;
#3
$display("For; state= %b  and opcode= %b ---------> enable_register=%b, pc_load=%b, ir_load=%b, st_mux_s=%b, rf_load=%b, flag_load=%b, ld_mux_s=%b, data_memo_str=%b, next_state=%b, jump_select=%b ",
 state, opcode, enable_registers, pc_load, ir_load, st_mux_s,rf_load, flag_load, ld_mux_s, data_memo_str, next_state, jump_select );

// Test3
state= 3'b011;
opcode=4'b0101;
#3
$display("For; state= %b  and opcode= %b ---------> enable_register=%b, pc_load=%b, ir_load=%b, st_mux_s=%b, rf_load=%b, flag_load=%b, ld_mux_s=%b, data_memo_str=%b, next_state=%b, jump_select=%b ",
 state, opcode, enable_registers, pc_load, ir_load, st_mux_s,rf_load, flag_load, ld_mux_s, data_memo_str, next_state, jump_select );

// Test4
state= 3'b100;
opcode=4'b1000;
#3
$display("For; state= %b  and opcode= %b ---------> enable_register=%b, pc_load=%b, ir_load=%b, st_mux_s=%b, rf_load=%b, flag_load=%b, ld_mux_s=%b, data_memo_str=%b, next_state=%b, jump_select=%b ",
 state, opcode, enable_registers, pc_load, ir_load, st_mux_s,rf_load, flag_load, ld_mux_s, data_memo_str, next_state, jump_select );

// Test5
state= 3'b100;
opcode=4'b1110;
#3
$display("For; state= %b  and opcode= %b ---------> enable_register=%b, pc_load=%b, ir_load=%b, st_mux_s=%b, rf_load=%b, flag_load=%b, ld_mux_s=%b, data_memo_str=%b, next_state=%b, jump_select=%b ",
 state, opcode, enable_registers, pc_load, ir_load, st_mux_s,rf_load, flag_load, ld_mux_s, data_memo_str, next_state, jump_select );

// Test6
state= 3'b111;
opcode=4'b1111;
#3
$display("For; state= %b  and opcode= %b ---------> enable_register=%b, pc_load=%b, ir_load=%b, st_mux_s=%b, rf_load=%b, flag_load=%b, ld_mux_s=%b, data_memo_str=%b, next_state=%b, jump_select=%b ",
 state, opcode, enable_registers, pc_load, ir_load, st_mux_s,rf_load, flag_load, ld_mux_s, data_memo_str, next_state, jump_select );
$finish();
end
endmodule
