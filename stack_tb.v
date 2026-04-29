`timescale 1ns/1ps

module stack_tb;

    reg        clk, reset, push, pop;
    reg  [7:0] data_in;
    wire [7:0] data_out, sp;
    wire       full, empty;

    stack uut (
        .clk(clk),
        .reset(reset),
        .push(push),
        .pop(pop),
        .data_in(data_in),
        .data_out(data_out),
        .sp(sp),
        .full(full),
        .empty(empty)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Test 1 — reset
        reset = 1; push = 0; pop = 0; data_in = 0;
        #10;
        reset = 0;

        // Test 2 — push 10
        push = 1; data_in = 8'd10;
        #10;

        // Test 3 — push 20
        push = 1; data_in = 8'd20;
        #10;

        // Test 4 — push 30
        push = 1; data_in = 8'd30;
        #10;

        // Test 5 — stop pushing
        push = 0;
        #10;

        // Test 6 — pop → should get 30
        pop = 1;
        #10;

        // Test 7 — pop → should get 20
        #10;

        // Test 8 — pop → should get 10
        #10;

        // Test 9 — stop popping, stack should be empty
        pop = 0;
        #10;

        $stop;
    end

endmodule