// module to PWM a specific color
module pwm #(
    parameter step = 10000
)(
    input logic clk, 
    input integer duty_cycle, // 0 to 100
    output logic pwm_out
);

    integer pwm_on = 0;

    // Declare PWM generator counter variable
    int pwm_count = 0;

    logic switch = 0;

    // Implement counter for timing transition in PWM output signal
    always_ff @(posedge clk) begin
        // determine how long for the led to stay on for a step
        pwm_on <= (step*duty_cycle)/100;

        // handle the 0 or 100 duty cycle (led fully on or off)
        if (duty_cycle >= 99 || duty_cycle <= 1) begin
            // keep the led on
            if (duty_cycle >= 99) begin
                switch <= 0;
            end
            if (duty_cycle <= 1) begin
                switch <= 1;
            end

        

        end
        else begin
            if (pwm_count > pwm_on - 1) begin
                // switch the led to off once its duty cycle has expired
                switch <= 1;

                if (pwm_count > step - 1) begin
                    // reset the pwm count once the step has expired
                    pwm_count <= 0;

                    //switch the led back on
                    switch <= 0;
                end
                else begin
                    pwm_count <= pwm_count + 1;
                end
                
            end
            else begin
                pwm_count <= pwm_count + 1;
            end

        end
    end

    // Generate PWM output signal
    assign pwm_out = (switch) ? 1'b1 : 1'b0;

endmodule