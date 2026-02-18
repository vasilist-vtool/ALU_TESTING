
class custom_scenario extends base_seq;
    `uvm_object_utils(custom_scenario)

  alu_config  m_config;

  extern function new(string name = "");
  extern task body();


endclass


function custom_scenario::new(string name = "");
  super.new(name);
endfunction : new


task custom_scenario::body();
  `uvm_info(get_type_name(), "Random sequence starting", UVM_HIGH)
 
    // Req 1
    req = apb_transaction::type_id::create("req");
    start_item(req); 
    if ( !req.randomize() )
        `uvm_error(get_type_name(), "Failed to randomize transaction")
    req.op = READ;
    finish_item(req);
    get_response(rsp);

    // Req 2
    if (rsp.slv_err == 0) {
        req = apb_transaction::type_id::create("req");
        start_item(req); 
        if ( !req.randomize() )
            `uvm_error(get_type_name(), "Failed to randomize transaction")
        req.op = WRITE;
        req.addr = rsp.addr;
        finish_item(req);
    }
    

  `uvm_info(get_type_name(), "Random sequence completed", UVM_HIGH)
endtask : body

