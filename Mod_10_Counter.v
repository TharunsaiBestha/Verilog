module D_flip_flop(D,clk,rst,Q);
input D,clk,rst;
output reg Q;
always @(posedge clk) begin
    if(rst)Q<=1'b0;
    else Q<=D;
end
endmodule
module Mod_10_Counter(clk,rst,res);
input clk;
input rst;
wire Q0,Q1,Q2,Q3;
wire Q1_bar,Q2_bar,Q3_bar;
output[3:0] res;
D_flip_flop D0(~Q0,clk,rst,Q0);
assign Q1_bar=((~Q3)&(~Q1)&Q0)|(Q1&(~Q0));
D_flip_flop D1(Q1_bar,clk,rst,Q1);
assign Q2_bar=(Q2&(~Q1))|(Q2&(~Q0))|((~Q2)&Q1&Q0);
D_flip_flop D2(Q2_bar,clk,rst,Q2);
assign Q3_bar=(Q3&(~Q0))|(Q2&Q1&Q0);
D_flip_flop D3(Q3_bar,clk,rst,Q3);
assign res={Q3,Q2,Q1,Q0};
endmodule