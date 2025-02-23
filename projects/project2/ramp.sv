// module for ramping the pwm rate of an led

// define module for ramping the red led
module rampR #(
    parameter step = 2000000
)(
    input logic clk,
    output int pwm_value
);

    integer stage = 0; // define a variable to keep track of what stage we are in
    integer count = 0; // define a variable to keep count before the next stage
    real pwm_real = 100; // approximately how many steps to wait before changing the pwm
    integer pwm_int = int'(pwm_real);
    integer pwm_count = 0; // counter to keep track of when to move the pwm_value
    real fstep = real'(step);

    // intiate the integer array of steps to go through
    real steps[7] = '{100, 100, 100000, 100000, 100000, 100, 100};
    integer n_steps = $size(steps);
    integer rate[6];


    

    

    // establish the rates
    initial begin
        // initialize the initial pwm value
        pwm_value = steps[0];
        foreach (steps[i]) begin
            if (i < n_steps) begin
                // find the number of steps to increase or decrease the pwm by 1
                rate[i] = int'(((steps[i + 1] - steps[i]) / fstep) * pwm_real);
            end
        
        end
    end

    always_ff @(posedge clk) begin
        pwm_count <= pwm_count + 1;

        if (pwm_count == pwm_int) begin
            pwm_value <= pwm_value + rate[stage];
            pwm_count <= 0;
        end

        count <= count + 1; // iterate the count

        if (count == step) begin
            count <= 0; // reset the count

            // switch to the next stage
            if (stage < n_steps - 1) begin
                stage <= stage + 1;
            end 
            else begin
                stage <= 0;
            end
        end

    end



endmodule