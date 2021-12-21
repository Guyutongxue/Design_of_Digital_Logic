module adder1(input a,
              input b,
              input cin,
              output s,
              output g,
              output p);
  assign s = a ^ b ^ cin;
  assign g = a & b;
  assign p = a | b;
endmodule

module cla4(input  [3:0] p,
            input  [3:0] g,
            input        cin,
            output [4:1] ci,
            output gm,
            output pm);
  assign ci[1] = g[0] | p[0] & cin;
  assign ci[2] = g[1] | p[1] & g[0] | p[1] & p[0] & cin;
  assign ci[3] = g[2] | p[2] & g[1] | p[2] & p[1] & g[0] | p[2] & p[1] & p[0] & cin;
  assign ci[4] = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0] | p[3] & p[2] & p[1] & p[0] & cin;

  assign gm = g[3] | p[3] & g[2] | p[3] & p[2] & g[1] | p[3] & p[2] & p[1] & g[0];
  assign pm = p[3] & p[2] & p[1] & p[0];
endmodule

module adder4(input  [3:0] a,
              input  [3:0] b,
              input        cin,
              output [3:0] s,
              output       gm,
              output       pm);
  wire [3:0] g;
  wire [3:0] p;
  wire [4:1] c;

  adder1 u1(a[0], b[0], cin, s[0], g[0], p[0]);
  adder1 u2(a[1], b[1], c[1], s[1], g[1], p[1]);
  adder1 u3(a[2], b[2], c[2], s[2], g[2], p[2]);
  adder1 u4(a[3], b[3], c[3], s[3], g[3], p[3]);
  cla4 uut(p, g, cin, c, gm, pm);
endmodule

module adder16(input  [15:0] a,
               input  [15:0] b,
               input         cin,
               output [15:0] s,
               output        gm,
               output        pm);
  wire [3:0] g;
  wire [3:0] p;
  wire [4:1] c;

  adder4 u1(a[3:0], b[3:0], cin, s[3:0], g[0], p[0]);
  adder4 u2(a[7:4], b[7:4], c[1], s[7:4], g[1], p[1]);
  adder4 u3(a[11:8], b[11:8], c[2], s[11:8], g[2], p[2]);
  adder4 u4(a[15:12], b[15:12], c[3], s[15:12], g[3], p[3]);
  cla4 uut(p, g, cin, c, gm, pm);
endmodule

module adder32(input  [31:0] a,
               input  [31:0] b,
               input         cin,
               output [31:0] s,
               output        cout);
  wire [1:0] g;
  wire [1:0] p;
  wire       c;

  adder16 u1(a[15:0], b[15:0], cin, s[15:0], g[0], p[0]);
  adder16 u2(a[31:16], b[31:16], c, s[31:16], g[1], p[1]);
  assign c = g[0] | p[0] & cin;
  assign cout = g[1] | p[1] & g[0] | p[1] & p[0] & cin;
endmodule