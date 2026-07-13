module Instruction_Memory(
  input      [31: 0] PC,
  output reg [31: 0] Instr
);

reg [31: 0] mem [0:63];

always @(*) begin
  Instr = mem[PC[31:2]];
end

endmodule