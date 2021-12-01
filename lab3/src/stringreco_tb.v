`timescale 1ns / 1ps

module stringreco_tb();
    reg clk, clr, en_reg;
    wire [15:0] count;
    //stopwatch
    wire [3:0] thousands, hundreds, tens, ones;
    reg [15:0] sw;
    
    initial begin

        // delete when vivado simulation
        $dumpfile("stringreco.vcd");
        $dumpvars(0, u_stringreco);
        $dumpvars(1, u_binary2BCD);
        $monitor("Result: %d%d%d%d ", thousands, hundreds, tens, ones);
        // delete when vivado simulation

        sw = 16'b1011_0010_1101_1011;
        clr = 0;
        en_reg = 0;
        #100 clr = 1; 
        #100 clr = 0;
        #100 en_reg = 1;
        #20 en_reg = 0;
        #1000 en_reg = 1;
        #20 en_reg = 0;

        // delete when vivado simulation
        #1000000;
        $finish;
        // delete when vivado simulation

    end
   
    always begin
        clk = 0;
        #10 clk = 1;
        #10;
    end
    
    stringreco u_stringreco(
        .clk(clk), // 10Hz,
        .clr(clr),
        .en(en_reg),
        .sw(sw),
        .count(count)
        );
    
    // bin2BCD
    binary2BCD u_binary2BCD(
        .binary(count[13:0]),
        .thousands(thousands),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones)
        ); 
endmodule
