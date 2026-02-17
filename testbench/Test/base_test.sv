// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: top_test.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Fri Feb 13 17:50:22 2026
//=============================================================================
// Description: Test class for top (included in package top_test_pkg)
//=============================================================================

`ifndef BASE_TEST_SV
`define BASE_TEST_SV

// You can insert code here by setting test_inc_before_class in file common.tpl

class base_test extends uvm_test;

  `uvm_component_utils(base_test)

  alu_env m_env;
  alu_config m_config;

  extern function new(string name, uvm_component parent);

  // You can remove build_phase method by setting test_generate_methods_inside_class = no in file common.tpl

  extern function void build_phase(uvm_phase phase);

  // You can insert code here by setting test_inc_inside_class in file common.tpl

endclass


function base_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


// You can remove build_phase method by setting test_generate_methods_after_class = no in file common.tpl

function void base_test::build_phase(uvm_phase phase);

  // You can insert code here by setting test_prepend_to_build_phase in file common.tpl

  // You could modify any test-specific configuration object variables here



  m_env = alu_env::type_id::create("m_env", this);
  m_config = alu_config::type_id::create("m_config",this);
  // You can insert code here by setting test_append_to_build_phase in file common.tpl

endfunction 


// You can insert code here by setting test_inc_after_class in file common.tpl

`endif // TOP_TEST_SV

