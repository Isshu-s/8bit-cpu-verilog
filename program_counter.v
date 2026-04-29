module program_counter(
    input        clk,
    input        reset,
    input        load,       // 1 = load new address (for JMP/CALL)
    input  [7:0] pc_in,      // address to jump to
    output reg [7:0] pc_out  // current PC value
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_out <= 8'd0;
        else if (load)
            pc_out <= pc_in;   // jump to new address
        else
            pc_out <= pc_out + 1; // normal increment
    end

endmodule