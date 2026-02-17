
module top_th;

  timeunit      1ns;
  timeprecision 1ps;



  //clock and reset declarations
  logic clk = 0;
  logic rst_n;
  
  //clocl
  always #10 clk = ~clk;

 //Reset
   initial begin
    rst_n = 0;
    #75
    rst_n = 1;
  end

  assign alu_if_0.clk    =  clk;
  assign alu_if_0.rst_n = rst_n;

 

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

