
module top_th;

  timeunit      1ns;
  timeprecision 1ps;


  // You can remove clock and reset below by setting th_generate_clock_and_reset = no in file common.tpl

  // Example clock and reset declarations
  logic clock = 0;
  logic reset;
  // Example clock generator process
  always #10 clock = ~clock;

  // Example reset generator process
   initial begin
    reset = 0;
    #75
    reset = 1;
  end

  assign alu_if_0.pclk    = clock;
  assign alu_if_0.presetn = reset;

  // You can insert code here by setting th_inc_inside_module in file common.tpl

  // Pin-level interfaces connected to DUT
  // You can remove interface instances by setting generate_interface_instance = no in the interface template file

  alu_if  alu_if_0 ();

    alu_top_module dut(
    .pclk     (clock),
    .presetn  (reset),
    .paddr    (alu_if_0.paddr),
    .pwdata   (alu_if_0.pwdata),
    .prdata   (alu_if_0.prdata),
    .penable  (alu_if_0.penable),
    .pwrite   (alu_if_0.pwrite),
    .psel     (alu_if_0.psel),
    .ready    (alu_if_0.ready),
    .slv_err  (alu_if_0.slv_err)
  );

endmodule

