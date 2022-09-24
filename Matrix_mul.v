module counter(clk,clr,i,j,k);
parameter N = 4;
input clk;
input clr;
output reg i,j;
always @(posedge clr) begin
    i<=0;
    j<=0;
    k<=0;
end
always @(posedge clk) begin
    if(k==N-1 && j=N-1)begin
      i=i+1;
      j=0;
      k=0;
    end
    else if(k==N-1)begin
      k=0;j=j+1;
    end
    else begin
      k=k+1;
    end
end
endmodule