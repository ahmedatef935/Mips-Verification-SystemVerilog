
`include "registerfile.v"
`include "alu.v"
`include "multiplexer.v"
`include "signext.v"
`include "adder.v"
`include "shiftleft.v"
`include "ff.v"

module datapath (
  input wire clk,reset,
  input wire [31:0]readmemdata,instruction,
  input wire regwrite,regdst,alusrc,memtoreg,pcsrc,jump,
  input wire [2:0] aluctrl,
  output wire [31:0] aluresult , writememdata,
  output wire [31:0]  pc,
  output wire zero
);
  
  wire [31:0] muxdmout,muxrout,regd1,regd2,signout,slout,addbinp,muxpcinp,pcmuxout,pcnext;
  wire cout;
  wire[4:0] muxrinp;
  
  multiplexer #(.N(5)) regfinp  (.a(instruction[20:16]) , .b(instruction[15:11]) , .s(regdst) , .out(muxrinp));
  
  registerfile rf1( .a1(instruction[25:21]) , .a2(instruction[20:16]) , .a3(muxrinp) , .wd3(muxdmout) , .clk(clk) , .we3(regwrite) , .d1(regd1) ,.d2(writememdata) );
  
  
  
  multiplexer regfout ( .a(writememdata), .b(signout) , .s(alusrc) , .out(muxrout));
  
  alu alu1( .a(regd1) , .b(muxrout) , .ctr(aluctrl) , .result(aluresult) , .zero(zero) , .cout(cout) );
  
  multiplexer memdout (.a(aluresult) , .b(readmemdata) , .out(muxdmout) , .s(memtoreg));
  
  signext sign (.a(instruction[15:0]) , .b(signout) );
  
  shiftleft sl (.a(signout) , .b(slout) );
  
  adder ad1 (.a(pc) , .b(32'b100) , .c(addbinp));
  
  adder ad2 (.a(slout) , .b(addbinp) , .c(muxpcinp));
  
  multiplexer pcmux1 (.a(addbinp) , .b(muxpcinp), .s(pcsrc), .out(pcmuxout));
  
  multiplexer pcmux2 (.a(pcmuxout) , .b({addbinp[31:28],instruction[25:0],2'b00}), .s(jump), .out(pcnext));
  
  flipflop ff (.clk(clk), .reset(reset), .q(pcnext), .qout(pc));

endmodule
                
                       
           