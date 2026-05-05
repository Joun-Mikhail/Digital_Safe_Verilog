module safe_core #(

    parameter [3:0] CODE0 = 4'h1,

    parameter [3:0] CODE1 = 4'h2,

    parameter [3:0] CODE2 = 4'h3,

    parameter [3:0] CODE3 = 4'h4

)(

    input  wire        clk,

    input  wire        rst,

    input  wire        enter_pulse,

    input  wire        relock_pulse,

    input  wire [3:0]  digit_in,

    output reg  [39:0] display_data,

    output reg  [7:0]  display_mask,

    output reg         unlocked,

    output reg         error_flag

);



    reg [3:0] d0, d1, d2, d3;

    reg [1:0] pos;



    reg [19:0] left_status;

    reg [19:0] right_digits;

    reg [3:0]  right_mask;



    localparam [4:0]

        SYM_0     = 5'd0,

        SYM_1     = 5'd1,

        SYM_2     = 5'd2,

        SYM_3     = 5'd3,

        SYM_4     = 5'd4,

        SYM_5     = 5'd5,

        SYM_6     = 5'd6,

        SYM_7     = 5'd7,

        SYM_8     = 5'd8,

        SYM_9     = 5'd9,

        SYM_A     = 5'd10,

        SYM_b     = 5'd11,

        SYM_C     = 5'd12,

        SYM_d     = 5'd13,

        SYM_E     = 5'd14,

        SYM_F     = 5'd15,

        SYM_BLANK = 5'd16,

        SYM_P     = 5'd17,

        SYM_r     = 5'd18,

        SYM_L     = 5'd19,

        SYM_n     = 5'd20,

        SYM_H     = 5'd21,

        SYM_O     = 5'd22;



    always @(posedge clk) begin

        if (rst || relock_pulse) begin

            d0         <= 4'h0;

            d1         <= 4'h0;

            d2         <= 4'h0;

            d3         <= 4'h0;

            pos        <= 2'd0;

            unlocked   <= 1'b0;

            error_flag <= 1'b0;

        end

        else if (enter_pulse && !unlocked) begin

            if (error_flag) begin

                d0         <= digit_in;

                d1         <= 4'h0;

                d2         <= 4'h0;

                d3         <= 4'h0;

                pos        <= 2'd1;

                error_flag <= 1'b0;

            end

            else begin

                case (pos)

                    2'd0: begin

                        d0  <= digit_in;

                        pos <= 2'd1;

                    end



                    2'd1: begin

                        d1  <= digit_in;

                        pos <= 2'd2;

                    end



                    2'd2: begin

                        d2  <= digit_in;

                        pos <= 2'd3;

                    end



                    2'd3: begin

                        d3 <= digit_in;



                        if ({digit_in, d2, d1, d0} == {CODE3, CODE2, CODE1, CODE0}) begin

                            unlocked   <= 1'b1;

                            error_flag <= 1'b0;

                        end

                        else begin

                            unlocked   <= 1'b0;

                            error_flag <= 1'b1;

                        end

                    end

                endcase

            end

        end

    end



    always @(*) begin

        // Left 4 digits = status

        if (unlocked) begin

            left_status = {SYM_O, SYM_P, SYM_E, SYM_n}; // OPEN

        end

        else begin

            left_status = {SYM_L, SYM_O, SYM_C, SYM_H}; // LOCK, H used as fake K

        end



        // Right 4 digits = password entry like before

        right_digits = {SYM_BLANK, SYM_BLANK, SYM_BLANK, SYM_BLANK};

        right_mask   = 4'b0000;



        if (unlocked || error_flag) begin

            right_digits = {

                {1'b0, d3},

                {1'b0, d2},

                {1'b0, d1},

                {1'b0, d0}

            };

            right_mask = 4'b1111;

        end

        else begin

            case (pos)

                2'd0: begin

                    right_digits[4:0] = {1'b0, digit_in};

                    right_mask        = 4'b0001;

                end



                2'd1: begin

                    right_digits[4:0] = {1'b0, d0};

                    right_digits[9:5] = {1'b0, digit_in};

                    right_mask        = 4'b0011;

                end



                2'd2: begin

                    right_digits[4:0]   = {1'b0, d0};

                    right_digits[9:5]   = {1'b0, d1};

                    right_digits[14:10] = {1'b0, digit_in};

                    right_mask          = 4'b0111;

                end



                2'd3: begin

                    right_digits[4:0]   = {1'b0, d0};

                    right_digits[9:5]   = {1'b0, d1};

                    right_digits[14:10] = {1'b0, d2};

                    right_digits[19:15] = {1'b0, digit_in};

                    right_mask          = 4'b1111;

                end

            endcase

        end



      

        display_data = {left_status, right_digits};

        display_mask = {4'b1111, right_mask};

    end



endmodule