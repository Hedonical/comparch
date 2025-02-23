`timescale 10ns/10ns
`include "top.sv"

module top_tb;

    logic clk = 0;
    logic RGB_R;
    logic RGB_G;
    logic RGB_B;

    top u0 (
        .clk     (clk), 
        .RGB_B  (RGB_B),
        .RGB_R  (RGB_R),
        .RGB_G   (RGB_G)
    );

    initial begin
        $dumpfile("top.vcd");
        $dumpvars(0, top_tb);
        #60000000
        $finish;
    end

    always begin
        #4
        clk = ~clk;
    end

endmodule