class apb_transaction extends uvm_sequence_item;

    `uvm_object_utils(apb_transaction)

    rand wr_rd_type op;
    rand logic write;
    rand data_t data; 
    rand address_t addr;

    logic ready;
    logic slv_error;

    constraint c_addr {addr inside{[0:4]};}


function new(string name ="");
    super.new(name);
endfunction


endclass