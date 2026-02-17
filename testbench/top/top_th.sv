
module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  // You can remove clock and reset below by setting th_generate_clock_and_reset = no in file common.tpl

  // Example clock and reset declarations
  logic clk = 0;
  logic rst_n;
  // Example clock generator process
  always #10 clk = ~clk;

  // Example reset generator process
   initial begin
    rst_n = 0;
    #75
    rst_n = 1;
  end

  assign alu_if_0.clk    =  clk;
  assign alu_if_0.rst_n = rst_n;

  // You can insert code here by setting th_inc_inside_module in file common.tpl

  // Pin-level interfaces connected to DUT
  // You can remove interface instances by setting generate_interface_instance = no in the interface template file

  alu_if  alu_if_0 ();

    alu_top_module dut(
    .clk     (clk),
    .rst_n  (rst_n),
    .addr    (alu_if_0.paddr),
    .wdata   (alu_if_0.pwdata),
    .rdata   (alu_if_0.prdata),
    .en  (alu_if_0.penable),
    .write   (alu_if_0.pwrite),
    .sel     (alu_if_0.psel),
    .ready    (alu_if_0.ready),
    .slv_err  (alu_if_0.slv_err)
  );

endmodule

