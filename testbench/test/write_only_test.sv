class write_only_test extends base_test;

  `uvm_component_utils(write_only_test)
  
  function new(string name = "write_only_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // TYPE OVERRIDE (Sequence is uvm_object)
    base_seq::type_id::set_type_override(write_only_seq::get_type()
    );

  endfunction

endclass