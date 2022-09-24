module Floating_point_Division(Divisor,Dividend,Quotient);
input[31:0] Divisor;
input[31:0] Dividend;
output reg[31:0] Quotient;
reg[23:0] temp,tempDividend,tempDivisor,tempQ;
reg[7:0] exponent;
reg[4:0] shift;
integer  count,t1,t2;
always @(Divisor,Dividend) begin
    Quotient[31]=Divisor[31] ^ Dividend[31];
    temp=24'b0;
    shift=5'b00000;
    for(t1=0;t1<23;t1=t1+1)begin
      tempDividend[t1]=Dividend[22-t];
      tempDivisor[t]=Divisor[22-t];
    end
    tempDividend[23]=01'b1;
    tempDivisor[23]=01'b1;
    exponent=Dividend[30:23]-Divisor[30:23];
     for(count=0;count<24;count=count+1)
     begin
         temp=temp<<1;
       temp[0]=tempDividend[23];
       tempDividend=tempDividend<<1;
       if(temp>=tempDivisor)begin
         temp=temp-tempDivisor;
         tempDividend[0]=1'b1;
       end
       else begin
         tempDividend[0]=1'b0;
       end
         end
         for(t=0;t<24;t=t+1)
         begin
         tempQ[t]=tempDividend[23-t];
         end
         while(tempDividend[shift]==1'b0)begin
           shift=shift+1;
         end
       shift=shift+1;
         tempQ=tempQ<<shift;
         exponent=exponent+{3'b0,shift};
         exponent=exponent+8'b01111111;
         Quotient[30:0]={exponent,tempQ[23:1]};
 end
endmodule