// Code your testbench here
// or browse Examples
module test;
  
  reg  clk,reset,instwen;
  reg  [31:0] instrdatain,addwrite;
  wire [31:0] writeData,Address;
  wire memWrite;
  
  top t0 (.clk(clk), .reset(reset), .instwen(instwen), .addwrite(addwrite), .instrdatain(instrdatain), .writeData(writeData), .Address(Address), .memWrite(memWrite));
  
  initial
    begin
     // $monitor("time=%g  clk=%b    memWrite=%b   instwen=%b ",$time,clk ,memWrite,instwen); 
      clk = 0;
      instwen = 0;
      reset = 0;
	  

      #6
      instwen = 1;
      addwrite = 32'b0;
      instrdatain = 32'b100000000000100000000000000101;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b00100000000000110000000000001100;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b00100000011001111111111111110111;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b111000100010000000100101;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b11001000010100000100100;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b101001000010100000100000;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b10000101001110000000000001010;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b11001000010000000101010;
//       #6addwrite = addwrite + 32'b100;
//       instrdatain = 32'b10000100000000000000000000001;
//       #6addwrite = addwrite + 32'b100;
//       instrdatain = 32'b100000000001010000000000000000;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b111000100010000000101010;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b100001010011100000100000;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b111000100011100000100010;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b10101100011001110000000001000100;
      #12addwrite = addwrite + 32'b100;
      instrdatain = 32'b10001100000000100000000001010000;
//       #6addwrite = addwrite + 32'b100;
//   	  instrdatain = 32'b1000000000000000000000010001;
//       #6addwrite = addwrite + 32'b100;
//       instrdatain = 32'b100000000000100000000000000001;
      #6addwrite = addwrite + 32'b100;
      instrdatain = 32'b10101100000000100000000001010100;
//       #6addwrite = addwrite + 32'b100;
      reset = 1;
      #6
      reset = 0;
      
      
      #100
      $finish;
    end
  
  always
    begin
      #3 clk = ~clk;
    end
  
  always @(negedge clk)
    begin
      if(memWrite)
        begin
          if(Address === 84 & writeData === 7) begin
             $display("Simulation succeeded");
             $stop;
          end 
        end
    end
   
   initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
      