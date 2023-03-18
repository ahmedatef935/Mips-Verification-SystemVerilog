`define DRIV_IF vir_intf

class monitor;

  virtual intf vir_intf;
  mailbox mont_mail;
  transaction trx;
  event driv_ended,monit_ended;
  int count;

  function new(mailbox mont_mail , virtual intf vir_intf , event driv_ended , event monit_ended , int count);
    this.count = count;
    trx = new();
    this.monit_ended = monit_ended;
    this.driv_ended = driv_ended;
    this.mont_mail = mont_mail;
    this.vir_intf = vir_intf;
  endfunction

  task reset();
    
    @(posedge vir_intf.clk)
    `DRIV_IF.reset = 1;
    @(posedge vir_intf.clk)
    `DRIV_IF.reset = 0;

  endtask
  task monit;
    @(posedge `DRIV_IF.clk)
   // trx.moniter_copy(`DRIV_IF);
    //mont_mail.put(trx.moniter_tmp());
//             @(posedge vir_intf.clk)
        trx.writeData =`DRIV_IF.cb.writeData;
        trx.Address =`DRIV_IF.cb.Address;
        trx.memWrite =`DRIV_IF.cb.memWrite;
        //$display("Driiiive time=%g       instrdatain=%h  addwrite=%h    instwen=%b", $time, trans.instrdatain, trans.addwrite, trans.instwen);
    $display("instruction= %h    writeData=%h     Address=%h      memWrite=%h",`DRIV_IF.instruction,trx.writeData, trx.Address, trx.memWrite);
  endtask

  task main();
    repeat(count)
      begin
//         if(driv_ended.triggered)
//           begin
//             ->monit_ended;
//             break;
//           end
//         else 
//           begin
            monit();          
//           end
      end
  endtask

endclass

