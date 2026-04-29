module cpu_top(
    input clk,
    input reset
);

    // ── Wires ──────────────────────────────────────────
    wire [7:0]  pc_out;
    wire [15:0] instr;
    wire [3:0]  opcode;
    wire [2:0]  dest, src1, src2;
    wire [7:0]  imm;

    // control signals
    wire        reg_we, mem_we, mem_to_reg;
    wire        alu_src, pc_load;
    wire        push, pop, is_call, is_return;
    wire [2:0]  alu_op;

    // datapath wires
    wire [7:0]  r_data1, r_data2;
    wire [7:0]  alu_b;
    wire [7:0]  alu_result;
    wire        alu_zero;
    wire [7:0]  mem_r_data;
    wire [7:0]  w_data;
    wire [7:0]  stack_out;
    wire [7:0]  sp;
    wire        stack_full, stack_empty;
    wire [7:0]  pc_in;

    // ── Instruction Decode ─────────────────────────────
    assign opcode = instr[15:12];
    assign dest   = instr[11:9];
    assign src1   = instr[8:6];
    assign src2   = instr[5:3];
    assign imm    = instr[7:0];   // immediate value (lower 8 bits)

    // ── PC source: RETURN uses stack, CALL/JMP use imm ─
    assign pc_in  = is_return ? stack_out : imm;

    // ── ALU B input: immediate or register ─────────────
    assign alu_b  = alu_src ? {4'b0000, instr[3:0]} : r_data2;

    // ── Register write data: memory or ALU ─────────────
    assign w_data = mem_to_reg ? mem_r_data :
                    pop        ? stack_out  : alu_result;

    // ── Program Counter ────────────────────────────────
    program_counter pc (
        .clk(clk),
        .reset(reset),
        .load(pc_load),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // ── Instruction Memory ─────────────────────────────
    instr_mem im (
        .addr(pc_out),
        .instr(instr)
    );

    // ── Control Unit ───────────────────────────────────
    control_unit cu (
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

    // ── Register File ──────────────────────────────────
    reg_file rf (
        .clk(clk),
        .we(reg_we),
        .r_addr1(src1),
        .r_addr2(src2),
        .w_addr(dest),
        .w_data(w_data),
        .r_data1(r_data1),
        .r_data2(r_data2)
    );

    // ── ALU ────────────────────────────────────────────
    alu al (
        .a(r_data1),
        .b(alu_b),
        .op(alu_op),
        .result(alu_result),
        .zero(alu_zero)
    );

    // ── Data Memory ────────────────────────────────────
    data_mem dm (
        .clk(clk),
        .we(mem_we),
        .addr(alu_result),
        .w_data(r_data2),
        .r_data(mem_r_data)
    );

    // ── Stack ──────────────────────────────────────────
    stack st (
        .clk(clk),
        .reset(reset),
        .push(push),
        .pop(pop),
        .data_in(pc_out),
        .data_out(stack_out),
        .sp(sp),
        .full(stack_full),
        .empty(stack_empty)
    );

endmodule