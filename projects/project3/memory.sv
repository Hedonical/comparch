// Sample memory module

module memory #(
    parameter INIT_FILE = "",
    parameter logic [6:0] mem_size = 127, // one less than actual value, so 127 is actually 128
    parameter logic [9:0] max_value = 1023 // record the max value that the sine wave can be
)(
    input logic     clk,
    input logic     [6:0] read_address,
    output logic    [9:0] read_data
);

    // Declare memory array for storing 512 10-bit samples of a sine function
    logic [9:0] sample_memory [0:mem_size];

    // declare a variable to store the stage count
    int stage = 1;

    // decare a variable to store our count
    int count = 0;

    // declare a variable to store the sine wave value
    int value = 0;

    initial if (INIT_FILE) begin
        $readmemh(INIT_FILE, sample_memory);
    end

    always_ff @(posedge clk) begin
        count <= count + 1;

        // once we have completed 127 steps, move on to the next stage
        if (count > 126) begin
            // reset the count
            count <= 0;

            // if we still have stages left, continue
            if (stage < 4) begin
                stage <= stage + 1;
            end
            // other reset the stage count to 0
            else begin
                stage <= 1;
            end

        end
        // assign the fraction of the sine wave that corresponds to its section
        case (stage)
            1  : read_data <= sample_memory[read_address];
            2  : read_data <= sample_memory[mem_size - read_address];
            3  : read_data <= max_value - sample_memory[read_address];
            4  : read_data <= max_value - sample_memory[mem_size - read_address];

        endcase
        
        
        value <= int'(read_data);
    end

endmodule