module safe_core #(
    parameter [3:0] CODE0 = 4'h1,
    parameter [3:0] CODE1 = 4'h2,
    parameter [3:0] CODE2 = 4'h3,
    parameter [3:0] CODE3 = 4'h4
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       enter_pulse,
    input  wire       relock_pulse,
    input  wire [3:0] digit_in,
    output reg  [15:0] display_data,
    output reg  [3:0]  display_mask,
    output reg        unlocked,
    output reg        error_flag
);

    reg [3:0] d0, d1, d2, d3;
    reg [1:0] pos;

    always @(posedge clk) begin
        if (rst || relock_pulse) begin
            d0 <= 4'h0;
            d1 <= 4'h0;
            d2 <= 4'h0;
            d3 <= 4'h0;
            pos <= 2'd0;
            unlocked <= 1'b0;
            error_flag <= 1'b0;
        end
        else if (enter_pulse && !unlocked) begin
            if (error_flag) begin
                d0 <= digit_in;
                d1 <= 4'h0;
                d2 <= 4'h0;
                d3 <= 4'h0;
                pos <= 2'd1;
                error_flag <= 1'b0;
            end
            else begin
                case (pos)
                    2'd0: begin
                        d0 <= digit_in;
                        pos <= 2'd1;
                    end

                    2'd1: begin
                        d1 <= digit_in;
                        pos <= 2'd2;
                    end

                    2'd2: begin
                        d2 <= digit_in;
                        pos <= 2'd3;
                    end

                    2'd3: begin
                        d3 <= digit_in;

                        if ({digit_in, d2, d1, d0} == {CODE3, CODE2, CODE1, CODE0}) begin
                            unlocked <= 1'b1;
                            error_flag <= 1'b0;
                        end
                        else begin
                            unlocked <= 1'b0;
                            error_flag <= 1'b1;
                        end
                    end
                endcase
            end
        end
    end

    always @(*) begin
        display_data = {d3, d2, d1, d0};
        display_mask = 4'b0000;

        if (unlocked || error_flag) begin
            display_mask = 4'b1111;
        end
        else begin
            case (pos)
                2'd0: begin
                    display_data[3:0] = digit_in;
                    display_mask = 4'b0001;
                end
                2'd1: begin
                    display_data[7:4] = digit_in;
                    display_mask = 4'b0011;
                end
                2'd2: begin
                    display_data[11:8] = digit_in;
                    display_mask = 4'b0111;
                end
                2'd3: begin
                    display_data[15:12] = digit_in;
                    display_mask = 4'b1111;
                end
            endcase
        end
    end

endmodule