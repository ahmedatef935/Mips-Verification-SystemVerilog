module alu(
  input wire[31:0] a,b,module alu(
  input wire[31:0] a,b,
  input wire [2:0] ctr,
  output reg [31:0] result,
  output reg zero , cout
);
  task andOP ;
    input  [31:0] a,b;
    assign result = a & b;
  endtask
  
  task orOP;
    input  [31:0] a,b;
	assign result = a | b;
  endtask

  task xorOP;
    input  [31:0] a,b;
	assign result = a ^ b;
  endtask
  
  task notOP;
    input  [31:0] a;
    assign result = ~a;
  endtask  
  
  task sltOP;
    input  [31:0] a,b;
	assign result = a < b ? 32'b1 : 32'b0;
  endtask

  task norOP;
   input  [31:0] a,b;
    assign result = ~(a | b);
  endtask

  task adderOP;
    input  [31:0] a,b;
    reg   [32:0] temp;
    temp = {1'b0,a} + {1'b0,b} ;
    assign cout = temp[32];
    assign result = a + b;
  endtask  

  task subOP;
    input  [31:0] a,b;
    assign result = a - b;
    assign zero = ~|result;
  endtask
  
  always @ *
    begin
      case(ctr)
        3'b000:adderOP(a,b);
        3'b001:subOP(a,b);
        3'b010:andOP(a,b);
        3'b011:orOP(a,b);
        3'b100:xorOP(a,b);
        3'b101:sltOP(a,b);
        3'b110:norOP(a,b);
        3'b111:notOP(a);
        default:adderOP(a,b);
      endcase
    end
  
endmodule