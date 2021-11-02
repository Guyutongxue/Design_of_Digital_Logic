module BCD2binary(
    input [3:0] thousands_gy,
    input [3:0] hundreds_gy,
    input [3:0] tens_gy,
    input [3:0] ones_gy,
    output reg [13:0] binary_gy
);
    reg [29:0] shifter_gy; 
    integer i_gy;
    
    always @(thousands_gy, hundreds_gy, tens_gy, ones_gy) begin 
        shifter_gy[13:0] = 0;
        shifter_gy[17:14] = ones_gy;
        shifter_gy[21:18] = tens_gy;
        shifter_gy[25:22] = hundreds_gy;
        shifter_gy[29:26] = thousands_gy;

        for (i_gy = 0; i_gy < 14; i_gy = i_gy+1) begin 
            shifter_gy = shifter_gy >> 1;    
            if (shifter_gy[17:14] >= 8) 
                shifter_gy[17:14] = shifter_gy[17:14] - 3; 
            if (shifter_gy[21:18] >= 8)             
                shifter_gy[21:18] = shifter_gy[21:18] - 3;
            if (shifter_gy[25:22] >= 8)            
                shifter_gy[25:22] = shifter_gy[25:22] - 3; 
            if (shifter_gy[29:26] >= 8)              
                shifter_gy[29:26] = shifter_gy[29:26] - 3; 
        end
        binary_gy = shifter_gy[13:0];
    end

endmodule