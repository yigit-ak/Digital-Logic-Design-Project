module MAIN(start, clk);
// Inputs
input start;
input clk;
// Others
wire [17:0] im_1; 
wire [17:0] rt_1; 
wire [2:0] tm2_1;
wire pc_1;
wire cu_L, r1;
wire [17:0] ld_mux;
wire [3:0] opcode;
wire [3:0] DR;
wire [3:0] SR1;
wire [3:0] SR2;
wire [5:0] immediate;
wire selectBit;
wire [1:0] ALU_inp;
wire [9:0] addR;
wire [17:0] data_to_read1_out;
wire [17:0] data_to_read2_out;
wire zf_enable, cf, zf;
wire [17:0] pc_new;

// InstructionMemory module declaration
instructionMemory im(
		.hexAddress(18'b000000000000000000), 
		.dataO(im_1)
);
// InstructionRegister module declaration
register_18bit rt(
		.data_input(im_1), 
		.enable(pc_1), 
		.load(1), 
		.clk(clk), 
		.output_data(rt_1)
);
// assignments for instruction set
assign rt_1[17:14] = opcode;
assign rt_1[13:10] = DR;
assign rt_1[9:6] = SR1;
assign rt_1[3:0] = SR2;
assign rt_1[5:0] = immediate;
assign rt_1[16] = selectBit;
assign rt_1[15:14] = ALU_inp;
assign rt_1[9:0] = addR;
// TwotoOneMux module declaration(this module has two inputs a and b. The other one's one input is constant)
twoToOneMux2 tm2(
		.a(rt_1[13:10]), 
		.b(rt_1[9:6]), 
		.select_bit(1),
		.out(tm2_1)
);
register_file rf(.data_to_write(ld_mux), 
		.reg_to_write(DR), 
		.reg_to_read1(SR1), 	
		.reg_to_read2(SR2), 
		.clock(clk), 
		.enable(pc_1),
		.load(cu_L),
		.data_to_read1(data_to_read1_out),
		.data_to_read2(data_to_read2_out)
);
pc pc_m(.immediate(),
  	.clock(clk),
  	.enable(zf_enable),
 	.load(cu_L),
  	.jump_select(cu_jmp),
	.ZF(zf),
	.CF(cf),
  	.pc_value(pc_new)
);	
Comparator cm(.zero_flag(zf),
  	      .carry_flag(cf),	
	      .number1(data_to_read1_out),
  	      .number2(data_to_read2_out)
);
ALU alu(.result(r1), 
    .a(data_to_read1_out),
    .b(data_to_read2_out), 
    .select(ALU_inp)
);

endmodule 