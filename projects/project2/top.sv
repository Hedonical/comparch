`include "pwm.sv"
`include "ramp.sv"


module top(
    input logic clk,
    output logic    RGB_G,
    output logic    RGB_R,
    output logic    RGB_B
);
    logic red_out;
    integer red;

    logic green_out;
    integer green;

    logic blue_out;
    integer blue;

    // red led
    ramp #(
        .steps (7'b1100011)
    )
    u1 (
        .clk (clk),
        .pwm_value (red)
    );

    // green led
    ramp #(
        .steps (7'b0111000)
    )
    u2 (
            .clk (clk),
            .pwm_value (green)
        );
    
    // blue led
    ramp #(
        .steps (7'b0001110)
    )
    u3 (
        .clk (clk),
        .pwm_value (blue)
    );

    pwm u4 (
        .clk (clk),
        .duty_cycle (red),
        .pwm_out (red_out)
    );

    assign RGB_R = red_out;

    pwm u5 (
        .clk (clk),
        .duty_cycle (green),
        .pwm_out (green_out)
    );

    assign RGB_G = green_out;

    pwm u6 (
        .clk (clk),
        .duty_cycle (blue),
        .pwm_out (blue_out)
    );

    assign RGB_B = blue_out;




endmodule