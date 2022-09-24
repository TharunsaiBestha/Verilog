module Encoder(A,res);
parameter N = 24;
input[N-1:0] A;
output reg[4:0] res;
integer n;
always @(*) begin
    for(n=0;n<24;n=n+1)
    if(A[n])res=n;
end
endmodule
module adjust_mantissa(A,B,A_out,B_out);
parameter N =24;
input[N-1:0] A,B;
output [N-1:0] A_out,B_out;
wire[N-1:0] temp_A,temp_B;
wire[4:0] temp_res_A,temp_res_B;
//reg[N-1:0] temp_reg_A,temp_reg_B;
assign temp_A=A ^ (A&(A-1));
assign temp_B=B ^ (B&(B-1));
Encoder E1(temp_A,temp_res_A);
Encoder E2(temp_B,temp_res_B);
assign A_out=A>>temp_res_A;
assign B_out=B>>temp_res_B;
endmodule
module Division_seq(Divisor,Dividend,Quotient,clk,ready);
parameter N = 24;
input [N-1:0] Divisor,Dividend;
input clk,ready;
output reg[N-1:0] Quotient;
//,Reminder;
reg[2*N-1:0] Q;
reg[4:0] count;
reg res;
always @(posedge ready) begin
    Q={24'b0,Dividend};
    count=0;
    res=1'b0;
end
always @(posedge res) begin
    Quotient=Q[N-1:0];
  //  Reminder=Q[2*N-1:N];
end
always @(posedge clk) begin
    if(count<24)begin
      Q=Q<<1;
      if(Q[2*N-1:N]>=Divisor)begin
        Q[2*N-1:N]=Q[2*N-1:N]-Divisor;
        Q[0]=1'b1;
      end
      else begin
        Q[0]=1'b0;
      end
      count=count+1;
    end
    else begin
      res=1'b1;
    end
end
endmodule
module flip_bits(A,B);
parameter N = 24;
input[N-1:0] A;
output reg[N-1:0] B;
integer n;
always @(*) begin
for(n=23;n>=0;n=n-1)begin
B[n]=A[23-n];
end
end
endmodule
module Exponent_sub(Dividend_exponent,Divisor_exponent,exponent_out);
input[7:0] Dividend_exponent,Divisor_exponent;
output reg[7:0] exponent_out;
always @(*) begin
  exponent_out=Dividend_exponent-Divisor_exponent+8'b01111111;
end
endmodule
module Foloating_point_Division(Divisor,Dividend,Quotient,clk,ready);
parameter N = 24;
input [N-1:0] Divisor,Dividend;
input clk,ready;
output [N-2:0] Quotient;
wire [N-1:0] temp_Divisor,temp_Dividend,temp_Quotient,temp_rev_Q,temp,temp_Q;
wire[4:0] bit_shift;
adjust_mantissa AM(Divisor,Dividend,temp_Divisor,temp_Dividend);
Division_seq DS(temp_Divisor,temp_Dividend,temp_Quotient,clk,ready);
flip_bits FB(temp_Quotient,temp_rev_Q);
assign temp=temp_rev_Q ^ (temp_rev_Q &(temp_rev_Q-1));
Encoder E1(temp,bit_shift);
assign temp_Q=temp_Quotient<<bit_shift;
assign Quotient=temp_Q[N-2:0];
endmodule
module FPDS_32(Divisor,Dividend,Quotient,clk,ready);
input[31:0] Divisor,Dividend;
input clk,ready;
output [31:0] Quotient;
assign Quotient[31]=Dividend[31] ^ Divisor[31];
Exponent_sub E1(Dividend[30:23],Divisor[30:23],Quotient[30:23]);
Foloating_point_Division D1({1'b1,Divisor[22:0]},{1'b1,Dividend[22:0]},Quotient[22:0],clk,ready);
endmodule