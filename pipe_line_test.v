module pipe2_test;
wire[15:0] Z;
reg[3:0] rs1,rs2,rd,func;
reg[7:0] addr;
reg clk1,clk2;
integer k;
pipe_ex2 MYPIPE(Z,rs1,rs2,rd,func,addr,clk1,clk2);
initial begin
   clk1=0;clk2=0;
   repeat(20)
   begin
     #5 clk1=1; #5 clk1=0;
     #5 clk2=1; #5 clk2=0;
   end 
end
initial begin
    for(k=0;k<16;k=k+1)
    MYPIPE.regbank[k]=k;
end
initial begin
    #5 rs1=3;rs2=5;rd=10;func=0;addr=125;
    #20 rs1=3;rs2=8;rd=12;func=2;addr=126;
    #20 rs1=10;rs2=5;rd=14;func=1;addr=128;
    #60 for(k=125;k<131;k=k+1)
    $display("Mem[%3d]=%3d",k,MYPIPE.mem[k]);
end
initial begin
    $dumpfile("pipe2.vcd");
    $dumpvars(0,pipe2_test);
    $monitor("Time: %3d, F=%3d",$time,Z);
    #300 $finish;
end
endmodule