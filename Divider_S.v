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
module Comparator(A,B,en,res);
parameter  N= 8;
input[N-1:0] A,B;
input en;
output reg res;
always @(posedge en) begin
    res<=(A>=B)?1:0;
end
endmodule
module subtractor(A,B,en,C);
parameter N =8;
input [N-1:0] A,B;
output reg [N-1:0] C;
input en;
always @(posedge en) begin
    C<=A-B;
end
endmodule
module Shifter(A,B,in_bit,en,ld,clk);
parameter N =16;
input en,in_bit,clk,ld;
input[N-1:0] A;
output[N-1:0] B;
reg[N-1:0] Q;
always @(posedge clk) begin
    if(en)begin
      Q<=ld?A:{Q[N-2:0],in_bit};
    end
end
assign B=Q;
endmodule
module Mux(A,B,in,out);
parameter N = 8;
input[N-1:0] A,B;
output [N-1:0] out;
input in;
assign out=in?A:B;
endmodule
module Output_reg(A,B,in);
parameter N = 8;
input in;
input[N-1:0] A;
output reg[N-1:0] B;
always @(in) begin
    B<=A;
end
endmodule
module Controller(clk,ready,mux_in,shifter_en,Comparator_en,subtractor_en,Comparator_res,shift_bit,count,counter_clr,output_en,sh_ld);
parameter N =8;
parameter clk_cyc = 15;
input clk,Comparator_res,ready;
input[7:0] count;
output reg shifter_en,Comparator_en,subtractor_en,shift_bit,counter_clr,mux_in,output_en,sh_ld;
parameter  S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11;
reg[1:0] state,next_state;
always @(posedge ready) begin
    state<=S0;
end
always @(posedge clk) begin
    case(state)
    S0:state<=ready?S1:S0;
    S1:state<=S2;
    S2:state<=(count<clk_cyc)?S3:S0;
    S3:state<=(count<clk_cyc)?S2:S0;
    endcase
end
always @(state) begin
  case(state)
  S0:begin counter_clr<=1;shifter_en<=0;Comparator_en<=0;subtractor_en<=0;mux_in<=0;shift_bit<=0;output_en<=1;sh_ld<=0;end
  S1:begin counter_clr<=1;shifter_en<=1;Comparator_en<=0;subtractor_en<=0;mux_in<=0;output_en<=0;sh_ld<=1;end
  S2:begin counter_clr<=0;shifter_en<=0;Comparator_en<=1;subtractor_en<=1;mux_in<=1;output_en<=0;sh_ld<=0;end
  S3:begin shift_bit<=Comparator_res;shifter_en<=1;Comparator_en<=0;subtractor_en<=0;output_en<=0;sh_ld<=0;end
  endcase
end
endmodule
module Divider_S(clk,ready,Divisor,Dividend,Quotient,Reminder);
parameter N = 8;
input [N-1:0] Divisor,Dividend;
input clk,ready;
output[N-1:0] Quotient,Reminder;
wire[2*N-1:0] temp_in,temp_out;
wire[N-1:0] Sub_res,M1_res;
wire [N-1:0] count;
wire mux_in,shifter_en,Comparator_en,Comparator_res,subtractor_en,counter_clr,shift_bit,output_en,sh_ld;
//assign temp_in[7:0]=Dividend;
Counter Coun1(count,counter_clr,clk);
Mux M1(Sub_res,temp_out[2*N-1:N],Comparator_res,M1_res);
Mux M2(M1_res,8'b0,mux_in,temp_in[2*N-1:N]);
Mux M3(temp_out[N-1:0],Dividend,mux_in,temp_in[N-1:0]);
Shifter S1(temp_in,temp_out,shift_bit,shifter_en,sh_ld,clk);
Comparator C1(temp_out[2*N-1:N],Divisor,Comparator_en,Comparator_res);
subtractor Su1(temp_out[2*N-1:N],Divisor,subtractor_en,Sub_res);
Controller Co1(clk,ready,mux_in,shifter_en,Comparator_en,subtractor_en,Comparator_res,shift_bit,count,counter_clr,output_en,sh_ld);
Output_reg O1(temp_in[2*N-1:N],Reminder,output_en);
Output_reg O2(temp_in[N-1:0],Quotient,output_en);
//assign Reminder=output_en?temp_in[15:8]:Reminder;
//assign Quotient=output_en?{temp_in[6:0],Comparator_en}:Quotient;
endmodule