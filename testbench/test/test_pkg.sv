`ifndef TEST_PKG_SV
`define TEST_PKG_SV

package test_pkg;

  `include "uvm_macros.svh"

  import uvm_pkg::*;

  import alu_pkg::*;
  import env_pkg::*;

  `include "base_test.sv"
  `include "random_test.sv"
  `include "write_only_test.sv"
  `include "read_only_test.sv"
endpackage : test_pkg

`endif 

