`ifndef VIRTUAL_SEQUENCE_SV
`define VIRTUAL_SEQUENCE_SV





class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

  `uvm_object_utils(virtual_sequence)

  alu_config m_config;
  
  alu_agent  m_alu_agent;


  extern function new(string name = "");
  extern task body();
  extern task pre_start();
  extern task post_start();

`ifndef UVM_POST_VERSION_1_1
  // Functions to support UVM 1.2 objection API in UVM 1.1
  extern function uvm_phase get_starting_phase();
  extern function void set_starting_phase(uvm_phase phase);
`endif

endclass


function virtual_sequence::new(string name = "");
  super.new(name);
endfunction : new


task virtual_sequence::body();
  `uvm_info(get_type_name(), "Default sequence starting", UVM_HIGH)


  begin
    fork
      if (m_alu_agent.m_config.is_active == UVM_ACTIVE)
      begin
        base_seq seq;
        seq = base_seq::type_id::create("seq");
        seq.set_item_context(this, m_alu_agent.m_sequencer);
        if ( !seq.randomize() )
          `uvm_error(get_type_name(), "Failed to randomize sequence")
        seq.m_config = m_alu_agent.m_config;
        seq.set_starting_phase( get_starting_phase() );
        seq.start(m_alu_agent.m_sequencer, this);
      end
    join
  end

  `uvm_info(get_type_name(), "Default sequence completed", UVM_HIGH)
endtask : body


task virtual_sequence::pre_start();
  uvm_phase phase = get_starting_phase();
  if (phase != null)
    phase.raise_objection(this);
endtask: pre_start


task virtual_sequence::post_start();
  uvm_phase phase = get_starting_phase();
  if (phase != null) 
    phase.drop_objection(this);
endtask: post_start

// You can insert code here by setting top_seq_inc in file common.tpl

`endif // VIRTUAL_SEQUENCE_SV