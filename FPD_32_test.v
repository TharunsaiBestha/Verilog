module FPD_32_test;
reg[31:0] Divisor,Dividend;
wire[31:0] Quotient;
FPD_32 DUT(Divisor,Dividend,Quotient);
initial begin
    #5 Dividend=32'b01000010101101101011000000000000;
        Divisor=32'b00111110000101000000000000000000;
    #5 Dividend=32'b00111111100000000000000000000000;
        Divisor=32'b01000000000000000000000000000000;
    #5 Dividend=32'b01000000000000000000000000000000;
        Divisor=32'b01000000101000000000000000000000;
    #5 $finish;
end
initial begin
    $dumpfile("FPD_32_test.vcd");
    $dumpvars(0,FPD_32_test);
end
endmodule