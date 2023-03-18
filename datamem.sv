module datamem
  #(
    parameter N = 32
  )
  (
  input wire [N-1:0] add,
  input wire [31:0] wd,
  input wire clk , we,
  output wire [31:0]rd
);
  reg [31:0] damem [1024:0];
  assign rd = damem[add];
  always @ (posedge clk)
    begin
      if(we == 1)
        begin
          damem[add] <= wd;   
        end

    end
endmodule