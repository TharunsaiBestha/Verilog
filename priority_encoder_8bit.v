module priority_encoder_8bit(A,B);
input[7:0] A;
output reg[2:0] B;
always @(*)
begin
casex (A)
    8'b00000001:B=3'b000;
    8'b0000001x:B=3'b001;
    8'b000001xx:B=3'b010;
    8'b00001xxx:B=3'b011;
    8'b0001xxxx:B=3'b100;
    8'b001xxxxx:B=3'b101;
    8'b01xxxxxx:B=3'b110;
    8'b1xxxxxxx:B=3'b111;
    default:B=3'bxxx;
endcase
end
endmodule