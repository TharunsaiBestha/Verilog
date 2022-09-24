module Division_seq(Divisor,Dividend,Quotient,Reminder,clk,ready);
parameter N = 8;
input [N-1:0] Divisor,Dividend;
input clk,ready;
output reg[N-1:0] Quotient,Reminder;
reg[2*N-1:0] Q;
reg[3:0] count;
reg res;
always @(posedge ready) begin
    Q={8'b0,Dividend};
    count=0;
    res=1'b0;
end
always @(posedge res) begin
    Quotient=Q[N-1:0];
    Reminder=Q[2*N-1:N];
end
always @(posedge clk) begin
    if(count<8)begin
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