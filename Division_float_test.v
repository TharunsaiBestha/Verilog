module Divison_float_test;
parameter N =23 ;
reg[N-1:0] Divisor,Dividend;
wire[N:0] Quotient,Reminder;
Division_float DUT(Divisor,Dividend,Quotient);
initial begin
     #2 Dividend=23'b01101101011000000000000;
         Divisor=23'b00101000000000000000000;
    #2 $finish;
end
initial begin
    $dumpfile("Divison_float_test.vcd");
    $dumpvars(0,Divison_float_test);
end
endmodule