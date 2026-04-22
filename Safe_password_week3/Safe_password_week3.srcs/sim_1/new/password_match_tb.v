`timescale 1ns/1ps

module password_match_tb;

    reg  [4:0] entered_password;
    reg  [4:0] correct_password;
    wire match;

    password_match uut (
        .entered_password(entered_password),
        .correct_password(correct_password),
        .match(match)
    );

    initial begin
        correct_password = 5'b10110;

        entered_password = 5'b10110;  // correct
        #10;

        entered_password = 5'b11110;  // wrong
        #10;

        entered_password = 5'b00000;  // wrong
        #10;

        entered_password = 5'b10110;  // correct again
        #10;

        $finish;
    end

endmodule