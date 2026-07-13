module Register_File(
  input  wire [4:  0]  A1,
  input  wire [4:  0]  A2,
  input  wire [4:  0]  A3,
  input  wire [31: 0]  WD3,
  input                WE,
  input                clk,
  input                rst,

  output wire [31: 0]  RD1,
  output wire [31: 0]  RD2
);

reg [31: 0] mem [0: 31];
integer i;

assign RD1 = mem[A1];
assign RD2 = mem[A2];

always @(posedge clk or negedge rst) begin
  if (!rst) begin
    for (i = 0; i < 32; i = i + 1) begin
      mem[i] <= 'b0;
    end
  end

  else if (WE) begin
    mem[A3] <= WD3;
  end
end

endmodule