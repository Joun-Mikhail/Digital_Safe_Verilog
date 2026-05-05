module password_match (
    input  wire [4:0] entered_password,
    input  wire [4:0] correct_password,
    input  wire       check_en,
    output wire       match
);

    assign match = (entered_password == correct_password);

endmodule