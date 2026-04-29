module alu(
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] op,
    output reg [7:0] result,
    output reg zero
);

// op codes
// 000 = ADD
// 001 = SUB
// 010 = AND
// 011 = OR
// 100 = PASS A (used for MOVI/LOAD)

always @(*) begin
    case(op)
        3'b000: result = a + b;
        3'b001: result = a - b;
        3'b010: result = a & b;
        3'b011: result = a | b;
        3'b100: result = a;
        default: result = 8'd0;
    endcase
    zero = (result == 8'd0);
end

endmodule