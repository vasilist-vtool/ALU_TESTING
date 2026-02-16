`ifndef RANDOM_SEQ_SV
`define RANDOM_SEQ_SV



class random_seq extends base_seq;


        `uvm_object_utils(random_seq)

  alu_config  m_config;
  int num_transactions = 1;

  extern function new(string name = "");
  extern task body();


endclass


function random_seq::new(string name = "");
  super.new(name);
endfunction : new


task random_seq::body();
  `uvm_info(get_type_name(), "Random sequence starting", UVM_HIGH)
 
  repeat (num_transactions) begin

    req = apb_transaction::type_id::create("req");
         start_item(req); 
    if ( !req.randomize() )
        `uvm_error(get_type_name(), "Failed to randomize transaction")
        finish_item(req);
    
  end

  `uvm_info(get_type_name(), "Random sequence completed", UVM_HIGH)
endtask : body

`endif // RANDOM_SEQ_SV

