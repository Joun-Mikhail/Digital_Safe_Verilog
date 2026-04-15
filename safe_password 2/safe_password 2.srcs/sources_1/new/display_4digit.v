module display_4digit (
    input  wire        i_clk,
    input  wire        i_rst,
    input  wire [15:0] i_data,
    input  wire [3:0]  i_mask,
    output wire [6:0]  o_seg,
    output reg  [7:0]  o_an,
    output wire        o_dp
);

    wire       w_ce;
    wire [1:0] w_sel;
    reg  [3:0] r_bin;
    reg        r_show;
    wire [6:0] w_seg_hex;

    assign o_seg = r_show ? w_seg_hex : 7'b1111111;
    assign o_dp  = 1'b1;

    clk_en #(
        .MAX(100_000)
    ) refresh_inst (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_ce(w_ce)
    );

    counter #(
        .N(2)
    ) sel_inst (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_en(w_ce),
        .o_cnt(w_sel)
    );

    bin2seg decoder_inst (
        .i_bin(r_bin),
        .o_seg(w_seg_hex)
    );

    always @(*) begin
        o_an   = 8'b11111111;
        r_bin  = 4'h0;
        r_show = 1'b0;

        case (w_sel)
            2'd0: begin
                o_an[0] = 1'b0;
                r_bin   = i_data[3:0];
                r_show  = i_mask[0];
            end

            2'd1: begin
                o_an[1] = 1'b0;
                r_bin   = i_data[7:4];
                r_show  = i_mask[1];
            end

            2'd2: begin
                o_an[2] = 1'b0;
                r_bin   = i_data[11:8];
                r_show  = i_mask[2];
            end

            2'd3: begin
                o_an[3] = 1'b0;
                r_bin   = i_data[15:12];
                r_show  = i_mask[3];
            end
        endcase
    end

endmodule