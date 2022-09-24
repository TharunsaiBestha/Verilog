module Division_seq_test;
reg[7:0] Divisor,Dividend;
wire[7:0] Quotient,Reminder;
reg ready,clk;
Division_seq DUT(Divisor,Dividend,Quotient,Reminder,clk,ready);
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
    $dumpfile("Division_seq_test.vcd");
    $dumpvars(0,Division_seq_test);
end
endmodule