class apb_transaction extends uvm_sequence_item;

    `uvm_object_utils(apb_transaction)

    rand wr_rd_type op;
    rand logic write;
    rand data_t data; 
    rand address_t addr;
    rand int unsigned delay;

    logic ready;
    logic slv_err;

    constraint c_addr {addr inside{[0:4]};}
    constraint c_delay {delay inside{[0:50]};}

function new(string name ="");
    super.new(name);
endfunction


  extern function void do_copy(uvm_object rhs);
  extern function bit  do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
  extern function void do_record(uvm_recorder recorder);
  extern function void do_pack(uvm_packer packer);
  extern function void do_unpack(uvm_packer packer);
  extern function string convert2string();



endclass


function void apb_transaction::do_copy(uvm_object rhs);
  apb_transaction rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  super.do_copy(rhs);
  write   = rhs_.write;  
  op      = rhs_.op;     
  addr    = rhs_.addr;   
  data    = rhs_.data;   
  ready   = rhs_.ready;  
  slv_err = rhs_.slv_err;
  delay   = rhs_.delay;  
endfunction : do_copy


function bit apb_transaction::do_compare(uvm_object rhs, uvm_comparer comparer);
  bit result;
  apb_transaction rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal(get_type_name(), "Cast of rhs object failed")
  result = super.do_compare(rhs, comparer);
  result &= comparer.compare_field("write", write,     rhs_.write,   $bits(write));
  result &= comparer.compare_field("op", op,           rhs_.op,      $bits(op));
  result &= comparer.compare_field("addr", addr,       rhs_.addr,    $bits(addr));
  result &= comparer.compare_field("data", data,       rhs_.data,    $bits(data));
  result &= comparer.compare_field("ready", ready,     rhs_.ready,   $bits(ready));
  result &= comparer.compare_field("slv_err", slv_err, rhs_.slv_err, $bits(slv_err));
  result &= comparer.compare_field("delay", delay,     rhs_.delay,   $bits(delay));
  return result;
endfunction : do_compare


function void apb_transaction::do_print(uvm_printer printer);
  if (printer.knobs.sprint == 0)
    `uvm_info(get_type_name(), convert2string(), UVM_MEDIUM)
  else
    printer.m_string = convert2string();
endfunction : do_print


function void apb_transaction::do_record(uvm_recorder recorder);
  super.do_record(recorder);
  // Use the record macros to record the item fields:
  `uvm_record_field("write",   write)  
  `uvm_record_field("op",      op)     
  `uvm_record_field("addr",    addr)   
  `uvm_record_field("data",    data)   
  `uvm_record_field("ready",   ready)  
  `uvm_record_field("slv_err", slv_err)
  `uvm_record_field("delay",   delay)  
endfunction : do_record


function void apb_transaction::do_pack(uvm_packer packer);
  super.do_pack(packer);
  `uvm_pack_int(write)   
  `uvm_pack_int(op)      
  `uvm_pack_int(addr)    
  `uvm_pack_int(data)    
  `uvm_pack_int(ready)   
  `uvm_pack_int(slv_err) 
  `uvm_pack_int(delay)   
endfunction : do_pack


function void apb_transaction::do_unpack(uvm_packer packer);
  super.do_unpack(packer);
  `uvm_unpack_int(write)   
  `uvm_unpack_int(op)      
  `uvm_unpack_int(addr)    
  `uvm_unpack_int(data)    
  `uvm_unpack_int(ready)   
  `uvm_unpack_int(slv_err) 
  `uvm_unpack_int(delay)   
endfunction : do_unpack


function string apb_transaction::convert2string();
  string s;
  $sformat(s, "%s\n", super.convert2string());
  $sformat(s, {"%s\n",
    "write   = 'h%0h  'd%0d\n", 
    "op      = 'h%0h  'd%0d\n", 
    "addr    = 'h%0h  'd%0d\n", 
    "data    = 'h%0h  'd%0d\n", 
    "ready   = 'h%0h  'd%0d\n", 
    "slv_err = 'h%0h  'd%0d\n", 
    "delay   = 'h%0h  'd%0d\n"},
    get_full_name(), write, write, op, op, addr, addr, data, data, ready, ready, slv_err, slv_err, delay, delay);
  return s;
endfunction : convert2string


