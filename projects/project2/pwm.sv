// module to PWM a specific color
module pwm (
    input logic clk, 
    input int pwm_value, 
    output logic pwm_out
);

    // Declare PWM generator counter variable
    int pwm_count = 0;

    logic switch = 0;

    // Implement counter for timing transition in PWM output signal
    always_ff @(posedge clk) begin
        if (pwm_count == pwm_value) begin
            pwm_count <= 0;
            switch <= ~switch;
        end
        else begin
            pwm_count <= pwm_count + 1;
        end
    end

    // Generate PWM output signal
    assign pwm_out = (switch) ? 1'b0 : 1'b1;

endmodule