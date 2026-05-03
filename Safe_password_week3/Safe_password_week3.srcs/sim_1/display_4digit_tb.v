`timescale 1ns / 1ps

module tb_display_4digit;

    reg         clk;
    reg         rst;
    reg  [15:0] i_data;
    reg  [3:0]  i_mask;

    wire [6:0]  o_seg;
    wire [7:0]  o_an;
    wire        o_dp;

    display_4digit dut (
        .i_clk  (clk),
        .i_rst  (rst),
        .i_data (i_data),
        .i_mask (i_mask),
        .o_seg  (o_seg),
        .o_an   (o_an),
        .o_dp   (o_dp)
    );

    // Clock 100 MHz
    always #5 clk = ~clk;

    task wait_cycles;
        input integer n;
        integer i;
        begin
            for (i = 0; i < n; i = i + 1)
                @(posedge clk);
        end
    endtask

    localparam REFRESH = 100_000;
    localparam SCAN    = 4 * REFRESH;

    task wait_scans;
        input integer n;
        begin
            wait_cycles(SCAN * n);
        end
    endtask

    // simulate one digit input

    task enter_digit;
        input [3:0] digit;
        begin
            // (digit0 → digit1 → digit2 → digit3)
            i_data = {i_data[11:0], digit};  // new digit in position 0
            // update the mask, by adding one more digit to show
            i_mask = {i_mask[2:0], 1'b1};

            $display("[%0t ns] Digit saisi: %0d  |  data=%04h  mask=%04b",
            $time, digit, i_data, i_mask);

            wait_scans(2);
        end
    endtask

    initial begin
        clk    = 0;
        rst    = 0;
        i_data = 16'h0000;
        i_mask = 4'b0000;

        // Reset

        $display("=== RESET ===");
        rst = 1;
        wait_cycles(10);
        rst = 0;
        wait_cycles(20);
        $display("[%0t ns] Results : o_an=%08b  mask=%04b", $time, o_an, i_mask);

        //------------------------------------------------------------------
        // Password input : 1 - 2 - 3 - 4
        //
        //    expected state after each digit input :
        //    digit1 : data=0001  mask=0001  -> only digit0 turn on
        //    digit2 : data=0012  mask=0011  -> digit0 & digit1 turns on
        //    digit3 : data=0123  mask=0111  -> digit0 digit1 digit2 turns on
        //    digit4 : data=1234  mask=1111  -> every digit turns one
        //------------------------------------------------------------------

        $display("=== Password input 1-2-3-4 ===");
        enter_digit(4'h1);
        enter_digit(4'h2);
        enter_digit(4'h3);
        enter_digit(4'h4);

        $display("Results : data=%04h  mask=%04b", i_data, i_mask);
        wait_scans(3);

        // Reset

        $display("=== RESET (relock or error flag) ===");
        rst = 1;
        wait_cycles(10);
        rst = 0;
        i_data = 16'h0000;
        i_mask = 4'b0000;
        wait_cycles(20);
        $display("[%0t ns] Results : o_an=%08b  mask=%04b", $time, o_an, i_mask);

  
        // New password input : 5 - A - 3 - F
       
        $display("=== Saisie du mot de passe 5-A-3-F ===");
        enter_digit(4'h5);
        enter_digit(4'hA);
        enter_digit(4'h3);
        enter_digit(4'hF);

        $display("Etat final : data=%04h  mask=%04b", i_data, i_mask);
        wait_scans(3);

        wait_cycles(100);
        $display("=== END ===");
        $finish;
    end

    // monitor anodes changes

    always @(o_an) begin
        $display("[%0t ns] ANODE o_an=%08b  o_seg=%07b",
                 $time, o_an, o_seg);
    end

    // vcd dump

    initial begin
        $dumpfile("display_4digit_tb.vcd");
        $dumpvars(0, tb_display_4digit);
    end

endmodule
