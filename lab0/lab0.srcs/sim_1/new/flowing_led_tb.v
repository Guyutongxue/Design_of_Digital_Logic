`timescale 1ns / 1ps

module flowing_led_tb();
    reg clk_gy;
    reg rst_gy;
    wire [3:0] led_gy;

    flowing_led u0(
        .clk_gy(clk_gy),
        .rst_gy(rst_gy),
        .led_gy(led_gy));

    parameter PERIOD_gy = 10;

    always begin
        clk_gy = 1'b0;
        #(PERIOD_gy/2) clk_gy = 1'b1;
        #(PERIOD_gy/2);
    end

    initial begin
        clk_gy = 1'b0;
        rst_gy = 1'b0;
        #100;
        rst_gy = 1'b1;
        #100;
        rst_gy = 1'b0;
    end
endmodule
