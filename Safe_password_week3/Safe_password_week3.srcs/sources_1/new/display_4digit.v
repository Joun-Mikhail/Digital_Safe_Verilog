module display_4digit (

    input  wire        i_clk,

    input  wire        i_rst,

    input  wire [39:0] i_data,

    input  wire [7:0]  i_mask,

    output wire [6:0]  o_seg,

    output reg  [7:0]  o_an,

    output wire        o_dp

);



    wire       w_ce;

    wire [2:0] w_sel;

    reg  [4:0] r_code;

    reg        r_show;

    wire [6:0] w_seg_code;



    assign o_seg = r_show ? w_seg_code : 7'b1111111;

    assign o_dp  = 1'b1;



    clk_en #(

        .MAX(100_000)

    ) refresh_inst (

        .i_clk(i_clk),

        .i_rst(i_rst),

        .o_ce (w_ce)

    );



    counter #(

        .N(3)

    ) sel_inst (

        .i_clk(i_clk),

        .i_rst(i_rst),

        .i_en (w_ce),

        .o_cnt(w_sel)

    );



    bin2seg decoder_inst (

        .i_code(r_code),

        .o_seg (w_seg_code)

    );



    always @(*) begin

        o_an   = 8'b11111111;

        r_code = 5'd16; // blank

        r_show = 1'b0;



        case (w_sel)

            3'd0: begin

                o_an[0] = 1'b0;

                r_code  = i_data[4:0];

                r_show  = i_mask[0];

            end



            3'd1: begin

                o_an[1] = 1'b0;

                r_code  = i_data[9:5];

                r_show  = i_mask[1];

            end



            3'd2: begin

                o_an[2] = 1'b0;

                r_code  = i_data[14:10];

                r_show  = i_mask[2];

            end



            3'd3: begin

                o_an[3] = 1'b0;

                r_code  = i_data[19:15];

                r_show  = i_mask[3];

            end



            3'd4: begin

                o_an[4] = 1'b0;

                r_code  = i_data[24:20];

                r_show  = i_mask[4];

            end



            3'd5: begin

                o_an[5] = 1'b0;

                r_code  = i_data[29:25];

                r_show  = i_mask[5];

            end



            3'd6: begin

                o_an[6] = 1'b0;

                r_code  = i_data[34:30];

                r_show  = i_mask[6];

            end



            3'd7: begin

                o_an[7] = 1'b0;

                r_code  = i_data[39:35];

                r_show  = i_mask[7];

            end

        endcase

    end



endmodule