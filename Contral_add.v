module PIPO1(dout,din,ld,clk);
input[15:0] din;
input ld,clk;
output reg[15:0] dout;
always @(posedge clk) 
begin
    if(ld)dout<=din;
end
endmodule

module PIPO2(dout,din,ld,clr,clk);
input[15:0] din;
input ld,clr,clk;
output reg[15:0] dout;
always @(posedge clk) begin
if(ld)dout<=din;
else if(clr)dout<=16'b0;    
end
endmodule

module add(out,in1,in2);
input[15:0] in1,in2;
output reg [15:0] out;
always @(*) begin
    out=in1+in2;
end
endmodule

module EQZ(din,e);
input[15:0] din;
output e;
assign e=(din==0);
endmodule
module CNTR(dout,din,ld,dec,clk);
input[15:0] din;
input ld,dec,clk;
output reg[15:0] dout;
always @(posedge clk) begin
    if(ld) dout<=din;
    else if(dec) dout<=dout-1;
end
endmodule
module MUL_datapath(eqz,lda,ldb,ldp,clrp,decb,data_in,clk);
input eqz,lda,ldb,ldp,clrp,decb,clk;
input[15:0] data_in;
wire [15:0] X,Y,Z,Bout,Bus;
assign Bus=data_in;
PIPO1 A(X,Bus,lda,clk);
PIPO2 B(Y,Z,ldp,clrp,clk);
add C(Z,X,Y);
CNTR D(Bout,Bus,ldb,decb,clk);
EQZ E(Bout,eqz);
endmodule
module controller(lda,ldb,ldp,clrp,decb,done,clk,eqz,start);
input clk,eqz,start;
output reg lda,ldb,ldp,clrp,decb,done;
reg[2:0] state;
parameter  S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100;
always @(posedge clk) begin
  case(state)
  S0:if(start)state<=S1;
  S1:state<=S2;
  S2:state<=S3;
  S3:#2 if(eqz) state<=S4;
  S4:state<=S4;
  default:state<=S0;
  endcase
end
always @(state) begin
    case(state)
    S0:begin #1 lda=0;ldb=0;ldp=0;clrp=0;decb=0;done=0;end
    S1:begin #1 lda=1;end
    S2:begin #1 lda=0;ldb=1;clrp=1;end
    S3:begin #1 ldb=0;ldp=1;clrp=0;decb=1;end
    S4:begin #1 done=1;ldb=0;ldp=0;decb=0;end
    default:begin #1 lda=0;ldb=0;ldp=0;clrp=0;decb=0;done=0;end
    endcase
end    
endmodule