module Divison_test;
reg[7:0] Divisor,Dividend;
wire[7:0] Quotient,Reminder;
Division_comb DUT(Divisor,Dividend,Quotient,Reminder);
initial begin
    //    rst=1'b1;
    // #1 rst=1'b0;
     #2 Dividend=8'b10000101;
      Divisor=8'b10001;
//      ready=1'b0;
//  #2 ready=1'b1;#2 ready=1'b0;
    // repeat(20)
    // begin
    //   #5 clk=1;#5 clk=0;
    // end
    #2 $finish;
end
// initial begin
//     repeat(10)
//     begin
//       #5 clk=0;#5 clk=1;
//     end
// end
initial begin
    $dumpfile("Divison_test.vcd");
    $dumpvars(0,Divison_test);
end
endmodule