module stringreco(
    input clk,
    input clr,
    input en,
    input [15:0] sw,
    output reg [15:0] count
    );
    /*

             +---+
             | 0 |
             +---+
            /     \
          0/       \1
    +--+  /         \
   0|  | v           v
    +->+---+   0   +---+
  +--->| 1 |<------| 5 |
  |    +---+       +---+
  |      |  ^        |
  |     1|   \       |1
 0|      |    \      | +--+
  |      v     |     v |  |1
  |    +---+ 1 |   +---+<-+  
  | +->| 2 |------>| 6 |<-+
  | |  +---+   |   +---+  |
  | |   ^|     |0    |    |
  | |   ||0     \    |0   |
  | |  1||       \   |    |
  | |   |v        \  v    |
  | |  +---+       +---+  |
  |1|  | 3 |<+     | 7 |  |1
  | |  +---+  \    +---+  |
  | |    |     \     |    |
  | |    |0    0\    |1   |
  | |    |       \   |    |
  | |    v        \  v    |
  | |  +---+       +---+  |
  | +--| 4 |       | 8 |--+
  +----+---+       +---+   

    */

    parameter reset = 4'd0,
              s1 = 4'd1,
              s2 = 4'd2,
              s3 = 4'd3,
              s4 = 4'd4,
              s5 = 4'd5,
              s6 = 4'd6,
              s7 = 4'd7,
              s8 = 4'd8;

    reg [15:0] shift;
    reg [3:0] state;
    reg [3:0] out;
    wire in;
    reg found;
    reg [16:0] shiftcounter;

    assign in = shift[0];
    
    always @ (posedge clk) begin
        if (clr) begin 
            shiftcounter <= 0;
            state <= reset;
            shift <= sw;
            count <= 0;
            found <= 0;
        end else if (en) begin
            shiftcounter <= 17;
            state <= reset;
            shift <= sw;
            found <= 0;
        end else if (shiftcounter) begin
            shiftcounter <= shiftcounter - 1;
            shift <= shift >> 1;
            found <= state == s4 || state == s8;
            case (state) 
                reset: begin
                    if (in) state = s5;
                    else state = s1;
                end
                s1: begin
                    if (in) state = s2;
                    else state = s1;
                end
                s2: begin
                    if (in) state = s6;
                    else state = s3;
                end
                s3: begin
                    if (in) state = s2;
                    else state = s4;
                end
                s4: begin
                    if (in) state = s2;
                    else state = s1;
                end
                s5: begin
                    if (in) state = s6;
                    else state = s1;
                end
                s6: begin
                    if (in) state <= s6;
                    else state <= s7;
                end
                s7: begin
                    if (in) state <= s8;
                    else state <= s1;
                end
                s8: begin
                    if (in) state <= s6;
                    else state <= s3;
                end
            endcase
        end

        if (found && ~clr) begin
            count <= count + 1;
            found <= 0;
        end
    end

endmodule
