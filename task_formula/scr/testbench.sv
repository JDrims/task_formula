module tb #(
	parameter width = 8,
    parameter width_out = 2 * width + 6
);

    `include "formula_ref.svh"
    //------------------------------------------------------------------------
    logic clk;
    logic rst;

    initial
    begin
        clk = '0;
        forever
        # 10 clk = ~ clk;
    end

    initial
    begin
        rst <= 'x;
        repeat (2) @ (posedge clk);
        rst <= '1;
        repeat (2) @ (posedge clk);
        rst <= '0;
    end

    reg                       vld_in = 1'b1;
    reg signed [width-1:0]    a, b, c, d;

    wire                      vld_out;
    wire signed [width_out-1:0] q; 
    reg  signed [width_out-1:0] q_expected;
    reg  signed [width_out-1:0] q_expected_svh;   

    //------------------------------------------------------------------------

    formula
    # (
        .width (width)
    )
    formula_DUT
    (
    .clk      (clk    ),
    .rst      (rst    ),

    .vld_in   (vld_in ),
    .a        (a      ),
    .b        (b      ),
    .c        (c      ),
    .d        (d      ),

    .vld_out  (vld_out),
    .q        (q      )

    );

    
    // PYTHON
    //------------------------------------------------------------------------

    reg [8:0] sort = 0;
    logic [width_out-1:0] test_cases [0:499];
    logic [7:0] counter = 0;

    initial
    begin
        $readmemb("C:/test_cases.txt", test_cases);
    end

    initial
    begin

        `ifdef __ICARUS__
            $dumpvars;
        `endif

        @ (posedge clk);
        @ (negedge rst);
        repeat (50) 
        begin
            @ (posedge clk);
            #1

            vld_in = 1;
                
            a = test_cases [sort];
            b = test_cases [sort+1];
            c = test_cases [sort+2];
            d = test_cases [sort+3];
            q_expected = test_cases[sort+4];

            sort = sort + 3'd5;
            counter = counter + 1'b1;
        end
        $finish;
    end

    event check_moment;

    always @ (posedge clk)
    begin
        if (vld_out && counter != 0) begin
            if (q !== q_expected)
            begin
                $display ("FAIL %d: res mismatch. Expected %0d, actual %0d", counter, q_expected, q);
            end
            else 
            begin
                $display ("PASS %d: res ok. Expected %0d, actual %0d", counter, q_expected, q);
                -> check_moment;
            end   
        end 
    end

    // Testbench
    //------------------------------------------------------------------------

	// logic [4:0] counter = 0;
    // logic [width_out-1:0] res_expected;

    // initial
    // begin
    
    //     `ifdef __ICARUS__
    //         $dumpvars;
    //     `endif

    //     #500
    //     $finish;
    // end        

    // always @ (posedge clk)
    // begin
    //     begin
    //         if (vld_in & !rst)
    //         begin
    //             a = $urandom();
    //             b = $urandom();
    //             c = $urandom();
    //             d = $urandom();
    //             counter = counter + 1;
    //             res_expected = formula_ref (a, b, c, d);
    //         end
    //         #1
    //         if (vld_out & !rst)
    //         begin
    //             if (q !== res_expected)
    //             begin
    //                 $display ("FAIL %d: res mismatch. Expected %0d, actual %0d", counter, (res_expected), q);
    //             end
    //             else
    //             begin
    //                 $display ("PASS %d: res ok. Expected %0d, actual %0d", counter, (res_expected), q);
    //             end
    //         end
    //     end     
    // end

endmodule