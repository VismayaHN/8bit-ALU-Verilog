// Code your testbench here
// or browse Examples
module tb;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] result;
    wire carry, zero;
    integer errors = 0;

    alu dut (a, b, op, result, carry, zero);

    task check(input [7:0] expected);
        begin
            #1;
            if (result !== expected) begin
                $display("FAIL: op=%b a=%d b=%d got=%d exp=%d",
                          op, a, b, result, expected);
                errors = errors + 1;
            end else
                $display("PASS: op=%b a=%d b=%d result=%d",
                          op, a, b, result);
        end
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        a = 8'd25; b = 8'd10;
        op = 3'b000; check(8'd35);
        op = 3'b001; check(8'd15);
        op = 3'b010; check(a & b);
        op = 3'b011; check(a | b);
        op = 3'b100; check(a ^ b);
        op = 3'b101; check(~a);
        op = 3'b110; check(8'd1);

        a = 8'd10; b = 8'd10;
        op = 3'b001; check(8'd0);   // zero flag case

        if (errors == 0) $display("ALL TESTS PASSED");
        else $display("%0d TESTS FAILED", errors);
        $finish;
    end
endmodule