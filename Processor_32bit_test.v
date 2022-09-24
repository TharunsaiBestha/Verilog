module Processor_32bit_test;
reg[31:0] ins;
wire[31:0] rd_data;
reg clk;
reg rst;
Processor_32bit P1(clk,rst,ins,rd_data);
initial 
begin
    clk=1'b0;
    ins=32'b00000000000000001000000100110011;
    P1.R1.mem[0]=32'h0000000F;
    P1.R1.mem[1]=32'h0000000C;
    #35 ins=32'b01000000000000001000000110110011;
    P1.R1.mem[0]=32'h0000000C;
    P1.R1.mem[1]=32'h0000000F;
    #20 ins=32'b00000000000000001001000100110011;
    P1.R1.mem[0]=32'h00000004;
    P1.R1.mem[1]=32'hFF0000FF;
    #20 ins=32'b00000000000000001010000100110011;
    P1.R1.mem[0]=32'hF0000000;
    P1.R1.mem[1]=32'h70000000;
    #20 ins=32'b00000000000000001011000100110011;
    P1.R1.mem[0]=32'hF0000000;
    P1.R1.mem[1]=32'h70000000;
    #20 ins=32'b00000000000000001100000100110011;
    P1.R1.mem[0]=32'h0000000C;
    P1.R1.mem[1]=32'h0000000F;
    #20 ins=32'b00000000000000001101000100110011;
    P1.R1.mem[0]=32'h00000004;
    P1.R1.mem[1]=32'hFF0000FF;
    #20 ins=32'b01000000000000001101000100110011;
    P1.R1.mem[0]=32'h00000004;
    P1.R1.mem[1]=32'hFF0000FF;
    #20 ins=32'b00000000000000001110000100110011;
    P1.R1.mem[0]=32'h0000000C;
    P1.R1.mem[1]=32'h0000000F;
    #20 ins=32'b00000000000000001111000100110011;
    P1.R1.mem[0]=32'h0000000C;
    P1.R1.mem[1]=32'h0000000F;
    #50 $finish;
end
always #5 clk=~clk;
initial begin
    #1 rst=1;
    #1 rst=0;
end
initial begin
    $dumpfile("Processor_32bit.vcd");
    $dumpvars(0,Processor_32bit_test);
end
endmodule