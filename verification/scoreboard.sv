`define DRIV_IF vir_intf

class scoreboard;

  virtual intf vir_intf;  
  mailbox mon_mail;
  transaction trans,tmp;
  event score_ended,monit_ended,mail_end;

  function new (mailbox mon_mail, virtual intf vir_intf ,event monit_ended , event ended );
    trans = new();
    this.vir_intf = vir_intf;
    this.mon_mail = mon_mail;
    this.monit_ended =monit_ended;
    this.score_ended = ended;
  endfunction

  task score();
    if(!mon_mail.num()) begin
      -> mail_end;
      #1;
    end
    else begin
      mon_mail.get(tmp);
      trans.copy_me(tmp);
      $display("time=%g       instrdatain=%h  addwrite=%h    instwen=%b", $time, trans.instrdatain, trans.addwrite, trans.instwen);
     // $display("writeData=%h     Address=%h      memWrite=%h",trans.writeData, trans.Address, trans.memWrite);
    end

  endtask

  task main;

    forever
      begin
        if(mail_end.triggered)
          begin
            if(monit_ended.triggered)
              begin
                ->score_ended;
                break;
              end
          end
        else
          begin
            score();                
          end
      end

  endtask

endclass