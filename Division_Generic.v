module Division_Generic(Divisor,Dividend,Quotient,Reminder);
parameter N = 24;
input [N-1:0] Divisor,Dividend;
output reg[N-1:0] Quotient,Reminder;
reg[N-1:0] temp,tempD;
integer count;
always @(Divisor,Dividend) 
begin
tempD=Dividend;
temp=24'b00000000;
        for(count=0;count<N;count=count+1)
        begin
        temp=temp<<1;
      temp[0]=tempD[N-1];
      tempD=tempD<<1;
      if(temp>=Divisor)begin
        temp=temp-Divisor;
        tempD[0]=1'b1;
      end
      else begin
        tempD[0]=1'b0;
      end
        end
    Quotient=tempD;
    Reminder=temp;
end
endmodule