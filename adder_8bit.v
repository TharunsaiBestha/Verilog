module adder(A,B,C_in,S,C_out);
input A,B,C_in;
output C_out,S;
assign S=A^B^C_in;
assign C_out=(A&B)|(B&C_in)|(A&C_in);
endmodule
module adder_8bit(A,B,C_in,S,C_out);
input[7:0] A,B;
output[7:0] S;
input C_in;
output C_out;
wire[6:0] C;
adder A0(A[0],B[0],C_in,S[0],C[0]);
adder A1(A[1],B[1],C[0],S[1],C[1]);
adder A2(A[2],B[2],C[1],S[2],C[2]);
adder A3(A[3],B[3],C[2],S[3],C[3]);
adder A4(A[4],B[4],C[3],S[4],C[4]);
adder A5(A[5],B[5],C[4],S[5],C[5]);
adder A6(A[6],B[6],C[5],S[6],C[6]);
adder A7(A[7],B[7],C[6],S[7],C_out);
endmodule