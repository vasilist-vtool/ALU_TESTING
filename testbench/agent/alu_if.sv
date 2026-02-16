
`ifndef ALU_IF_SV
`define ALU_IF_SV

interface alu_if(); 

  timeunit      1ns;
  timeprecision 1ps;

  import alu_pkg::*;

  logic [`ADDR_W:0] paddr;
  logic [(`APB_BUS_SIZE-1):0] pwdata;
  logic [(`APB_BUS_SIZE-1):0] prdata;
  logic       penable;
  logic       pwrite;
  logic       psel;
  logic       rst_n;
  logic       presetn;
  logic       ready;
  logic       slv_err;

  // You can insert properties and assertions here

  // You can insert code here by setting if_inc_inside_interface in file ral.tpl

endinterface : alu_if

`endif // ALU_IF_SV