
`ifndef ALU_CONFIG_SV
`define ALU_CONFIG_SV


class alu_config extends uvm_object;

  // Do not register config class with the factory

  virtual alu_if           vif;
                  
  uvm_active_passive_enum  is_active = UVM_ACTIVE;
  bit                      coverage_enable;       
  bit                      checks_enable;         

  extern function new(string name = "");

endclass : alu_config 



function alu_config::new(string name = "");
  super.new(name);
endfunction : new



`endif 

