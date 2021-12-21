module singleriscv_fpga(input  clk,
                        input  btnC, 
                        input  btnU,
                        input  btnL,
                        input  btnD,
                        input  btnR, 
                        input  [15:0] sw,
                        output [15:0] led,
                        output [0:6] seg,
                        output [0:3] an);

  wire [3:0] btn;
  wire [31:0] pc, instr;
  wire [31:0] dmem_address, writedata, readdata; 
  wire memwrite; 
  
  wire [15:0] portb_in;
  wire [15:0] portc_out;
  wire [15:0] portd_out;
  
  assign btn = {btnL, btnC, btnR, btnU}; // add, sub, multiply, =
  
  // generate 10hz clock
  reg [23:0] cnt;
  reg clk_gen; //1KHz
  wire clk_gen_bufg;
    
  parameter PERIOD_CLK = 1000000;

  always @(posedge clk) begin
    if (cnt == PERIOD_CLK / 2) begin
      cnt <= 0;
      clk_gen <= ~clk_gen;
    end else
      cnt <= cnt + 1;
  end
    
  BUFG CLK0_BUFG_INST(.I(clk_gen),
                      .O(clk_gen_bufg));
  //generate 10Hz clock
  assign mclk = clk_gen_bufg;
  
  reg rst_sync, btnD_reg;  
  // synchronize reset input bnt[3] 
  always @(posedge mclk) begin
	  btnD_reg <= btnD;
		rst_sync <= btnD_reg;
  end

  assign reset_global = rst_sync | btnD;	 
  
  // instantiate devices to be tested
  singleriscv u_singleriscv(mclk, reset_global, pc, instr,
    memwrite, dmem_address, writedata, readdata);
			  
  imem_fpga imem_fpga(pc[9:2], instr);
  
  dmem_io dmem_io(mclk, memwrite, dmem_address, 
    writedata, readdata, btn, portb_in, portc_out, portd_out);

  assign led = portd_out;
  wire [3:0] thousands, hundreds, tens, ones;
  BCD2binary u_bcd2bin(sw[15:12], sw[11:8], sw[7:4], sw[3:0], portb_in);
  binary2BCD u_bin2bcd(portc_out[13:0], ones, tens, hundreds, thousands);
  display_7seg_x4 u_display_7seg(
    .CLK(clk),
    .in0(thousands),
    .in1(hundreds),
    .in2(tens),
    .in3(ones),
    .seg(seg),
    .an(an));

endmodule
