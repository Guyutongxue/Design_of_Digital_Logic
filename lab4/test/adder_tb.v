`timescale 1ns/1ps

module adder32_tb();
  reg [31:0] a;
  reg [31:0] b;
  reg        cin;
  
  wire [31:0] s;
  wire        cout;

  adder32 u(a, b, cin, s, cout);

  initial begin
    $dumpfile("adder.vcd");
    $dumpvars(0, u);
    cin = 0;
    a = 42; b = 56;
    #50 a = 120; b = 365;
    #50 a = 77; b = ~(42); cin = 1;
    #50 a = 100; b = ~(36);
    #50 a = 0; b = 0;
  end

endmodule