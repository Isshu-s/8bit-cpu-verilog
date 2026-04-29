module data_mem(
    input        clk,
    input        we,          // write enable
    input  [7:0] addr,        // address to read/write
    input  [7:0] w_data,      // data to write
    output [7:0] r_data       // data to read
);

    reg [7:0] mem [0:255];    // 256 bytes of RAM

    // write on clock edge
    always @(posedge clk) begin
        if (we)
            mem[addr] <= w_data;
    end

    // read is combinational
    assign r_data = mem[addr];


endmodule