class apb_transaction extends uvm_sequence_item;

    `uvm_object_utils(apb_transaction)

    rand wr_rd_type op;
    rand logic write;
    rand data_t data; 
    rand address_t addr;
    rand logic delay;

    logic ready;
    logic slv_error;

    constraint c_addr {addr inside{[0:4]};}
    constraint c_delay {delay inside{[0:50]};}

function new(string name ="");
    super.new(name);
endfunction


endclass