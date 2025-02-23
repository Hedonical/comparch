`include "pwm.sv"
`include "ramp.sv"


module top(
    input logic clk,
    output logic    RGB_G,
    output logic    RGB_R,
    output logic    RGB_B
);
    logic pwm_out;
    integer pwm_value;

    // red led
    rampR u1 (
        .clk (clk),
        .pwm_value (pwm_value)
    );


    pwm u2 (
        .clk (clk),
        .pwm_value (pwm_value),
        .pwm_out (pwm_out)
    );

    assign RGB_R = ~pwm_out;




endmodule