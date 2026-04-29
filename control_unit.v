module control_unit(
    input  [3:0] opcode,
    output reg   reg_we,      // register file write enable
    output reg   mem_we,      // data memory write enable
    output reg   mem_to_reg,  // 1=data comes from memory, 0=from ALU
    output reg   alu_src,     // 1=immediate value, 0=register
    output reg   pc_load,     // 1=jump/call, 0=normal increment
    output reg   push,        // stack push
    output reg   pop,         // stack pop
    output reg   is_call,     // 1=save PC to stack (CALL)
    output reg   is_return,   // 1=load PC from stack (RETURN)
    output reg [2:0] alu_op   // ALU operation
);

// opcodes
localparam LOAD   = 4'b0000;
localparam STORE  = 4'b0001;
localparam ADD    = 4'b0010;
localparam SUB    = 4'b0011;
localparam AND    = 4'b0100;
localparam OR     = 4'b0101;
localparam JMP    = 4'b0110;
localparam MOVI   = 4'b0111;
localparam CALL   = 4'b1000;
localparam RETURN = 4'b1001;
localparam PUSH   = 4'b1010;
localparam POP    = 4'b1011;

always @(*) begin
    // default all signals to 0
    reg_we     = 0;
    mem_we     = 0;
    mem_to_reg = 0;
    alu_src    = 0;
    pc_load    = 0;
    push       = 0;
    pop        = 0;
    is_call    = 0;
    is_return  = 0;
    alu_op     = 3'b000;

    case(opcode)
        LOAD: begin
            reg_we     = 1;
            mem_to_reg = 1;
        end
        STORE: begin
            mem_we = 1;
        end
        ADD: begin
            reg_we = 1;
            alu_op = 3'b000;
        end
        SUB: begin
            reg_we = 1;
            alu_op = 3'b001;
        end
        AND: begin
            reg_we = 1;
            alu_op = 3'b010;
        end
        OR: begin
            reg_we = 1;
            alu_op = 3'b011;
        end
        JMP: begin
            pc_load = 1;
        end
        MOVI: begin
            reg_we  = 1;
            alu_src = 1;
            alu_op  = 3'b100;  // PASS A (immediate → reg)
        end
        CALL: begin
            pc_load  = 1;
            push     = 1;
            is_call  = 1;
        end
        RETURN: begin
            pop       = 1;
            is_return = 1;
        end
        PUSH: begin
            push = 1;
        end
        POP: begin
            pop    = 1;
            reg_we = 1;
        end
    endcase
end

endmodule