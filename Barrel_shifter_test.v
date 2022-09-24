module Barrel_shifter_test;
reg[7:0] in;
reg[2:0] sel;
wire[7:0] out;
Barrel_shifter DUT(in,sel,out);
initial begin
    #5 in=8'b11110101;sel=3'b001;
    #5 in=8'b11110101;sel=3'b010;
    #5 in=8'b11110101;sel=3'b100;
    #5 in=8'b11110101;sel=3'b011;
    #5 $finish;
end
initial begin
    $dumpfile("Barrel_shifter.vcd");
    $dumpvars(0,Barrel_shifter_test);
end
endmodule