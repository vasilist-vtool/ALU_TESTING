// You can insert code here by setting file_header_inc in file common.tpl

//=============================================================================
// My copyright string
//=============================================================================
// Project  : alu_project
//
// File Name: alu_adapter.sv
//
// Author   : Name   : My name
//            Email  : my.email
//            Tel    : My telephone
//            Dept   : My department
//            Company: My company
//            Year   : My year
//
// Version:   Version_string
//
// Code created by Easier UVM Code Generator version 2017-01-19 on Wed Feb 11 17:24:17 2026
//=============================================================================
// Description: Environment for reg2 alu_adapter.sv

//=============================================================================

`ifndef REG2ALU_ADAPTER_SV
`define REG2ALU_ADAPTER_SV

// You can insert code here by setting adapter_inc_before_class in file ral.tpl

class reg2alu_adapter extends uvm_reg_adapter;

  `uvm_object_utils(reg2alu_adapter)

  extern function new(string name = "");

  // You can remove reg2bus and bus2reg by setting adapter_generate_methods_inside_class = no in file ral.tpl

  extern function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  extern function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);

  // You can insert code here by setting adapter_inc_inside_class in file ral.tpl

endclass : reg2alu_adapter 


function reg2alu_adapter::new(string name = "");
   super.new(name);
endfunction : new


// You can remove reg2bus and bus2reg by setting adapter_generate_methods_after_class = no in file ral.tpl

function uvm_sequence_item reg2alu_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  apb_transaction alu = apb_transaction::type_id::create("alu");
  alu.op   = (rw.kind == UVM_READ) ? 0 : 1;
  alu.addr = rw.addr;                      
  alu.data = rw.data;                      
  `uvm_info(get_type_name(), $sformatf("reg2bus rw::kind: %s, addr: %d, data: %h, status: %s", rw.kind, rw.addr, rw.data, rw.status), UVM_HIGH)
  return alu;
endfunction : reg2bus


function void reg2alu_adapter::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  apb_transaction alu;
  if (!$cast(alu, bus_item))
    `uvm_fatal(get_type_name(),"Provided bus_item is not of the correct type")
  rw.kind   = alu.op ? UVM_WRITE : UVM_READ;
  rw.addr   = alu.addr;
  rw.data   = alu.data;
  rw.status = UVM_IS_OK;
  `uvm_info(get_type_name(), $sformatf("bus2reg rw::kind: %s, addr: %d, data: %h, status: %s", rw.kind, rw.addr, rw.data, rw.status), UVM_HIGH)
endfunction : bus2reg


// You can insert code here by setting adapter_inc_after_class in file ral.tpl


`endif // REG2ALU_ADAPTER_SV

