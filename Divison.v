module Divison(Q,D,R,clk,ready);
input [7:0] D,Q;
output reg[7:0] R;
reg[7:0] temp,tempD;
input clk,ready;
reg[3:0] count;
always @(posedge ready) begin
    tempD<=D;
    count<=4'b0000;
    temp<=8'b00000000;
end
always @(posedge clk) begin
    if(count<8)begin
      temp=temp<<1;
      temp[0]=tempD[7];
      tempD=tempD<<1;
      if(temp>=Q)begin
        temp=temp-Q;
        tempD[0]=1'b1;
      end
      else begin
        tempD[0]=1'b0;
      end
      count=count+1;
    end
    else begin
      R=tempD;
    end
end
endmodule
