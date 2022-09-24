module adder(A,B,C_in,S,C_out);
input A,B,C_in;
output C_out,S;
assign S=A^B^C_in;
assign C_out=(A&B)|(B&C_in)|(A&C_in);
endmodule
module myand(A,B,C);
input A,B;
output C;
assign C=A&B;
endmodule
module adder_4bit(A,B,C_in,S,C_out);
input[3:0] A,B;
output[3:0] S;
input C_in;
output C_out;
wire[2:0] C;
adder A0(A[0],B[0],C_in,S[0],C[0]);
adder A1(A[1],B[1],C[0],S[1],C[1]);
adder A2(A[2],B[2],C[1],S[2],C[2]);
adder A3(A[3],B[3],C[2],S[3],C_out);
endmodule
module and_4bit(A,B,C);
input[3:0] A,B;
output[3:0] C;
myand A0(A[0],B[0],C[0]);
myand A1(A[1],B[1],C[1]);
myand A2(A[2],B[2],C[2]);
myand A3(A[3],B[3],C[3]);
endmodule
module multiplier(A,B,M);
input[3:0] A,B;
output[7:0] M;
wire[3:0] B0={4{B[0]}};
wire[3:0] B1={4{B[1]}};
wire[3:0] B2={4{B[2]}};
wire[3:0] B3={4{B[3]}};
wire[3:0] A_1,A_1_0,B_1,A_2,B_2,A_3,B_3,S1,S2,S3;
wire C_out1,C_out2,C_out3;
and_4bit AND0(A,B0,A_1_0);
and_4bit AND1(A,B1,B_1);
assign M[0]=A_1_0[0];
assign A_1={1'b0,A_1_0[3:1]};
adder_4bit ADD0(A_1,B_1,1'b0,S1,C_out1);
assign A_2={C_out1,S1[3:1]};
assign M[1]=S1[0];
and_4bit AND3(A,B2,B_2);
adder_4bit ADD1(A_2,B_2,1'b0,S2,C_out2);
assign M[2]=S2[0];
assign A_3={C_out2,S2[3:1]};
and_4bit AND4(A,B3,B_3);
adder_4bit ADD2(A_3,B_3,1'b0,S3,C_out3);
assign M[7:3]={C_out3,S3};
endmodule
