module Floating_point_Division_test;
reg[31:0] Divisor,Dividend;
wire[31:0] Quotient;
FPD_32 DUT(Divisor,Dividend,Quotient);
initial begin
    #5 Dividend=32'b111111100000000000000000000000;
        Divisor=32'b1000000000000000000000000000000;
    #5 Dividend=32'b111111001100110011001100110011;
        Divisor=32'b1000000010000000000000000000000;
    #5 $finish;
end
initial begin
    $dumpfile("Floating_point_Division_test.vcd");
    $dumpvars(0,Floating_point_Division_test);
end
endmodule