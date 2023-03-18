module controller (
  input wire [5:0]opcode,funct,
  input wire zero,
  output wire memwrite,regwrite,regdst,alusrc,memtoreg,pcsrc,jump,
  output wire[2:0] aluctrl
);
  reg [9:0] controllerCode ;
  reg branch;
  always @ (opcode,funct)
    begin
      case(opcode)
        6'b001000:assign controllerCode = 10'b0101000000 ;       //addi
        6'b001100:assign controllerCode = 10'b0101000010 ;       //andi 
        6'b001101:assign controllerCode = 10'b0101000011 ;		//ori
        6'b001010:assign controllerCode = 10'b0101000101 ;		//slti
        6'b000000: case(funct)     //R Format
                     6'b100000 :assign controllerCode = 10'b0110000000;		//add
                     6'b100010 :assign controllerCode = 10'b0110000001;		//sub
                     6'b100100 :assign controllerCode = 10'b0110000010;		//and
                     6'b100101 :assign controllerCode = 10'b0110000011;		//or
                     6'b100111 :assign controllerCode = 10'b0110000110;		//nor
                     6'b101010 :assign controllerCode = 10'b0110000101;		//slt
                     default   :assign controllerCode = 10'bxxxxxxxxxx;		
                    endcase 
        6'b000010:assign controllerCode = 10'b0000001000 ;      //jump
        6'b000100:assign controllerCode = 10'b0000010001 ;		//branch
        6'b101011:assign controllerCode = 10'b1001100000 ;		//sw
        6'b100011:assign controllerCode = 10'b0101100000 ;		//lw
        default  :assign controllerCode = 10'bxxxxxxxxxx ;   
      endcase
    end
  
  assign {memwrite,regwrite,regdst,alusrc,memtoreg,branch,jump,aluctrl} = controllerCode ;
  assign pcsrc = zero && branch;
endmodule