module Divison_Generic_test;
parameter N =24 ;
reg[N-1:0] Divisor,Dividend;
wire[N-1:0] Quotient,Reminder;
Division_Generic DUT(Divisor,Dividend,Quotient,Reminder);
initial begin
     #2 Dividend=24'b11111100001000000000000;
         Divisor=24'b00001111000000000000000;
    #2 $finish;
end
initial begin
    $dumpfile("Divison_Generic_test.vcd");
    $dumpvars(0,Divison_Generic_test);
end
endmodule