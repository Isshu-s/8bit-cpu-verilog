module stack(
    input        clk,
    input        reset,
    input        push,        // 1 = push data onto stack
    input        pop,         // 1 = pop data from stack
    input  [7:0] data_in,     // data to push
    output reg [7:0] data_out,// data popped
    output reg [7:0] sp,      // stack pointer (for debugging)
    output reg       full,    // stack is full
    output reg       empty    // stack is empty
);

    reg [7:0] mem [0:15];     // 16 deep stack
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sp       <= 8'd0;
            data_out <= 8'd0;
            full     <= 1'b0;
            empty    <= 1'b1;
        end
        else if (push && !full) begin
            mem[sp]  <= data_in;
            sp       <= sp + 1;
            empty    <= 1'b0;
            if (sp == 8'd15) full <= 1'b1;
        end
        else if (pop && !empty) begin
            sp       <= sp - 1;
            data_out <= mem[sp - 1];
            full     <= 1'b0;
            if (sp == 8'd1) empty <= 1'b1;
        end
    end

endmodule