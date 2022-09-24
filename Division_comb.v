module Division_comb(Divisor,Dividend,Quotient,Reminder);
input [7:0] Divisor,Dividend;
output reg[7:0] Quotient,Reminder;
reg[7:0] temp,tempD;
integer count;
// always @(posedge ready) begin
//     tempD<=D;
//     temp<=8'b00000000;
// end
always @(Divisor,Dividend) 
begin
tempD=Dividend;
temp=8'b00000000;
        for(count=0;count<8;count=count+1)
        begin
        temp=temp<<1;
      temp[0]=tempD[7];
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