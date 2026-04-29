`timescale 1ns/1ps

module program_counter_tb;

    reg        clk, reset, load;
    reg  [7:0] pc_in;
    wire [7:0] pc_out;

    program_counter uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // clock: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Test 1 — reset PC to 0
        reset = 1; load = 0; pc_in = 8'd0;
        #10;

        // Test 2 — release reset, PC should increment
        reset = 0; load = 0;
        #10; // pc = 1
        #10; // pc = 2
        #10; // pc = 3

        // Test 3 — jump to address 50
        load = 1; pc_in = 8'd50;
        #10;

        // Test 4 — release load, PC increments from 50
        load = 0;
        #10; // pc = 51
        #10; // pc = 52

        // Test 5 — reset again mid-execution
        reset = 1;
        #10; // pc = 0

        // Test 6 — release reset, count again
        reset = 0;
        #10; // pc = 1
        #10; // pc = 2

        $stop;
    end

endmodule