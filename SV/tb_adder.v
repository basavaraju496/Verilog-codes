// Code your testbench here
// or browse Examples
module adder_tb();
  reg [1:0] input_a_tb,input_b_tb;
  wire [2:0] output_c;
  reg [2:0] check_c;
  reg clk=0;
  
  adder dut_inst(.input_a(input_a_tb),.input_b(input_b_tb),.out_c(output_c),.clk(clk));
  always #5 clk=~clk;
  
  //stimulus input//
  always@(negedge clk)
    begin
      input_a_tb=$random;
      input_b_tb=$random;
      
    end
  
  // checker //
  always@(posedge clk)
    begin
      check_c=input_a_tb+input_b_tb;
    end
  
  //compare//
  always@(negedge clk)
    begin
      if(output_c==check_c)
        $display($time,"output_c=%d is EQUAL to check_c=%d",output_c,check_c);
      else
        $display($time,"output_c=%d is NOT_EQUAL to check_c=%d",output_c,check_c);
      
        
    end
  initial
    begin
      $dumpfile("dump.vcd"); 
      $dumpvars;
    end
  initial
  	begin
      #1000;
      $finish;
    end
endmodule
