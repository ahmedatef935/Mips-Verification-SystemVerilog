interface intf(input bit clk);
  logic reset;
  logic [31:0] instrdatain;
  logic [31:0] addwrite;
  logic instwen;
  logic [31:0] writeData;
  logic [31:0] Address;
  logic memWrite;
  logic [31:0]instruction;




  clocking cb@(posedge clk);
    default input #0ns  output #1ns;
    input writeData;
    input Address;
    input memWrite;
    output reset;
    output instwen;
    output instrdatain;
    output addwrite;
  endclocking

endinterface