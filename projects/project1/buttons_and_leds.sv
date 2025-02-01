// Buttons and LEDs

module top(
    input logic     BOOT, 
    input logic     SW, 
    input logic     clk,
    output logic    RGB_G,
    output logic    RGB_R,
    output logic    RGB_B,
);

    // define a function to turn the LEDs off and on
    function void RGB;
        input logic R, G, B;
        // the RGB leds are active low, meaning a value of 0 means on, but I inverse this
        begin
            RGB_R <= ~R; 
            RGB_G <= ~G;
            RGB_B <= ~B;
        end
    endfunction

    // set the initial state of the LEDs
    initial begin
        RGB (1, 0, 0); // start with RED on
    end

    // define the initial variables to use
    integer BLINK_INTERVAL = 12000000; // CLK frequency is 12MHz, so 12,000,000 cycles is 1 second
    integer count = 0; // define the count up to the cycle number
    integer flip = 0; // define a number to keep track of which LED we are on


    // trigger this block whenever the clock reaches the positive edge
    always_ff @(posedge clk) begin
        // if the count reaches the blink interval execute this code
        if (count == BLINK_INTERVAL - 1) begin
            count <= 0; // reset the counter

            flip <= flip + 1; // move on to the next color

            if (flip == 0) 
                RGB (1, 0, 0); // RED
            else if (flip == 1)
                RGB (1, 1, 0); // YELLOW
            else if (flip == 2)
                RGB (0, 1, 0); // GREEN
            else if (flip == 3)
                RGB (0, 1, 1); // CYAN
            else if (flip == 4)
                RGB (0, 0, 1); // BLUE
            else if (flip == 5)
                RGB (1, 0, 1); // PURPLE
            
            if (flip > 4) // Once we have cycled through the 6 colors, restart the process
                flip <= 0;

        end
        // otherwise, continue adding the counter
        else begin

            count <= count + 1;

        end
    end




endmodule
