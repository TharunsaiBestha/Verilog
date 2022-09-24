module Mod10_behav(clk,res,rst);
input clk,rst;
output reg[3:0] res;
always @(posedge clk) begin
    if(rst==1'b1)res<=4'b0000;
    else if(res==4'b1001) res<=4'b0000;
    else res<=res+1;
end
endmodule