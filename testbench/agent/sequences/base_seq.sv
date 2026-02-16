// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// Project  : generated_tb
//
// File Name: alu_seq_lib.sv
//
//
// Version:   1.0
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Fri Feb 13 16:14:11 2026
//=============================================================================
// Description: Sequence for agent alu
//=============================================================================

`ifndef BASE_SEQ_SV
`define BASE_SEQ_SV

class base_seq extends uvm_sequence #(apb_transaction);

  `uvm_object_utils(base_seq)

  //alu_config  m_config;

  extern function new(string name = "");
  extern task body();


endclass : base_seq


function base_seq::new(string name = "");
  super.new(name);
endfunction : new


task base_seq::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)

  req = apb_transaction::type_id::create("req");
  start_item(req); 
  if ( !req.randomize() )
    `uvm_error(get_type_name(), "Failed to randomize transaction")
  finish_item(req); 

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body

`endif // BASE_SEQ_SV

