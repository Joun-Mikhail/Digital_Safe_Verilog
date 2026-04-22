module safe_core_tb;

    reg clk;
    reg rst;
    reg enter_pulse;
    reg relock_pulse;
    reg [3:0] digit_in;

    wire [15:0] display_data;
    wire [3:0]  display_mask;
    wire        unlocked;
    wire        error_flag;

    safe_core uut (
        .clk(clk),
        .rst(rst),
        .enter_pulse(enter_pulse),
        .relock_pulse(relock_pulse),
        .digit_in(digit_in),
        .display_data(display_data),
        .display_mask(display_mask),
        .unlocked(unlocked),
        .error_flag(error_flag)
    );

    always #5 clk = ~clk;

    task enter_digit;
        input [3:0] value;
        begin
            digit_in = value;
            #20;
            enter_pulse = 1'b1;
            #10;
            enter_pulse = 1'b0;
            #30;
        end
    endtask

    initial begin
        clk = 1'b0;
        rst = 1'b1;
        enter_pulse = 1'b0;
        relock_pulse = 1'b0;
        digit_in = 4'h0;

        #40;
        rst = 1'b0;

        // Correct code: 1 2 3 4
        enter_digit(4'h1);
        enter_digit(4'h2);
        enter_digit(4'h3);
        enter_digit(4'h4);

        #80;

        // Reset
        rst = 1'b1;
        #20;
        rst = 1'b0;

        // Wrong code: 1 2 3 5
        enter_digit(4'h1);
        enter_digit(4'h2);
        enter_digit(4'h3);
        enter_digit(4'h5);

        #100;
        $finish;
    end

endmodule