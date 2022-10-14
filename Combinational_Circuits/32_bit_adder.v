// Code your design here
module adder32bit(input [31:0]A,B,output [31:0]sum,output carry);
  assign {carry,sum}=(A+B);
  endmodule


// Code your testbench here
// or browse Examples
module tb;
  reg [31:0]A,B;
  wire [32:0]sum;
  wire carry; 
  adder32bit DUT(A,B,sum,carry);
 initial begin
   A=32'd0001; B=32'd4294967295;
   #5    A=32'd0000; B=32'd0001;
 end
   initial begin
     $monitor($time," a %b is b is %b sum is %b carry is %b ",A,B,sum[31:0],carry);
   end
  endmodule
  
  
