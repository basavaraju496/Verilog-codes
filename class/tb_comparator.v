module tb_comparator;
  reg [7:0]A,B;
  reg el;
  wire [7:0]Y;
  comparator DUT(A,B,el,Y);
  initial begin

    el=0;
    A=8'B10000000;
    B=8'B00000010;
    
    #10     A=8'B10000000;
    #10     B=8'B10000000;
    #10     A=8'B00000000;
    #10     B=8'B10000000;

  end
  initial
    begin
      $monitor($time," a =%d b= %d y=%d %d",A,B,Y[7:4],Y[3:0]);
      
    end
  
endmodule
