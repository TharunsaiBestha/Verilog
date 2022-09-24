module D_latch(D,E,Q,Qbar);
input D,E;
output Q,Qbar;
wire t1,t2;
assign t1=D&E;
assign t2=(~D)&E;
assign Qbar=~(t1 | Q);
assign Q=~(t2 | Qbar);
endmodule