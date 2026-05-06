`timescale 1ns / 1ps


module digital_safe_top #(
    // Set to 0 if your relay module is active-high.
    // Set to 1 if your relay module is active-low.
    parameter RELAY_ACTIVE_LOW = 1'b0
)(
    input  wire       clk,
    input  wire       btnu,      // reset button
    input  wire       btnd,      // enter button
    input  wire       btnc,      // relock button
    input  wire [3:0] sw,        // digit input switches

    output wire [6:0] seg,
    output wire [7:0] an,
    output wire       dp,

    output wire [7:0] led,
    output wire       rgb_r,
    output wire       rgb_g,
    output wire       rgb_b,
    output wire       RelayPin
);

    wire enter_state;
    wire enter_pulse;
    wire relock_state;
    wire relock_pulse;

    wire [39:0] display_data;
    wire [7:0]  display_mask;

    wire unlocked;
    wire error_flag;

   
    debounce enter_db (
        .clk       (clk),
        .rst       (btnu),
        .btn_in    (btnd),
        .btn_state (enter_state),
        .btn_press (enter_pulse)
    );

    
    debounce relock_db (
        .clk       (clk),
        .rst       (btnu),
        .btn_in    (btnc),
        .btn_state (relock_state),
        .btn_press (relock_pulse)
    );

  
    safe_core safe_inst (
        .clk          (clk),
        .rst          (btnu),
        .enter_pulse  (enter_pulse),
        .relock_pulse (relock_pulse),
        .digit_in     (sw),
        .display_data (display_data),
        .display_mask (display_mask),
        .unlocked     (unlocked),
        .error_flag   (error_flag)
    );

    
    display_8digit disp_inst (
        .i_clk  (clk),
        .i_rst  (btnu),
        .i_data (display_data),
        .i_mask (display_mask),
        .o_seg  (seg),
        .o_an   (an),
        .o_dp   (dp)
    );
  
    assign led[3:0] = sw;
    assign led[4]   = relock_state;
    assign led[5]   = enter_state;
    assign led[6]   = error_flag;
    assign led[7]   = unlocked;

    // RGB indication
    assign rgb_g = unlocked;              // green = open
    assign rgb_r = error_flag;            // red = wrong PIN
    assign rgb_b = ~unlocked & ~error_flag; // blue = locked/ready

    assign RelayPin = (RELAY_ACTIVE_LOW) ? ~unlocked : unlocked;

endmodule
