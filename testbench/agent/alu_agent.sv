
`ifndef ALU_AGENT_SV
`define ALU_AGENT_SV

class alu_agent extends uvm_agent;

  `uvm_component_utils(alu_agent)

  uvm_analysis_port #(apb_transaction) analysis_port;

  alu_config       m_config;
  alu_sequencer_t  m_sequencer;
  alu_driver       m_driver;
  alu_monitor      m_monitor;

  local int m_is_active = -1;

  extern function new(string name, uvm_component parent);


  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern function uvm_active_passive_enum get_is_active();



endclass : alu_agent 


function  alu_agent::new(string name, uvm_component parent);
  super.new(name, parent);
  analysis_port = new("analysis_port", this);
endfunction : new



function void alu_agent::build_phase(uvm_phase phase);



if (!uvm_config_db #(alu_config)::get(this, "", "config", m_config))
    `uvm_error(get_type_name(), "alu config not found")

m_monitor     = alu_monitor    ::type_id::create("m_monitor", this);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver    = alu_driver     ::type_id::create("m_driver", this);
    m_sequencer = alu_sequencer_t::type_id::create("m_sequencer", this);
  end


endfunction : build_phase


function void alu_agent::connect_phase(uvm_phase phase);
  if (m_config.vif == null)
    `uvm_warning(get_type_name(), "alu virtual interface is not set!")

//   m_monitor.vif      = m_config.vif;
//   m_monitor.m_config = m_config;
//   m_monitor.analysis_port.connect(analysis_port);

  if (get_is_active() == UVM_ACTIVE)
  begin
    m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    m_driver.vif      = m_config.vif;
    m_driver.m_config = m_config;
  end
 
endfunction : connect_phase


function uvm_active_passive_enum alu_agent::get_is_active();
  if (m_is_active == -1)
  begin
    if (uvm_config_db#(uvm_bitstream_t)::get(this, "", "is_active", m_is_active))
    begin
      if (m_is_active != m_config.is_active)
        `uvm_warning(get_type_name(), "is_active field in config_db conflicts with config object")
    end
    else 
      m_is_active = m_config.is_active;
  end
  return uvm_active_passive_enum'(m_is_active);
endfunction : get_is_active


`endif 

