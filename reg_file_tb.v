`timescale 1ns/1ps

module reg_file_tb;

    reg        clk;
    reg        we;
    reg  [2:0] r_addr1, r_addr2, w_addr;
    reg  [7:0] w_data;
    wire [7:0] r_data1, r_data2;

    // connect to register file
    reg_file uut (
        .clk(clk),
        .we(we),
        .r_addr1(r_addr1),
        .r_addr2(r_addr2),
        .w_addr(w_addr),
        .w_data(w_data),
        .r_data1(r_data1),
        .r_data2(r_data2)
    );

    // clock: toggle every 5ns = 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Test 1 — write 42 into R1
        we = 1; w_addr = 3'd1; w_data = 8'd42;
        #10;

        // Test 2 — write 99 into R3
        we = 1; w_addr = 3'd3; w_data = 8'd99;
        #10;

        // Test 3 — write 255 into R7
        we = 1; w_addr = 3'd7; w_data = 8'd255;
        #10;

        // Test 4 — read R1 and R3 simultaneously
        we = 0; r_addr1 = 3'd1; r_addr2 = 3'd3;
        #10;

        // Test 5 — read R7 and R1 simultaneously
        we = 0; r_addr1 = 3'd7; r_addr2 = 3'd1;
        #10;

        // Test 6 — write disabled, try to overwrite R1, should stay 42
        we = 0; w_addr = 3'd1; w_data = 8'd00;
        r_addr1 = 3'd1;
        #10;

        $stop;
    end

endmodule