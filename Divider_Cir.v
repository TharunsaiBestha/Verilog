module Arithmatic_Bloc(A,B,s,C);
parameter N = 8;
input[N-1:0] A,B;
output reg[N-1:0] C;
output reg s;
always @(*) begin
    s<=(A>B);
    C<=A-B;
end
endmodule
module Divider_Reg(A,B,A_temp,clk,ld,ld_u,in_bit,idle);
parameter N = 8;
input[N-1:0] A,A_temp;
output [N-1:0] B;
input clk,ld,ld_u,in_bit,idle;
reg[2*N-1:0] Q;
always @(posedge clk && ~idle) begin
    if(ld)begin
      Q={8'b0,A};
      Q={Q[N-2:0],in_bit};
    end
    else begin
    if(ld_u)begin
      Q={A_temp,Q[7:0]};
      Q={Q[N-2:0],in_bit};
      end
      else begin
        Q={Q[N-2:0],in_bit};
      end
    end
end
assign B=Q;
endmodule
module Counter(Q,clear,clk);
parameter N = 8;
input clk,clear;
output [N-1:0] Q;
reg [N-1:0] count;
always @(posedge clk) begin
    if(clear)count<=0;
    else count<=count+1;
end
assign Q=count;
endmodule
module Mux(A,B,in,out);
parameter N = 8;
input[N-1:0] A,B;
output [N-1:0] out;
input in;
assign out=in?A:B;
endmodule
module Controller(clk,idle,count,clear,ld,ready);
parameter N = 8;
input[N-1:0] count;
input ready,clk;
output reg idle,clear,ld;
parameter S0 =1'b0,S1=1'b1;
reg state;
always @(ready) begin
    state<=S0;
end
always @(posedge clk) begin
    case(state)
    S0:state<=ready?S1:S0;
    S1:state<=count<8?S1:S0;
    endcase
end
always @(state) begin
    case(state)
    S0:begin idle<=1;clear<=1;ld<=1;end
    S1:begin idle<=0;clear<=0;ld<=0;end
    endcase
end
endmodule
module Divider_Cir(clk,ready,Divisor,Dividend,Quotient,Reminder);
parameter N = 8;
input [N-1:0] Divisor,Dividend;
input clk,ready;
output[N-1:0] Quotient,Reminder;
wire idle,clear,ld,in_bit;
wire[N-1:0] count,AB_out;
wire[2*N-1:0] Reg_out;
Controller C1(clk,idle,count,clear,ld,ready);
Counter Co1(count,clear,clk);
Divider_Reg R1(Dividend,Reg_out[2*N-1:N],AB_out,clk,ld,in_bit,in_bit,idle);
Arithmatic_Bloc A1(Reg_out[2*N-1:N],Divisor,in_bit,AB_out);
endmodule