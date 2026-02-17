`ifndef BASE_TEST_SV
`define BASE_TEST_SV


class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  alu_env m_env;
  alu_config m_config;

  extern function new(string name, uvm_component parent);


  extern function void build_phase(uvm_phase phase);

  

endclass


function base_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new



function void base_test::build_phase(uvm_phase phase);

 if (!uvm_config_db #(alu_config)::get(this, "", "alu_config", m_config)) 
    `uvm_error(get_type_name(), "Unable to get alu_config")



  m_env = alu_env::type_id::create("m_env", this);
  uvm_config_db #(alu_config)::set(this, "m_env", "config", m_config);


endfunction 

`endif 

