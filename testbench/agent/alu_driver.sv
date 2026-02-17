
`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV



class alu_driver extends uvm_driver #(apb_transaction);

  `uvm_component_utils(alu_driver)

  virtual alu_if vif;

  alu_config     m_config;

  extern function new(string name, uvm_component parent);



task do_drive();
  //vif.data <= req.data;
  vif.pwdata = 'h123;
  vif.prdata = 'h321;
endtask





task run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever
  begin
    seq_item_port.get_next_item(req);
      `uvm_info(get_type_name(), {"req item\n",req.sprint}, UVM_HIGH)
    do_drive();
    seq_item_port.item_done();
  end
endtask : run_phase



endclass : alu_driver 


function alu_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new




// You can insert code here by setting driver_inc_after_class in file ral.tpl

`endif // ALU_DRIVER_SV

