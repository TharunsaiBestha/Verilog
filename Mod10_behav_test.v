module Mod10_behav_test;
reg clk,rst;
wire[3:0] res;
Mod10_behav DUT(clk,res,rst);
initial 
begin
    $dumpfile("Mod10_behav.vcd");
    $dumpvars(0,Mod10_behav_test);
    $monitor($time,"res=%h",res);
    rst=1;#15 rst=0;
    #200 $finish;
    end
initial begin
    repeat(20)
    begin
      #5 clk=0;#5 clk=1;
    end
end
endmodule