module Division_float(Divisor,Dividend,Quotient);
input[22:0] Divisor,Dividend;
output reg[23:0] Quotient;
reg[23:0] tempDivisor,tempDividend,temp;
reg[4:0] shiftDivisor,shiftDividend,shiftQuotient;
integer count;
always @(Divisor,Dividend) begin
    shiftDivisor=5'b0;
    shiftDividend=5'b0;
    shiftQuotient=5'b11000;
    temp=24'b0;
    tempDivisor={1'b1,Divisor};
    tempDividend={1'b1,Dividend};
    while(tempDivisor[shiftDivisor]==1'b0)begin
      shiftDivisor=shiftDivisor+1;
    end
    while(tempDividend[shiftDividend]==1'b0)begin
      shiftDividend=shiftDividend+1;
    end
    tempDivisor=tempDivisor>>shiftDivisor;
    tempDividend=tempDividend>>shiftDividend;
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
        while(tempDividend[shiftQuotient-1]==1'b0 && shiftQuotient>5'b00000)begin
          shiftQuotient=shiftQuotient-1;
        end
        if(shiftQuotient==5'b00000)begin
      shiftQuotient=5'b0;
    end
    else begin
        shiftQuotient=5'b11000-shiftQuotient+1;
    end
        Quotient=tempDividend<<shiftQuotient;
end
endmodule