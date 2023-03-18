module flipflop (
  input wire clk,reset,
  input wire[31:0] q,
  output reg[31:0]qout
);
  always @(posedge clk)
    begin
      if(reset)
        begin
          qout <= 0;
        end
      else
        begin
          qout <= q;
        end
    end
endmodule
      