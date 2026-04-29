module instr_mem(
    input  [7:0] addr,
    output [15:0] instr
);

    reg [15:0] mem [0:255]; // 256 instructions

    // program loaded at startup
    initial begin
        // MOVI R1, 10  → load value 10 into R1
        mem[0] = 16'b0111_0001_0000_1010;

        // MOVI R2, 5   → load value 5 into R2
        mem[1] = 16'b0111_0010_0000_0101;

        // ADD R3, R1, R2 → R3 = R1 + R2 = 15
        mem[2] = 16'b0010_0011_0001_0010;

        // SUB R4, R1, R2 → R4 = R1 - R2 = 5
        mem[3] = 16'b0011_0100_0001_0010;

        // AND R5, R1, R2 → R5 = R1 & R2
        mem[4] = 16'b0100_0101_0001_0010;

        // OR  R6, R1, R2 → R6 = R1 | R2
        mem[5] = 16'b0101_0110_0001_0010;

        // JMP to address 0 → loop back to start
        mem[6] = 16'b0110_0000_0000_0000;

        // fill rest with NOPs (zeros)
        // remaining locations default to 0
    end

    assign instr = mem[addr];

endmodule
