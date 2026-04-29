`timescale 1ns/1ps

module alu_tb;

    // inputs driven by testbench
    reg [7:0] a;
    reg [7:0] b;
    reg [2:0] op;

    // outputs we observe
    wire [7:0] result;
    wire zero;

    // connect to ALU
    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .result(result),
        .zero(zero)
    );

    initial begin
        // Test ADD: 10 + 5 = 15
        a = 8'd10; b = 8'd5; op = 3'b000;
        #10;

        // Test SUB: 10 - 5 = 5
        a = 8'd10; b = 8'd5; op = 3'b001;
        #10;

        // Test AND: 0xF0 & 0x0F = 0x00 (zero flag should be 1)
        a = 8'hF0; b = 8'h0F; op = 3'b010;
        #10;

        // Test OR: 0xF0 | 0x0F = 0xFF
        a = 8'hF0; b = 8'h0F; op = 3'b011;
        #10;

        // Test PASS A: result should = a
        a = 8'd42; b = 8'd0; op = 3'b100;
        #10;

        // Test zero flag: 5 - 5 = 0
        a = 8'd5; b = 8'd5; op = 3'b001;
        #10;

        $stop;
    end

endmodule