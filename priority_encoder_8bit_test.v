`timescale 1ps/1ps
module priority_encoder_8bit_test;
reg[7:0] A;
wire[2:0] B;
priority_encoder_8bit DUT(A,B);
initial begin
    A=8'b00000000;
    #5 A=8'b01001010;
    #5 A=8'b11001010;
    #5 $finish;
end
initial begin
    $dumpfile("priority_encoder_8bit_test.vcd");
    $dumpvars(0,priority_encoder_8bit_test);
end
endmodule