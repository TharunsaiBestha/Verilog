module Exponent_sub(Dividend_exponent,Divisor_exponent,exponent_out);
input[7:0] Dividend_exponent,Divisor_exponent;
output reg[7:0] exponent_out;
always @(*) begin
  exponent_out=Dividend_exponent-Divisor_exponent+8'b01111111;
end
endmodule
module Division_float(Dividend,Divisor,Quotient);
input[22:0] Divisor,Dividend;
output reg[22:0] Quotient;
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
        tempDividend=tempDividend<<shiftQuotient;
        Quotient=tempDividend[22:0];
end
endmodule
module FPD_32(Divisor,Dividend,Quotient);
input[31:0] Divisor,Dividend;
output [31:0] Quotient;
assign Quotient[31]=Dividend[31] ^ Divisor[31];
Exponent_sub E1(Dividend[30:23],Divisor[30:23],Quotient[30:23]);
Division_float D1(Dividend[22:0],Divisor[22:0],Quotient[22:0]);
endmodule