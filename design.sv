`include "datapath.v"
`include "controller.v"
`include "instructionmem.v"
`include "datamem.v"

module top(
  input wire clk,reset,instwen,
  input wire [31:0] instrdatain,addwrite,
  output wire [31:0] writeData,Address,instruction,
  output wire memWrite
);
  reg[31:0] readmemdata,pc;
wire regwrite,regdst,alusrc,memtoreg,pcsrc,jump,zero;
wire [2:0] aluctrl;


  
datapath dp ( .clk(clk), .reset(reset), .readmemdata(readmemdata), .instruction(instruction), .regwrite(regwrite), .regdst(regdst), .alusrc(alusrc), .memtoreg(memtoreg), .pcsrc(pcsrc), .jump(jump), .aluctrl(aluctrl), .aluresult(Address), .writememdata(writeData), .pc(pc) , .zero(zero) );

controller ctr ( .opcode(instruction[31:26]), .funct(instruction[5:0]), .zero(zero), .memwrite(memWrite), .regwrite(regwrite), .regdst(regdst), .alusrc(alusrc), .memtoreg(memtoreg), .pcsrc(pcsrc), .jump(jump), .aluctrl(aluctrl));

instructionmem imem (.add(pc), .datain(instrdatain), .addwrite(addwrite), .clk(clk), .wen(instwen), .data(instruction));

  datamem dmem(.add(Address), .wd(writeData), .we(memWrite), .clk(clk), .rd(readmemdata));

endmodule
          