module gy163(
    input en,
    input [3:0] in,
    input load,
    input clk,
    input clr,
    output rco,
    output [0:3] q
    );

    reg [3:0] cnt;

    always @(posedge clk) begin
        if (clr) cnt <= 0;
        else if (load) cnt <= in;
        else if (en) cnt <= cnt + 1;
    end

    assign rco = (cnt == 4'b1111);
    assign q = cnt;

endmodule