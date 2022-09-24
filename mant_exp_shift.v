module mant_exp_shift(mantissa_in,exponent_in,mantissa_out,exponent_out,shift);
input[23:0] mantissa_in;
output[23:0] mantissa_out;
input[7:0] exponent_in;
output[7:0] exponent_out;
input[4:0] shift;
integer c;
always @(*) begin
    mantisaa_out<=mantissa_in<<shift;
    exponent_out<=exponent_in-shift+1;
end
endmodule