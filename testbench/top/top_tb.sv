
module top_tb;

  timeunit      1ns;
  timeprecision 1ps;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  //import top_test_pkg::*;
  import alu_pkg::alu_config;

  // Configuration object for top-level environment
  alu_config m_config;

  // Test harness
  top_th th();

  // You can insert code here by setting tb_inc_inside_module in file common.tpl

  // You can remove the initial block below by setting tb_generate_run_test = no in file common.tpl

  initial
  begin
    // You can insert code here by setting tb_prepend_to_initial in file common.tpl

    // Create and populate top-level configuration object
    m_config = new("m_config");
    if ( !m_config.randomize() )
      `uvm_error("top_tb", "Failed to randomize top-level configuration object" )

    m_config.vif             = th.alu_if_0;
    m_config.is_active      = UVM_ACTIVE; 
    m_config.checks_enable   = 1;          
    m_config.coverage_enable = 1;       


    uvm_config_db #(alu_config)::set(null, "uvm_test_top", "alu_config", m_config);
   

    // You can insert code here by setting tb_inc_before_run_test in file common.tpl

    run_test();
  end

endmodule