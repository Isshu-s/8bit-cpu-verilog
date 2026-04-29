module reg_file(
    input        clk,
    input        we,          // write enable
    input  [2:0] r_addr1,     // read address 1
    input  [2:0] r_addr2,     // read address 2
    input  [2:0] w_addr,      // write address
    input  [7:0] w_data,      // data to write
    output [7:0] r_data1,     // read data 1
    output [7:0] r_data2      // read data 2
);

    reg [7:0] regs [0:7];     // 8 registers, each 8-bit

    // read is combinational (instant)
    assign r_data1 = regs[r_addr1];
    assign r_data2 = regs[r_addr2];

    // write is synchronous (on clock edge)
    always @(posedge clk) begin
        if (we)
            regs[w_addr] <= w_data;
    end

endmodule