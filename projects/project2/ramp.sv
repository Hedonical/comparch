// module for ramping the pwm rate of an led

// define module for ramping the red led
module ramp #(
    parameter step = 2000000, // over what range to change the pwm value
    parameter [0:6] steps = 7'b0011100, // what pwm values to shift between, 0 = 0%, 1 = 100%
    parameter int n_steps = $bits(steps)
)(
    input logic clk,
    output int pwm_value
);
    integer next;
    integer current;
    integer check;

    integer stage = 0; // define a variable to keep track of what stage we are in
    integer count = 0; // define a variable to keep count before the next stage
    integer pwm_count = 0; // counter to keep track of when to move the pwm_value

    // intiate the integer array of steps to go through
    integer rate[n_steps];

    


    

    // determine how often to increment the pwm value
    integer substep = step / 100;

    // establish the rates
    initial begin


        // initialize the initial pwm value
        if (steps[0]) pwm_value = 100;
        else pwm_value = 0;




        // loop through each bit to determine whether we are headed low or high
        for (int i = 0; i < n_steps; i++) begin
            if (i < n_steps - 1) begin
                if (steps[i + 1]) next = 100;
                else next = 0;


                if (steps[i]) current = 100;
                else current = 0;


                // find % to increase or decrease pwm per step
                rate[i] = (next - current) / 100;


            end 
            else begin
                // for the last rate do it based on it looping back on itself
                if (steps[0]) next = 100;
                else next = 0;

                if (steps[i]) current = 100;
                else current = 0;

                // find the number of steps to increase or decrease the pwm
                rate[n_steps - 1] = (next - current) / 100;


            end

        
        end
    end

    always_ff @(posedge clk) begin
        pwm_count <= pwm_count + 1;

        if (pwm_count == substep - 1) begin
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
                // once we complete the loop, reset the pwm_value
                stage <= 0;
                if (steps[0]) pwm_value <= 100;
                else pwm_value <= 0;
            end
        end

    end



endmodule