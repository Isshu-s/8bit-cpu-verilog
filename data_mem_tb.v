`timescale 1ns/1ps

module data_mem_tb;

    reg        clk, we;
    reg  [7:0] addr, w_data;
    wire [7:0] r_data;

    data_mem uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .w_data(w_data),
        .r_data(r_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Test 1 — write 77 to address 10
        we = 1; addr = 8'd10; w_data = 8'd77;
        #10;

        // Test 2 — write 200 to address 20
        we = 1; addr = 8'd20; w_data = 8'd200;
        #10;

        // Test 3 — write 33 to address 0
        we = 1; addr = 8'd0; w_data = 8'd33;
        #10;

        // Test 4 — read back address 10, should be 77
        we = 0; addr = 8'd10;
        #10;

        // Test 5 — read back address 20, should be 200
        we = 0; addr = 8'd20;
        #10;

        // Test 6 — read back address 0, should be 33
        we = 0; addr = 8'd0;
        #10;

        // Test 7 — write disabled, try overwrite address 10
        we = 0; addr = 8'd10; w_data = 8'd99;
        #10;

        // Test 8 — read address 10, should still be 77
        we = 0; addr = 8'd10;
        #10;

        $stop;
    end

endmodule