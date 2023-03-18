module shiftleft
  #(
    parameter N=2 , M=32
  )
  (
    input wire[M-1:0] a,
    output wire[M-1:0] b
  );
  
  assign b = a << N;
  
endmodule