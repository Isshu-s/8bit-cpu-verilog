`timescale 1ns/1ps

module instr_mem_tb;

    reg  [7:0]  addr;
    wire [15:0] instr;

    instr_mem uut (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        // Read instruction at address 0 — should be MOVI R1, 10
        addr = 8'd0; #10;

        // Read instruction at address 1 — should be MOVI R2, 5
        addr = 8'd1; #10;

        // Read instruction at address 2 — should be ADD R3, R1, R2
        addr = 8'd2; #10;

        // Read instruction at address 3 — should be SUB R4, R1, R2
        addr = 8'd3; #10;

        // Read instruction at address 4 — should be AND R5, R1, R2
        addr = 8'd4; #10;

        // Read instruction at address 5 — should be OR R6, R1, R2
        addr = 8'd5; #10;

        // Read instruction at address 6 — should be JMP 0
        addr = 8'd6; #10;

        // Read empty address — should be 0000
        addr = 8'd7; #10;

        $stop;
    end

endmodule