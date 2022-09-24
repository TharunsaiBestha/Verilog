module Mod_10_Counter_test;
reg rst,clk;
wire[3:0] res;
Mod_10_Counter DUT(clk,rst,res);
initial 
begin
    $dumpfile("Mod_10_Counter.vcd");
    $dumpvars(0,Mod_10_Counter_test);
    $monitor($time,"res=%h",res);
    rst=1;#15 rst=0;
    #100 $finish;
    end
initial begin
    repeat(10)
    begin
      #5 clk=0;#5 clk=1;
    end
end
endmodule