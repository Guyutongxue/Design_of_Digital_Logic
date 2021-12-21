module alu32 #(parameter WIDTH = 32)
            (input  [31:0] srca,
             input  [31:0] srcb,
             input  [3:0]  alucontrol,
             input  [4:0]  shamt,
             output [31:0] aluout,
             output        zero);
  wire [31:0] add_result;
  wire [31:0] sub_result;
  reg  [31:0] alu_result;
  adder32 u_add(
    .a(srca), 
    .b(srcb), 
    .cin(1'b0), 
    .s(add_result),
    .cout());
  adder32 u_sub(
    .a(srca), 
    .b(~srcb), 
    .cin(1'b1), 
    .s(sub_result),
    .cout());
  assign zero = sub_result == 0;
  always @ (*) begin
    case (alucontrol[2:0])
      3'b000: alu_result = alucontrol[3]    // add / sub
        ? sub_result 
        : add_result;
      3'b001: alu_result <= srca << shamt;   // sll
      3'b010: alu_result <= sub_result[31];  // slt
      3'b011: alu_result <= {(WIDTH){1'bx}}; // sltu
      3'b100: alu_result <= srca ^ srcb;     // xor
      3'b101: alu_result <= alucontrol[3]    // srl / sra
        ? srca >>> shamt 
        : srca >> shamt;
      3'b110: alu_result <= srca | srcb;     // or
      3'b111: alu_result <= srca & srcb;     // and
      default: alu_result <= {(WIDTH){1'bx}};
    endcase
  end
  assign aluout = alu_result;
endmodule