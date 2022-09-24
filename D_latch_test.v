module D_latch_test;
reg D,E;
wire Q,Qbar;
D_latch DUT(D,E,Q,Qbar);
initial begin
    $dumpfile("D_latch.vcd");
    $dumpvars(0,D_latch_test);
    $monitor($time,"D=%b,E=%b,Q=%b,Qbar=%b",D,E,Q,Qbar);
    #5 D=1;E=1;
    #5 D=0;E=0;
    #5 D=0;E=1;
    #5 D=1;E=0;
    #5 D=1;E=1;
    #5 D=0;E=0;
    #5 D=0;E=1;
    #5 D=1;E=0;
end
endmodule