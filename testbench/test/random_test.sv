class random_test extends base_test;

  `uvm_component_utils(random_test)


  function new(string name = "random_test",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // TYPE OVERRIDE (Sequence is uvm_object)
    base_seq::type_id::set_type_override(random_seq::get_type()
    );

  endfunction

endclass