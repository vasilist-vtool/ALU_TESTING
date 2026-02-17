
`ifndef ALU_MONITOR_SV
`define ALU_MONITOR_SV

// You can insert code here by setting monitor_inc_before_class in file ral.tpl

class alu_monitor extends uvm_monitor;

  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;

  alu_config     m_config;

  uvm_analysis_port #(apb_transaction) analysis_port;

  extern function new(string name, uvm_component parent);

  // You can insert code here by setting monitor_inc_inside_class in file ral.tpl

endclass : alu_monitor 


function alu_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new


// You can insert code here by setting monitor_inc_after_class in file ral.tpl

`endif // ALU_MONITOR_SV

