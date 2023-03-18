module registerfile(
  input wire[4:0] a1,a2,a3,
  input wire[31:0] wd3,
  input clk , we3,
  output reg[31:0] d1,d2
); 
  
  reg [31:0] rf[31:0] ;

  always @(posedge clk)
    begin
      if(we3)
        begin
          rf[a3] <= wd3;
        end
    end

  
  assign d1 =  a1? rf[a1] : 0 ;
  assign d2 =  a2? rf[a2] : 0 ;
endmodule