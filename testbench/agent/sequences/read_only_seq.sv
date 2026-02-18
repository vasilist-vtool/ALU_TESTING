class read_only_seq extends base_seq;


        `uvm_object_utils(read_only_seq)

  alu_config  m_config;

  extern function new(string name = "");
  extern virtual task body();


endclass


function read_only_seq::new(string name = "");
  super.new(name);
endfunction : new


task read_only_seq::body();
  `uvm_info(get_type_name(), "read_only_seq starting", UVM_HIGH)
 
  repeat (NUM_TRANSACTIONS) begin

    req = apb_transaction::type_id::create("req");
         start_item(req); 
    if ( !req.randomize() )
         req.write = 0;
        `uvm_error(get_type_name(), "Failed to randomize transaction")
        finish_item(req);
    
  end

  `uvm_info(get_type_name(), "read_only_seq completed", UVM_HIGH)
endtask : body



