
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
class environment;

  generator g0;
  driver d0;
  monitor m0;
  scoreboard s0;
  mailbox drv_mail , mon_mail;
  virtual intf vir_intf;
  event gen_ended,driv_ended,moni_ended,score_ended;
  int count;
  
  function new(virtual intf vir_intf,int count);
    this.vir_intf = vir_intf;
    drv_mail = new(1);
    mon_mail = new();
    g0 = new(drv_mail,gen_ended);
    d0 = new(gen_ended,driv_ended,drv_mail,vir_intf);
    m0 = new(mon_mail,vir_intf,driv_ended,moni_ended,count-1);
    s0 = new(mon_mail,vir_intf,moni_ended,score_ended);

    this.count = count;
  endfunction

  task reset;
    
    d0.reset();
    
  endtask
  task test;
    fork
      g0.gendata(count);
      d0.main();
    //  m0.main();
    //  s0.main();
    join
  endtask

  task main;
    reset();
    test();
    m0.reset();
     m0.main();
    $finish;
  endtask

endclass