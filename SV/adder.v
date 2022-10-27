// Code your design here
module adder(input_a,input_b,out_c,clk);
  input [1:0] input_a,input_b;
  input clk;
  output reg [2:0] out_c;
  
  //always@(input_a,input_b)
  always@(posedge clk)
    begin
      out_c=input_a+input_b;
    end
  
endmodule
