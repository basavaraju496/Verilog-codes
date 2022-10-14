// Code your design here
module Full_Subtractor_3(output D, b0, input A, B, bi);
  assign D = A^B^bi;
  assign b0 = ((~A)&B|(B&bi)|((~A)&bi));
endmodule
  


// Code your testbench here
// or browse Examples
module tb_Full_Subtractor_3;
  reg A,B,bi;
  wire D,b0;
  Full_Subtractor_3 DUT(D,b0,A,B,bi);
  initial begin 
    A=1'b0; B=1'b0; bi=1'b0;
    #5 A=1'b0; B=1'b0; bi=1'b1;
    #5 A=1'b0; B=1'b1; bi=1'b0;
    #5 A=1'b0; B=1'b1; bi=1'b1;
    #5 A=1'b1; B=1'b0; bi=1'b0;
    #5 A=1'b1; B=1'b0; bi=1'b1;
    #5 A=1'b1; B=1'b1; bi=1'b0;
    #5 A=1'b1; B=1'b1; bi=1'b1;
    #5 A=1'b0; B=1'b0; bi=1'bx;
    #5 A=1'b0; B=1'b0; bi=1'bz;
  end
  initial  begin
    $monitor("for A=%b B=%b cin=%b  difffernce = %b borrow= %b",A,B,bi,D,b0 );
  end
endmodule
