`timescale 1ns/1ps

module control_unit_tb;

    reg  [3:0] opcode;
    wire       reg_we, mem_we, mem_to_reg;
    wire       alu_src, pc_load, push, pop;
    wire       is_call, is_return;
    wire [2:0] alu_op;

    control_unit uut (
        .opcode(opcode),
        .reg_we(reg_we),
        .mem_we(mem_we),
        .mem_to_reg(mem_to_reg),
        .alu_src(alu_src),
        .pc_load(pc_load),
        .push(push),
        .pop(pop),
        .is_call(is_call),
        .is_return(is_return),
        .alu_op(alu_op)
    );

    initial begin
        opcode = 4'b0000; #10; // LOAD
        opcode = 4'b0001; #10; // STORE
        opcode = 4'b0010; #10; // ADD
        opcode = 4'b0011; #10; // SUB
        opcode = 4'b0100; #10; // AND
        opcode = 4'b0101; #10; // OR
        opcode = 4'b0110; #10; // JMP
        opcode = 4'b0111; #10; // MOVI
        opcode = 4'b1000; #10; // CALL
        opcode = 4'b1001; #10; // RETURN
        opcode = 4'b1010; #10; // PUSH
        opcode = 4'b1011; #10; // POP
        $stop;
    end

endmodule