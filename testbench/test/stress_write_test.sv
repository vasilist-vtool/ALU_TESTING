class stress_write_test extends write_only_test;

  `uvm_component_utils(stress_write_test)
  
  function new(string name = "stress_write_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    MAX_DELAY = 0;
    NUM_TRANSACTIONS = 1000;

  endfunction

endclass