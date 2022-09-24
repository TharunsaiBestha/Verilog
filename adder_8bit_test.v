`timescale 1ps/1ps
module adder_8bit_test;
reg[7:0] A,B;
wire[7:0] S;
reg C_in;
wire C_out;
adder_8bit DUT(A,B,C_in,S,C_out);
initial begin
    C_in=1'b0;
    #5 A=8'b00001100;B=8'b00000011;
    #5 $finish; 
end
initial begin
    $dumpfile("adder_8bit_test.vcd");
    $dumpvars(0,adder_8bit_test);
end
endmodule