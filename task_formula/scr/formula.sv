module formula #(
	parameter width = 8
)
(
    input                             rst,
    input                             clk,

    input                             vld_in,
    input logic signed [width-1:0]    a, b, c, d,

    output                            vld_out,
    output logic signed [2*width+6:0] q
);

    // 1 стадия
    wire signed [width:0] a_minus_b = a - b; // a - b
    wire signed [width+1:0] c_mul_2 = c <<< 1; // 2 * c
    wire signed [width+3:0] c_mul_3 = c + c_mul_2; // 2 * c + c
    wire signed [width+3:0] c_mul_3_add_1 = c_mul_3 + 1'b1; // 3 * c + 1
    wire signed [width+2:0] d_mul_4 =  d <<< 2; // 4 * d

    // 2 стадия
    wire signed [2*width+3:0] a_minus_b_mul_c_mul_3_add_1 = a_minus_b * c_mul_3_add_1; // (a - b) * (3 * c + 1)

    // 3 стадия
    wire signed [2*width+4:0] numerator = a_minus_b_mul_c_mul_3_add_1 - d_mul_4; // (a - b) * (3 * c + 1) - 4 * d

    // 4 стадия
    wire signed [2*width+6:0] res = numerator >>> 1; // ((a - b) * (3 * c + 1) - 4 * d) / 2

    assign q = res;
    assign vld_out = 1'b1;

endmodule