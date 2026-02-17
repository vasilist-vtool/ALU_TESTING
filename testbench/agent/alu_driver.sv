// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: alu_driver.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Fri Feb 13 17:50:22 2026
//=============================================================================
// Description: Driver for alu
//=============================================================================

`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV

// You can insert code here by setting driver_inc_before_class in file ral.tpl

class alu_driver extends uvm_driver #(apb_transaction);

  `uvm_component_utils(alu_driver)

  virtual alu_if vif;

  alu_config     m_config;

  extern function new(string name, uvm_component parent);



task do_drive();
  //vif.data <= req.data;
  @(posedge vif.clk);
    vif.paddr   <= 1;
      vif.pwdata  <= 1;
      vif.pwrite  <= 1;
      vif.psel    <= 1;
      vif.penable <= 1;



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


  // You can insert code here by setting driver_inc_inside_class in file ral.tpl

endclass : alu_driver 


function alu_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new




// You can insert code here by setting driver_inc_after_class in file ral.tpl

`endif // ALU_DRIVER_SV

