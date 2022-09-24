module T_flip_flop(T,clk,rst,Q);
input clk,rst,T;
output reg Q;
always @(posedge clk) begin
    if(rst)Q<=0;
    else
    if(T)Q<=~Q;
    else Q<=Q;
end
