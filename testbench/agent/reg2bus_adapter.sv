`ifndef REG2ALU_ADAPTER_SV
`define REG2ALU_ADAPTER_SV

// You can insert code here by setting adapter_inc_before_class in file ral.tpl

class reg2alu_adapter extends uvm_reg_adapter;

  `uvm_object_utils(reg2alu_adapter)

  extern function new(string name = "");

  extern function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  extern function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);


endclass : reg2alu_adapter 


function reg2alu_adapter::new(string name = "");
   super.new(name);
endfunction : new



function uvm_sequence_item reg2alu_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  apb_transaction tx = apb_transaction::type_id::create("tx");
  tx.write   = (rw.kind == UVM_WRITE) ? 1 : 0;
  tx.addr = rw.addr;                      
  tx.data = rw.data;                      
  `uvm_info(get_type_name(), $sformatf("reg2bus rw::kind: %s, addr: %d, data: %h, status: %s", rw.kind, rw.addr, rw.data, rw.status), UVM_HIGH)
  return tx;
endfunction : reg2bus


function void reg2alu_adapter::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  apb_transaction tx;
  if (!$cast(tx, bus_item))
    `uvm_fatal(get_type_name(),"Provided bus_item is not of the correct type")
  rw.kind   = tx.write ? UVM_WRITE : UVM_READ;
  rw.addr   = tx.addr;
  rw.data   = tx.data;
  rw.status = UVM_IS_OK;
  `uvm_info(get_type_name(), $sformatf("bus2reg rw::kind: %s, addr: %d, data: %h, status: %s", rw.kind, rw.addr, rw.data, rw.status), UVM_HIGH)
endfunction : bus2reg

`endif // REG2ALU_ADAPTER_SV

