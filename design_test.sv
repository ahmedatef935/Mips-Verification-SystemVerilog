`include "datapath.v"
`include "controller.v"
`include "instructionmem.v"
`include "datamem.v"

module top(intf _if);
  
  reg[31:0] readmemdata,instruction,pc;
  wire regwrite,regdst,alusrc,memtoreg,pcsrc,jump,zero;
  wire [2:0] aluctrl;


  datapath dp ( .clk(_if.clk), .reset(_if.reset), .readmemdata(readmemdata), .instruction(instruction), .regwrite(regwrite), .regdst(regdst), .alusrc(alusrc), .memtoreg(memtoreg), .pcsrc(pcsrc), .jump(jump), .aluctrl(aluctrl), .aluresult(_if.Address), .writememdata(_if.writeData), .pc(pc) , .zero(zero) );

  controller ctr ( .opcode(instruction[31:26]), .funct(instruction[5:0]), .zero(zero), .memwrite(memWrite), .regwrite(regwrite), .regdst(regdst), .alusrc(alusrc), .memtoreg(memtoreg), .pcsrc(pcsrc), .jump(jump), .aluctrl(aluctrl));

  instructionmem imem (.add(pc), .datain(_if.instrdatain), .addwrite(_if.addwrite), .clk(_if.clk), .wen(_if.instwen), .data(instruction));

  datamem dmem(.add(_if.Address), .wd(_if.writeData), .we(_if.memWrite), .clk(_if.clk), .rd(readmemdata));

endmodule
