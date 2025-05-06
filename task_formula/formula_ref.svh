function [22:0] formula_ref (
    input logic signed [22:0] a,
    input logic signed [22:0] b,
    input logic signed [22:0] c,
    input logic signed [22:0] d
);

    logic signed [23:0] a_minus_b;
    logic signed [24:0] c_mult3;
    logic signed [24:0] term2; 
    logic signed [49:0] product;
    logic signed [49:0] d_mult4;
    logic signed [49:0] final_result;

    a_minus_b = a - b;
    c_mult3   = 3 * c;
    term2     = 1 + c_mult3;
    product   = a_minus_b * term2;
    d_mult4   = 4 * d;
    final_result = product - d_mult4;

    return $signed(final_result >>> 1);
endfunction