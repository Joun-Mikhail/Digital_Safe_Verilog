`timescale 1ns / 1ps

module tb_digital_safe_top;

    reg        clk;
    reg        btnu;   // reset
    reg        btnd;   // enter button
    reg        btnc;   // relock button
    reg  [3:0] sw;

    wire [6:0] seg;
    wire [7:0] an;
    wire       dp;
    wire [7:0] led;

    digital_safe_top dut (
        .clk  (clk),
        .btnu (btnu),
        .btnd (btnd),
        .btnc (btnc),
        .sw   (sw),
        .seg  (seg),
        .an   (an),
        .dp   (dp),
        .led  (led)
    );

    // Clock: 100 MHz, period = 10 ns

    always #5 clk = ~clk;


    task wait_cycles;
        input integer n;
        integer i;
        begin
            for (i = 0; i < n; i = i + 1)
                @(posedge clk);
        end
    endtask

    task press_enter; // press enter to validate current input value
        begin
            btnd = 1;
            wait_cycles(50);
            btnd = 0;
            wait_cycles(20);
        end
    endtask

    task press_relock; // relock the system after unlock or error
        begin
            btnc = 1;
            wait_cycles(50);
            btnc = 0;
            wait_cycles(20);
        end
    endtask

    task enter_digit; // input digit value with the switch
        input [3:0] digit;
        begin
            sw = digit;
            wait_cycles(5);
            press_enter;
            $display("[%0t ns] Digit entered: %0d  |  led=%08b  unlocked=%b  error=%b",
                     $time, digit, led, led[0], led[1]);
        end
    endtask


    initial begin

        // init

        clk  = 0;
        btnu = 0;
        btnd = 0;
        btnc = 0;
        sw   = 4'h0;

        // Reset

        $display("=== RESET ===");
        btnu = 1;
        wait_cycles(10);
        btnu = 0;
        wait_cycles(20);

        // Wrong password (0-0-0-0)

        $display("=== Wrong password (0-0-0-0) ===");
        enter_digit(4'h0);
        enter_digit(4'h0);
        enter_digit(4'h0);
        enter_digit(4'h0);
        wait_cycles(20);
        $display("Results -> unlocked=%b  error=%b", led[0], led[1]);

        $display("=== RESET ===");
        btnu = 1;
        wait_cycles(10);
        btnu = 0;
        wait_cycles(20);

        $display("=== correct password (1-2-3-4) ===");
        enter_digit(4'h1);
        enter_digit(4'h2);
        enter_digit(4'h3);
        enter_digit(4'h4);
        wait_cycles(20);
        $display("Results -> unlocked=%b  error=%b", led[0], led[1]);

        // Relock

        $display("=== RELOCK ===");
        press_relock;
        wait_cycles(20);
        $display("Results -> unlocked=%b  error=%b", led[0], led[1]);

        // end sim

        wait_cycles(50);

        $display("=== END ===");
        $finish;
    end

    // Dump for GTKWave
    
    initial begin
        $dumpfile("digital_safe_top_tb.vcd");
        $dumpvars(0, tb_digital_safe_top);
    end

endmodule