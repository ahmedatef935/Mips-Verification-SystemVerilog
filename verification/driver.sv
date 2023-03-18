`define DRIV_IF vir_intf

class driver;

  event driv_ended,gen_ended,mail_empty;
  virtual intf vir_intf;
  mailbox drv_mail;
  transaction trans,tmp;



  function new (event gen_ended ,  event ended , mailbox mail ,virtual intf vir_intf );
    trans = new();
    this.gen_ended = gen_ended;
    this.driv_ended = ended;
    this.drv_mail = mail;
    this.vir_intf = vir_intf;

  endfunction

  task reset();
    $display("Driver_Started_reseeeeeeeeet");

    //trans.instrdatain <= 0;
    //trans.clk <= 0;
    `DRIV_IF.instwen <= 1;
    `DRIV_IF.reset <= 0;


  endtask


  task drive;

    $display("Driver_Started");
    if(!drv_mail.num()) begin
      $display("mail_emptyyyyyyyyy");
      -> mail_empty;

    end
    else begin
      drv_mail.get(tmp);
      trans.copy_me(tmp);

      @(posedge vir_intf.clk)

      `DRIV_IF.instrdatain <= trans.instrdatain;
      `DRIV_IF.addwrite <= trans.addwrite;
      #1;


    end
  endtask

  task monitor();
    @(posedge vir_intf.clk)
    trans.writeData <=`DRIV_IF.writeData;
    trans.Address <=`DRIV_IF.Address;
    trans.memWrite <=`DRIV_IF.memWrite;
    //$display("Driiiive time=%g       instrdatain=%h  addwrite=%h    instwen=%b", $time, trans.instrdatain, trans.addwrite, trans.instwen);
    $display("address= %h    writeData=%h     Address=%h      memWrite=%h",`DRIV_IF.instruction,trans.writeData, trans.Address, trans.memWrite);

  endtask

  task main;
    forever
      begin
        if(mail_empty.triggered )
          begin
            ->driv_ended;
            break;
          end
        else
          begin
            drive();                
          end
      end
//     @(posedge vir_intf.clk)
//     `DRIV_IF.reset = 1;
//     @(posedge vir_intf.clk)
//     `DRIV_IF.reset = 0;
//     @(posedge vir_intf.clk)
// //     repeat(40)
// //       begin
// //         monitor();
// //       end

  endtask


endclass