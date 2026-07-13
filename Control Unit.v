module Control_Unit(
  input      [31: 0] Instr,
  input              zero,
  input              sign,

  output reg         PCSrc,
  output reg         ResultSrc,
  output reg         MemWrite,
  output reg         ALUSrc,
  output reg         RegWrite,
  output reg         PCLoad,
  output reg [1: 0]  ImmSrc,
  output reg [2: 0]  ALUControl
);

reg        branch;
reg [1: 0] ALUOp;

//main decoder
always @(*) begin
  case (Instr[6:0]) //OpCode
    //loadWord
    'b0000011: begin
      RegWrite  = 1;
      ImmSrc    = 'b00;
      ALUSrc    = 1;
      MemWrite  = 0;
      ResultSrc = 1;
      branch    = 0;
      ALUOp     = 'b00;
      PCLoad    = 1;
    end

    //StoreWord
    'b0100011: begin
      RegWrite  = 0;
      ImmSrc    = 'b01;
      ALUSrc    = 1;
      MemWrite  = 1;
      ResultSrc = 0; //x
      branch    = 0;
      ALUOp     = 'b00;
      PCLoad    = 1;
    end

    //R-Type
    'b0110011: begin
      RegWrite  = 1;
      ImmSrc    = 'b00; //xx
      ALUSrc    = 0;
      MemWrite  = 0;
      ResultSrc = 0;
      branch    = 0;
      ALUOp     = 'b10;
      PCLoad    = 1;
    end

    //I-Type
    'b0010011: begin
      RegWrite  = 1;
      ImmSrc    = 'b00;
      ALUSrc    = 1;
      MemWrite  = 0;
      ResultSrc = 0;
      branch    = 0;
      ALUOp     = 'b10;
      PCLoad    = 1;
    end

    //Branch Instruction
    'b1100011: begin
      RegWrite  = 0;
      ImmSrc    = 'b10;
      ALUSrc    = 0;
      MemWrite  = 0;
      ResultSrc = 0; //x
      branch    = 1;
      ALUOp     = 'b01;
      PCLoad    = 1;
    end

    //Default
    default: begin
      RegWrite  = 0;
      ImmSrc    = 'b00;
      ALUSrc    = 0;
      MemWrite  = 0;
      ResultSrc = 0;
      branch    = 0;
      ALUOp     = 'b00;
      PCLoad    = 0;
    end
  endcase
end

//ALU decoder
always @(*) begin
  case (ALUOp)
    'b00: ALUControl = 'b000;

    'b01: ALUControl = 'b010;

    'b10: begin
      case (Instr[14: 12]) //FUNCT3
        'b000: ALUControl = ({Instr[5], Instr[30]} == 'b11) ?  'b010 : 'b00;
        default: ALUControl = Instr[14: 12];
      endcase
    end

    default: begin
      ALUControl = 'b000;
    end
  endcase
end

always @(*) begin
    if (branch) begin
        case (Instr[14:12]) //FUNCT3
            'b000:  PCSrc = zero;
            'b001:  PCSrc = ~zero;
            'b100:  PCSrc = sign;
            default: PCSrc = 'b0;
        endcase
    end 

    else PCSrc = 'b0;
end

endmodule

