// Code your design here
module alu (
    input  [7:0] a, b,
    input  [2:0] op,
    output reg [7:0] result,
    output reg carry,
    output zero
);
    always @(*) begin
        carry = 0;
        case (op)
            3'b000: {carry, result} = a + b;   // ADD
            3'b001: {carry, result} = a - b;   // SUB
            3'b010: result = a & b;            // AND
            3'b011: result = a | b;            // OR
            3'b100: result = a ^ b;            // XOR
            3'b101: result = ~a;               // NOT
            3'b110: result = (a > b) ? 8'd1 : 8'd0; // compare
            default: result = 8'd0;
        endcase
    end
    assign zero = (result == 8'd0);
endmodule