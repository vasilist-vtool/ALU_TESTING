
`ifndef ALU_MONITOR_SV
`define ALU_MONITOR_SV


class alu_monitor extends uvm_monitor;

  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;

  alu_config     m_config;

  uvm_analysis_port #(apb_transaction) analysis_port;

  extern function new(string name, uvm_component parent);



virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);

      // Create an instance of the analysis port
      analysis_port = new ("analysis_port", this);

      // Get virtual interface handle from the configuration DB
    //if (! uvm_config_db #(virtual alu_if) :: get (this, "", "alu_if", vif)) begin
    // `uvm_error (get_type_name (), "DUT interface not found")
     // end
   endfunction


   virtual task run_phase (uvm_phase phase);
      apb_transaction  tx = apb_transaction::type_id::create ("tx", this);
      
      forever begin

        do_monitor();
      end
   endtask



task do_monitor();
  
  apb_transaction tx;

       wait(vif.rst_n);

      if (vif.psel && vif.penable && vif.ready) begin
      tx.addr    <= vif.paddr;
      tx.write   <= vif.pwrite;
      tx.ready   <= vif.ready;
      tx.slv_err <= vif.slv_err;

      if (vif.pwrite)
        tx.data = vif.pwdata;
      else
        tx.data = vif.prdata;

      analysis_port.write(tx);

  end
endtask





endclass : alu_monitor 


function alu_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


`endif

