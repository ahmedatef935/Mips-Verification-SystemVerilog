
`include "environment.sv"
program test(intf vir_intf);

  environment e0;
  int inst_num;
  
  
  initial begin
	inst_num = 50;
    e0 = new(vir_intf,inst_num);
    e0.main();
  end
endprogram