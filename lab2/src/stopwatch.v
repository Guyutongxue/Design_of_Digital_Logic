`timescale 1ns / 1ps

module stopwatch_gy(
    input clk_10Hz, //10Hz,
    input clr,
    input en,
    output [3:0] min1,
    output [3:0] sec10,
    output [3:0] sec1,
    output [3:0] ms100
    );

    wire min1_clr, sec10_clr, sec1_clr, ms100_clr;
    wire min10_en, min1_en, sec10_en, sec1_en;

    // step higher bit when lower bit overflow
    assign sec1_en = (ms100 == 9) & en;
    assign sec10_en = (sec1 == 9) & sec1_en;
    assign min1_en = (sec10 == 5) & sec10_en;
    assign min10_en = (min1 == 9) & min1_en;

    // clear lower bit when higher bit enabled
    assign ms100_clr = sec1_en | clr;
    assign sec1_clr = sec10_en | clr;
    assign sec10_clr = min1_en | clr;
    assign min1_clr = min10_en | clr;

    gy163 cnt_min1(
        .en(min1_en),
        .in(),
        .load(),
        .clk(clk_10Hz),
        .clr(min1_clr),
        .rco(),
        .q(min1)
        );
    
    gy163 cnt_sec10(
        .en(sec10_en),
        .in(),
        .load(),
        .clk(clk_10Hz),
        .clr(sec10_clr),
        .rco(),
        .q(sec10)
        );

    gy163 cnt_sec1(
        .en(sec1_en),
        .in(),
        .load(),
        .clk(clk_10Hz),
        .clr(sec1_clr),
        .rco(),
        .q(sec1)
        );

    gy163 cnt_ms100(
        .en(en),
        .in(),
        .load(),
        .clk(clk_10Hz),
        .clr(ms100_clr),
        .rco(),
        .q(ms100)
        );
    
endmodule
