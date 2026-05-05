module bin2seg (

    input  wire [4:0] i_code,

    output reg  [6:0] o_seg

);



    localparam [4:0]

        C_0     = 5'd0,

        C_1     = 5'd1,

        C_2     = 5'd2,

        C_3     = 5'd3,

        C_4     = 5'd4,

        C_5     = 5'd5,

        C_6     = 5'd6,

        C_7     = 5'd7,

        C_8     = 5'd8,

        C_9     = 5'd9,

        C_A     = 5'd10,

        C_b     = 5'd11,

        C_C     = 5'd12,

        C_d     = 5'd13,

        C_E     = 5'd14,

        C_F     = 5'd15,

        C_BLANK = 5'd16,

        C_P     = 5'd17,

        C_r     = 5'd18,

        C_L     = 5'd19,

        C_n     = 5'd20,

        C_H     = 5'd21,

        C_O     = 5'd22;



    always @* begin

        case (i_code)

            C_0, C_O: o_seg = 7'b0000001;

            C_1:      o_seg = 7'b1001111;

            C_2:      o_seg = 7'b0010010;

            C_3:      o_seg = 7'b0000110;

            C_4:      o_seg = 7'b1001100;

            C_5:      o_seg = 7'b0100100;

            C_6:      o_seg = 7'b0100000;

            C_7:      o_seg = 7'b0001111;

            C_8:      o_seg = 7'b0000000;

            C_9:      o_seg = 7'b0000100;

            C_A:      o_seg = 7'b0001000;

            C_b:      o_seg = 7'b1100000;

            C_C:      o_seg = 7'b0110001;

            C_d:      o_seg = 7'b1000010;

            C_E:      o_seg = 7'b0110000;

            C_F:      o_seg = 7'b0111000;

            C_BLANK:  o_seg = 7'b1111111;

            C_P:      o_seg = 7'b0011000;

            C_r:      o_seg = 7'b1111010;

            C_L:      o_seg = 7'b1110001;

            C_n:      o_seg = 7'b1101010;

            C_H:      o_seg = 7'b1001000; // used as fake K

            default:  o_seg = 7'b1111111;

        endcase

    end



endmodule