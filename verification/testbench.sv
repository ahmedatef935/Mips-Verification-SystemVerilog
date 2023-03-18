`include "test.sv"
`include "interface.sv"
module automatic test_top;
bit clk;
  
  always
    begin
      #0.5 clk = ~clk;
    end
  
  intf _if(clk);

  //Testcase instance
  test t1(_if);

  //DUT instance
  top DUT (.clk(_if.clk),
           .reset(_if.reset),
           .instwen(_if.instwen),
           .instrdatain(_if.instrdatain),
           .addwrite(_if.addwrite),
           .writeData(_if.writeData),
           .Address(_if.Address),
           .memWrite(_if.memWrite),
           .instruction(_if.instruction)
          );

  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end


endmodule