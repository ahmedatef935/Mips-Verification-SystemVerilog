module signext 
  #(
    parameter N = 16 , M = 32
  )
  (
    input wire[N-1:0] a,
    output wire[M-1:0] b
  );
    
  assign b = {{(M-N){a[N-1]}},a};
    
endmodule