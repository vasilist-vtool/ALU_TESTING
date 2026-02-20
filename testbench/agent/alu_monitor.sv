
`ifndef ALU_MONITOR_SV
`define ALU_MONITOR_SV


class alu_monitor extends uvm_monitor;

  `uvm_component_utils(alu_monitor)

  virtual alu_if vif;

  alu_config     m_config;

  uvm_analysis_port #(apb_transaction) analysis_port;

  apb_transaction tx;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    // Create an instance of the analysis port
    analysis_port = new ("analysis_port", this);
  endfunction

task next_trans();
  tx = apb_transaction::type_id::create ("tx", this);
  tx.state = ALU_TX_STATE_IDLE;
  forever begin
    if(vif.rst_n === 1) break;
      @(posedge vif.clk);
  end
  do_monitor();
endtask

task next_rst();
  forever begin
    @(negedge vif.clk);
    if(vif.rst_n === 0) begin
      break;
    end
  end
endtask


  virtual task run_phase (uvm_phase phase);
    forever begin
      process p[2];
      fork : alu_monitor_running
        
        begin
          p[0] = process::self();
          next_trans();
        end

        begin
          p[1] = process::self();          
          next_rst();
        end

      join_any
      p[0].kill();
      p[1].kill();
      if (tx.state != ALU_TX_STATE_IDLE) begin
        analysis_port.write(tx);
      end
    end
  endtask

task do_monitor();
  
  tx.state = ALU_TX_STATE_ACTIVE;


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

  tx.state = ALU_TX_STATE_COMPLETED;

endtask

endclass : alu_monitor 

`endif

