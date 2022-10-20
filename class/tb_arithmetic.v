// Code your testbench here
module tb_arithmetic;
  reg [1:0]P;
  reg enable_low;
  reg [7:0]A,B;
  wire [15:0]y1,y2,y3,y4;
  arithmetic DUT(y1,y2,y3,y4,A,B,P,enable_low);
  initial begin

    enable_low=0;
    B=8'B10000000;
    A=8'B00000010;
    
    P=2'b00; 
   #5 P=2'b01; 
   #5 P=2'b10; 
   #5 P=2'b11; 
 #5 enable_low=1'b1;
   #5  P=2'b00; 
   #5 P=2'b01; 
   #5 P=2'b10; 
  #10  P=3'b11; 

  end
  initial
    begin
      $monitor($time," input a=%d b=%d  SEL =%b output %b (%d)  %b (%d)  %b (%d)  %b (%d) ",A,B,P,y1,y1,y2,y2,y3,y3,y4,y4);
      
    end
  
endmodule
