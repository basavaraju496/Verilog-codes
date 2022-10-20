module tb_logical;
  reg [7:0]A,B;
  reg [2:0]P; 
  reg el;
integer i;
  wire [7:0]Y;
  logical DUT(A,B,P,el,Y);
  initial begin


    el=0;
	P=3'b000;
    A=8'B10000000;
    B=8'B00000000;
# 5  P=3'b001;
  end
  initial
    begin
      $monitor($time,"P=%b a =%b b= %b y=%b ",P,A,B,Y);
      
    end
  
endmodule
