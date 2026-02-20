
`ifndef ALU_MONITOR_SV
`define ALU_MONITOR_SV


class alu_monitor extends uvm_monitor;

  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;

  alu_config     m_config;

  uvm_analysis_port #(apb_transaction) analysis_port;

  apb_transaction tx;

  extern function new(string name, uvm_component parent);

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    // Create an instance of the analysis port
    analysis_port = new ("analysis_port", this);
   endfunction


   virtual task run_phase (uvm_phase phase);
    forever begin
    fork
      monitor_transactions();
      monitor_reset();
    join
      end
   endtask



task monitor_transactions();
  tx = apb_transaction::type_id::create ("tx", this);
  forever begin
    if(vif.rst_n === 1) break;
    @(posedge vif.clk);
  end

  tx.delay = 0;
  tx.wait_states = 0;

  forever begin
    if(vif.psel === 1) break;
    @(posedge vif.clk);
    tx.delay++;
  end

  @(posedge vif.clk); //Wait for penable

  forever begin
    if(vif.ready === 1) break;
    @(posedge vif.clk);
    tx.wait_states++;
  end

  tx.addr    = vif.paddr;
  tx.write   = vif.pwrite;
  tx.ready   = vif.ready;
  tx.slv_err = vif.slv_err;

  if (vif.pwrite) begin
    tx.data = vif.pwdata;
  end
  else begin
    tx.data = vif.prdata;
  end

  @(posedge vif.clk); //Wait one cycle for setup phase

  analysis_port.write(tx);

endtask

task monitor_reset();


  forever begin

    
    @(negedge vif.rst_n);

    `uvm_info("MONITOR", "Reset asserted", UVM_MEDIUM)

    @(posedge vif.rst_n);

    `uvm_info("MONITOR", "Reset deasserted", UVM_MEDIUM)
  end
endtask














endclass : alu_monitor 


function alu_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new


`endif

