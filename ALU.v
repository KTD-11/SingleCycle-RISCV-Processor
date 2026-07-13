module ALU(
  input      [31: 0] SrcA,
  input      [31: 0] SrcB,
  input      [2 : 0] ALUControl,

  output reg         zero,
  output reg         sign,
  output reg [31: 0] ALUResult
);

always @(*) begin
  case (ALUControl)
    'b000:   ALUResult = SrcA + SrcB;
    'b001:   ALUResult = SrcA << SrcB;
    'b010:   ALUResult = SrcA - SrcB;
    'b100:   ALUResult = SrcA ^ SrcB;
    'b101:   ALUResult = SrcA >> SrcB;
    'b110:   ALUResult = SrcA | SrcB;
    'b111:   ALUResult = SrcA & SrcB;
    default: ALUResult = 0;
  endcase
end

always @(ALUResult) begin
  if (ALUResult == 0)
    zero = 1;
  else
    zero = 0;

  if (ALUResult[31] == 1)
    sign = 1;
  else
    sign = 0;
end

endmodule


