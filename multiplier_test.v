`timescale 1ps/1ps
module multiplier_test;
reg[3:0] A,B;
wire[7:0] M;
multiplier DUT(A,B,M);
initial begin
    $dumpfile("multiplier.vcd");
    $dumpvars(0,multiplier_test);
    $monitor($time,"A=%h,B=%h,M=%h",A,B,M);
    #5 A=4'b0011;B=4'b0101;
    #5 A=4'b0010;B=4'b0010;
    #5 A=4'b1001;B=4'b1001;
    #5 $finish;
end
endmodule