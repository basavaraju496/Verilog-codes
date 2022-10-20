module tb_codeconvertor;
  reg [7:0]B;
  reg el; 
  wire [7:0]Y;
  codeconvertor DUT(Y,B,el);
  initial begin
    el=1'b0;
   #5 B=8'b1010_0000;
   #5 B=8'b1010_0001;
   #5 B=8'b1010_0010;
   #5 B=8'b1010_0011;
  end
  initial
    begin
      $monitor($time," b=%b y=%b  ",B,Y);
    end  
endmodule
