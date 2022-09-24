module FPDS_test;
reg[31:0] Divisor,Dividend;
reg clk,ready;
wire [31:0] Quotient;
FPDS_32 DUT(Divisor,Dividend,Quotient,clk,ready);
initial begin
    clk=1'b0;
     ready=1'b0;
      Dividend=32'b01000010101101101011000000000000; //91.34375
      Divisor=32'b00111110000101000000000000000000; //0.14453125
 //    Dividend=32'b00111111100000000000000000000000;
    //    Divisor=32'b01000000000000000000000000000000;
        #1 ready=1'b1;
    #300 ready=1'b0; 
    #305 ready=1'b1;
    //  Dividend=32'b00111111100000000000000000000000;
    //     Divisor=32'b01000000000000000000000000000000;
    #1000 $finish;
end
always #5 clk=~clk;
initial begin
    $dumpfile("FPDS_test.vcd");
    $dumpvars(0,FPDS_test);
end
endmodule