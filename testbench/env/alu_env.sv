`ifndef ALU_ENV_SV
`define ALU_ENV_SV


class alu_env extends uvm_env;

  `uvm_component_utils(alu_env)

  extern function new(string name, uvm_component parent);


  alu_agent     m_alu_agent;   
  //alu_coverage  m_alu_coverage;
  alu_config    m_config;
     
  

  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern task          run_phase(uvm_phase phase);



endclass : alu_env 


function alu_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new



function void alu_env::build_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In build_phase", UVM_HIGH)


  if (!uvm_config_db #(alu_config)::get(this, "", "config", m_config)) 
    `uvm_error(get_type_name(), "Unable to get alu_config")


  uvm_config_db #(alu_config)::set(this, "m_alu_agent", "config", m_config);
  if (m_config.is_active == UVM_ACTIVE )
    uvm_config_db #(alu_config)::set(this, "m_alu_agent.m_sequencer", "config", m_config);
  uvm_config_db #(alu_config)::set(this, "m_alu_coverage", "config", m_config);


  m_alu_agent    = alu_agent   ::type_id::create("m_alu_agent", this);
  //m_alu_coverage = alu_coverage::type_id::create("m_alu_coverage", this);


endfunction : build_phase


function void alu_env::connect_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "In connect_phase", UVM_HIGH)

  //m_alu_agent.analysis_port.connect(m_alu_coverage.analysis_export);


endfunction : connect_phase



function void alu_env::end_of_elaboration_phase(uvm_phase phase);
  uvm_factory factory = uvm_factory::get();
  `uvm_info(get_type_name(), "Information printed from alu_env::end_of_elaboration_phase method", UVM_MEDIUM)
  `uvm_info(get_type_name(), $sformatf("Verbosity threshold is %d", get_report_verbosity_level()), UVM_MEDIUM)
  uvm_top.print_topology();
  factory.print();
endfunction : end_of_elaboration_phase



task alu_env::run_phase(uvm_phase phase);
  virtual_sequence vseq;
  vseq = virtual_sequence::type_id::create("vseq");
  vseq.set_item_context(null, null);
  if ( !vseq.randomize() )
    `uvm_fatal(get_type_name(), "Failed to randomize virtual sequence")
  vseq.m_alu_agent = m_alu_agent;
  vseq.m_config    = m_config;   
  vseq.set_starting_phase(phase);
  vseq.start(null);


endtask : run_phase



`endif

