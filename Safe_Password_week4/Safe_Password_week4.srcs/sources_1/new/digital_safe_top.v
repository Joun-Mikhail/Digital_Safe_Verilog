module digital_safe_top (

    input  wire       clk,

    input  wire       btnu,

    input  wire       btnd,

    input  wire       btnc,

    input  wire [3:0] sw,

    output wire [6:0] seg,

    output wire [7:0] an,

    output wire       dp,

    output wire [7:0] led,

    output wire       rgb_r,

    output wire       rgb_g,

    output wire       rgb_b,
    
    output wire     RelayPin

);



    wire enter_state_unused;

    wire enter_pulse;

    wire relock_state_unused;

    wire relock_pulse;



    wire [39:0] display_data;

    wire [7:0]  display_mask;

    wire        unlocked;

    wire        error_flag;



    debounce enter_db (

        .clk      (clk),

        .rst      (btnu),

        .btn_in   (btnd),

        .btn_state(enter_state_unused),

        .btn_press(enter_pulse)

    );



    debounce relock_db (

        .clk      (clk),

        .rst      (btnu),

        .btn_in   (btnc),

        .btn_state(relock_state_unused),

        .btn_press(relock_pulse)

    );



    safe_core safe_inst (

        .clk         (clk),

        .rst         (btnu),

        .enter_pulse (enter_pulse),

        .relock_pulse(relock_pulse),

        .digit_in    (sw),

        .display_data(display_data),

        .display_mask(display_mask),

        .unlocked    (unlocked),

        .error_flag  (error_flag)

    );



    display_8digit disp_inst (

        .i_clk (clk),

        .i_rst (btnu),

        .i_data(display_data),

        .i_mask(display_mask),

        .o_seg (seg),

        .o_an  (an),

        .o_dp  (dp)

    );



    assign led[7]   = unlocked;

    assign led[6]   = error_flag;

    assign led[5:0] = 6'b000000;



    assign rgb_g = unlocked;

    assign rgb_r = error_flag;

    assign rgb_b = 1'b0;

    assign RelayPin = !unlocked;


endmodule