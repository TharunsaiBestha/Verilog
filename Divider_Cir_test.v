module Divider_Cir_test;
reg [7:0] Divisor,Dividend;
reg clk,ready;
wire[7:0] Quotient,Reminder;
Divider_Cir  DUT(clk,ready,Divisor,Dividend,Quotient,Reminder);
initial begin
    clk=1'b0;
    ready=1'b0;
     #2 ready=1'b1; 
     Dividend=8'b10000101;
      Divisor=8'b10001;
    #10 ready=1'b0;
      #200 $finish;
end
always #5 clk=~clk;
initial begin
    $dumpfile("Divider_Cir_test.vcd");
    $dumpvars(0,Divider_Cir_test);
end
endmodule