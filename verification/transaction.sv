// class transaction;

//   bit [31:0] instrdatain;
//   bit [31:0] addwrite;
//   bit [31:0] writeData;
//   bit [31:0] Address;
//   bit reset,instwen,memWrite;



//   function transaction copy();
//     transaction tmp ;
//     tmp = new();

//     tmp.instrdatain = this.instrdatain;
//     tmp.addwrite = this.addwrite;
//     tmp.instwen = this.instwen;
//     tmp.reset = this.reset

//     return temp;
//   endfunction
// endclass

class transaction;

  rand bit [31:0] instrdatain;
  bit [31:0] addwrite;
  bit instwen;
  bit reset;
  bit [31:0] writeData;
  bit [31:0] Address;
  bit memWrite;  
  randc bit [4:0] reg2;
  randc bit [4:0] reg1;
  randc bit [4:0] reg3;


  constraint addi {
    instrdatain[31:26] == 6'd8;
    instrdatain[25:21] == 5'd0;
    reg2 != 5'd0;
    instrdatain[20:16] == reg2;
    instrdatain[15:0] < 16'd200;
  }

  constraint r_format {
    instrdatain[31:26] == 6'd0;
    instrdatain[25:21] == reg1;
    instrdatain[20:16] == reg2;
    reg3 != 0;
    instrdatain[15:11] == reg3;
    instrdatain[10:6]  == 5'd0;
    instrdatain[5:0] inside {6'd32 , 6'd34 , 6'd36 , 6'd37 , 6'd39 , 6'd42} ;
  }

  constraint i_format {
    instrdatain[31:26] inside {6'd8 , 6'd10 , 6'd12 , 6'd13};
    instrdatain[25:21] == reg1;
    reg2 != 5'd0;
    instrdatain[20:16] == reg2;
    instrdatain[15:0] < 16'd200;
  }

  constraint word {
    instrdatain[31:26] inside {6'd43 , 6'd35};
    instrdatain[25:21] == reg1;
    reg2 != 5'd0;
    instrdatain[20:16] == reg2;
    instrdatain[15:0] < 16'd200;
  }



  function transaction copy();
    transaction tmp ;
    tmp = new();

    tmp.instrdatain = this.instrdatain;
    tmp.addwrite = this.addwrite;
    tmp.instwen = this.instwen;
    tmp.reset = this.reset;

    return tmp;
  endfunction

  task copy_me(transaction trx);
    this.instrdatain =  trx.instrdatain;
    this.addwrite = trx.addwrite;
    this.instwen = trx.instwen;
    this.reset =  trx.reset;    
  endtask

  task moniter_copy(virtual intf vir_intf);
    begin
      this.instrdatain = vir_intf.instrdatain;
      this.addwrite = vir_intf.addwrite;
      this.reset = vir_intf.reset;
      this.instwen = vir_intf.instwen;
      this.writeData = vir_intf.writeData;
      this.Address = vir_intf.Address;
      this.memWrite = vir_intf.memWrite;
    end
  endtask
  
  task score_tmp(transaction trx);
    begin
      this.instrdatain = trx.instrdatain;
      this.addwrite = trx.addwrite;
      this.reset = trx.reset;
      this.instwen = trx.instwen;
      this.writeData = trx.writeData;
      this.Address = trx.Address;
      this.memWrite = trx.memWrite;
    end
  endtask
  

  function transaction moniter_tmp();
    begin
      transaction tmp1 ;
      tmp1 = new();

      tmp1.instrdatain = this.instrdatain;
      tmp1.addwrite = this.addwrite;
      tmp1.instwen = this.instwen;
      tmp1.reset = this.reset;
      tmp1.writeData = this.writeData;
      tmp1.Address = this.Address;
      tmp1.memWrite = this.memWrite;

      return tmp1;
    end
  endfunction
endclass

