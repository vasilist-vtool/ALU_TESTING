
`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV

class alu_driver extends uvm_driver #(apb_transaction);

  `uvm_component_utils(alu_driver)

  virtual alu_if vif;

  alu_config     m_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "run_phase", UVM_HIGH)
    forever begin
      fork : alu_driver_running
        begin
          do_drive();
        end
        begin
          do_reset();
        end
      join_any
      disable alu_driver_running;
    end
  endtask : run_phase

  task do_drive();
    wait(vif.rst_n == 1);
    seq_item_port.get_next_item(req);
    `uvm_info(get_type_name(), {"req item\n",req.sprint}, UVM_HIGH)
    
    vif.psel    <= 0;
    vif.penable <= 0;
    
    repeat (req.delay) @(posedge vif.clk);

  //SETUP
    vif.psel    <= 1;
    vif.penable <= 0;
    vif.pwrite  <= req.write;
    vif.paddr   <= req.addr;

    if (req.write)
      vif.pwdata <= req.data;

    //ACCESS PHASE
    @(posedge vif.clk);
    vif.penable <= 1;

    // waiting for pready
    while (!vif.ready) begin
      @(posedge vif.clk);
    end
    
    seq_item_port.item_done();
  endtask

  task do_reset();
    forever begin
      @(posedge vif.clk);
      if(vif.rst_n == 0) begin
        break;
      end
    end
  endtask

endclass : alu_driver 

`endif // ALU_DRIVER_SV

