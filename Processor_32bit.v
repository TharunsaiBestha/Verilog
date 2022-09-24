module Decoder(ins,rs1_addr,rs2_addr,rd_addr,fun,s_i);
//input clk;
input[31:0] ins;
output reg[5:0] rs1_addr,rs2_addr,rd_addr;
output reg[2:0] fun;
output reg s_i;
always @(*) begin
s_i<=ins[30];
rs1_addr<=ins[19:15];
rs2_addr<=ins[24:20];
rd_addr<=ins[11:7];
fun<=ins[14:12]; 
end
endmodule
module Reg_Bank(clk,rs1_addr,rs2_addr,rd_addr,r_e,w_e,rs1_data,rs2_data,rd_data);
reg[31:0] mem[31:0];
input[5:0] rs1_addr,rs2_addr,rd_addr;
output reg[31:0] rs1_data,rs2_data;
input[31:0] rd_data;
input r_e,w_e,clk;
always @(posedge clk) begin
    if(r_e)begin
  rs1_data<=mem[rs1_addr];
  rs2_data<=mem[rs2_addr];
end
else if(w_e)begin
  mem[rd_addr]<=rd_data;
end
end
endmodule
module ALU(rs1_data,rs2_data,rd_data,opcode,s_i);
input[31:0] rs1_data,rs2_data;
output reg[31:0] rd_data;
input[2:0] opcode;
input s_i;
reg[31:0] temp;
parameter  ADD_SUB=3'b000,SLL=3'b001,SLT=3'b010,SLTU=3'b011,XOR=3'b100,SRL_SRA=3'b101,OR=3'b110,AND=3'b111;
always @(*) begin
case(opcode)
ADD_SUB:rd_data<=s_i?rs1_data-rs2_data:rs1_data+rs2_data;
SLL    :rd_data<=(rs1_data<<rs2_data[4:0]);
SLT    :rd_data<=$signed(rs1_data)<$signed(rs2_data);
SLTU   :rd_data<=rs1_data<rs2_data;
XOR    :rd_data<=rs1_data^rs2_data;
SRL_SRA:begin
if(s_i)begin
 temp=~(({32{rs1_data[31]}})>>rs2_data[4:0]);
 //assign temp=~(temp>>rs2_data[4:0]);
rd_data<=temp | rs1_data>>rs2_data[4:0]; 
end
else
rd_data<=rs1_data>>rs2_data[4:0];
end
OR     :rd_data<=rs1_data|rs2_data;
AND    :rd_data<=rs1_data&rs2_data;
endcase
end
endmodule
module controller(clk,r_e,w_e,rst);
output reg r_e,w_e;
input clk,rst;
reg S;
parameter  S0=1'b0,S1=1'b1;
always @(rst) begin
  if(rst) S<=S0;
end
always @(posedge clk) begin
  case(S)
  S0:begin r_e<=1'b1;w_e<=1'b0;S<=S1; end
  S1:begin r_e<=1'b0;w_e<=1'b1;S<=S0; end
  endcase
end
endmodule
module Processor_32bit(clk,rst,ins,rd_data);
input clk,rst;
input[31:0] ins;
wire[5:0] rs1_addr,rs2_addr,rd_addr;
wire[31:0] rs1_data,rs2_data;
//,rd_data;
inout[31:0] rd_data;
wire[2:0] opcode;
wire s_i,w_e,r_e;
Decoder D1(ins,rs1_addr,rs2_addr,rd_addr,opcode,s_i);
Reg_Bank R1(clk,rs1_addr,rs2_addr,rd_addr,r_e,w_e,rs1_data,rs2_data,rd_data);
ALU A1(rs1_data,rs2_data,rd_data,opcode,s_i);
controller C1(clk,r_e,w_e,rst);
endmodule