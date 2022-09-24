module counter(in,out,clk,counter_en);
parameter N =3;
input[N-1:0] in;
input counter_en,clk;
output[N-1:0] out;
always @(posedge clk) begin
    if(counter_en)begin
    out=in+1;end
    else begin
      out=0;
    end
end
endmodule
module ALU(A,B,C,ALU_en);
parameter N =8;
input[N-1:0] A,B;
input ALU_en;
output[N-1:0] C;
always @(*) begin
    if(ALU_en)begin
    C=A-B;end
    else begin
      C=0;
    end
end
endmodule
module Shift(in,out,shift_en,clk);
parameter N = 8;
input[N-1:0] in;
input clk;
output[N-1:0] out;
always @(posedge clk) begin
    if(shift_en)begin
      out=in<<1;
    end
end
endmodule
module Controller(num,counter_in,counter_en,ALU_en,shift_en,rst,clk);
parameter N = 3;
input[N-1:0] counter_in,num;
input rst,clk;
output counter_en,ALU_en,shift_en;
always @(posedge clk) begin
    if(!rst)begin
      if(counter_in<num)begin
      shift_en=1'b1;ALU_en=1'b1;counter_en=1'b1;
      end
      else
    begin
      ALU_en=1'b0;shift_en=1'b0;counter_en=1'b0;
    end
    end
    else
    begin
      ALU_en=1'b0;shift_en=1'b0;counter_en=1'b0;
    end
end
endmodule
module Divison_seq(Divisor,Dividend,Quotient,Reminder,clk,rst);
parameter N = 8;
parameter CN = 3;
input[N-1:0] Divisor,Dividend,Quotient,Reminder;
reg[2*N-1:0] X;
input rst,clk;
reg[CN-1:0] num;
wire[CN-1:0] counter_in;
wire counter_en,ALU_en,shift_en;
assign num=32;
assign X={8'b0,Dividend};
Controller C1(num,counter_in,counter_en,ALU_en,shift_en,rst,clk);
ALU A1(X[2*N-1:N+1],Quotient,ALU_en);
counter Co1(counter_in,counter_in,clk,counter_en);
Shift S1(X,X,shift_en,clk);
assign {Reminder,Quotient}=X;
endmodule