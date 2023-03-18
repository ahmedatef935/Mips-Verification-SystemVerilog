module instructionmem
  #(
    parameter N =32 
  )
  (
    input wire [N-1:0] add ,addwrite,datain,
    input wire wen,clk,
  	output wire [31:0] data
);
  
  reg [31:0] instmem [200:0];
  
  assign data = instmem[add];
  
  always @ (posedge clk)
    begin
      if(wen)
        begin
          instmem[addwrite] <= datain;
        end
    end
  
endmodule