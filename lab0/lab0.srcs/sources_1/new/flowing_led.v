`timescale 1ns / 1ps

module flowing_led(
    input clk_gy,
    input rst_gy,
    output [15:0] led_gy
    );

    reg [23:0] cnt_reg_gy;
    reg [15:0] light_reg_gy;

    always @ (posedge clk_gy) begin
        if (rst_gy) cnt_reg_gy <= 0;
        else cnt_reg_gy <= cnt_reg_gy + 1;
    end

    always @ (posedge clk_gy) begin
        if (rst_gy) light_reg_gy <= 16'h0001;
        else if (cnt_reg_gy == 24'hffffff) begin
            if (light_reg_gy == 16'h8000)
                light_reg_gy <= 16'h0001;
            else
                light_reg_gy <= light_reg_gy << 1;
        end
    end

    assign led_gy = light_reg_gy;
endmodule
