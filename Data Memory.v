module Data_Memory(
  input       [31: 0] A,
  input       [31: 0] WD,
  input               WE,
  input               clk,

  output wire [31: 0] RD
);

reg [31: 0] mem [0: 63];

assign RD = mem[A[31: 2]];

always @(posedge clk) begin
  if (WE)
    mem[A[31:2]] <= WD;
end

endmodule