module adder
  #(
    parameter N = 32
  )
  (
    input wire[N-1:0] a,b,
    output wire[N-1:0] c
  );
  
  assign c = a + b;
endmodule