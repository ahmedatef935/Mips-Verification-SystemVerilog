
class generator;
  transaction gentrans;
  mailbox drvmail;
  event gen_ended;
  rand bit [2:0] cons;

  constraint cons_cons {
    cons inside {1,2,4};
  }


  function new(mailbox mail,event ended);
    this.gen_ended = ended;
    this.drvmail = mail;
  endfunction

  task gendata(int count);
    gentrans = new();
    for(int i = 1 ; i <= count ; i++)
      begin
        if(i == 1)
          begin
            gentrans.addwrite = 32'b0;
          end
        else
          begin
            gentrans.addwrite = gentrans.addwrite + 32'b100;
          end
        gentrans.instwen = 1;
        if(i < 32)
          begin

            gentrans.addi.constraint_mode(1);
            gentrans.r_format.constraint_mode(0);
            gentrans.i_format.constraint_mode(0);
            gentrans.word.constraint_mode(0);
          end
        else
          begin
            //assert(std::randomize(cons) with { cons inside{1,2,4} });
            assert (std::randomize(cons) with {cons inside { 1,2,4 };});

            $display("conss",cons);
            gentrans.addi.constraint_mode(0);
            gentrans.r_format.constraint_mode(cons[0]);
            gentrans.i_format.constraint_mode(cons[1]);
            gentrans.word.constraint_mode(cons[2]); 

          end
        assert (gentrans.randomize());
        // transaction::addwrite = transaction::addwrite + 32'b100;
        $display("generator_Started");
        drvmail.put(gentrans.copy());
      end
    ->gen_ended;
    #1;
  endtask
endclass