`timescale 1ns/1ps

module cpu_top_tb;

    reg clk, reset;

    cpu_top uut (
        .clk(clk),
        .reset(reset)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // reset CPU
        reset = 1;
        #20;
        reset = 0;

        // let CPU run for 20 cycles
        // executes: MOVI R1,10 → MOVI R2,5 →
        //           ADD → SUB → AND → OR → JMP 0 → loops
        #200;

        $stop;
    end

endmodule