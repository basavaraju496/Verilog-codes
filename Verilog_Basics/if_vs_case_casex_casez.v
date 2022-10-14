// Code your design here
// Code your design here
module Control_Constructs(
  output reg [1:0]OutA,OutB,
  input InA,InB,InC,
input Enable);
  
   /// ----------- USING IF-------------------//
  
 /* always@(InA,InB,InC,Enable)begin
    if(Enable) begin
      if(InA==0 & InB==0 & InC==0)  begin OutA=2'b00;OutB=2'b00; end
      if(InA==0 & InB==0 & InC==1)  begin OutA=2'b00;OutB=2'b01; end
      if(InA==0 & InB==1 & InC==0)  begin OutA=2'b00;OutB=2'b10; end
      if(InA==0 & InB==1 & InC==1)  begin OutA=2'b00;OutB=2'b11; end
      if(InA==1 & InB==0 & InC==0)  begin OutA=2'b11;OutB=2'b00; end
      if(InA==1 & InB==0 & InC==1)  begin OutA=2'b11;OutB=2'b01; end
      if(InA==1 & InB==1 & InC==0)  begin OutA=2'b11;OutB=2'b10; end
      if(InA==1 & InB==1 & InC==1)  begin OutA=2'b11;OutB=2'b11; end
          
    end else begin OutA=2'bxx;OutB=2'bxx; end
  end 
  */
  /*
  wire [3:0]Wire;
  assign Wire={Enable,InA,InB,InC};
  
   /// ----------- USING IF-ELSE-------------------//
  
  always@(InA,InB,InC,Enable)begin
    if(Wire===4'b1000)
      begin
      OutA=2'b00;OutB=2'b00;
     // $display("Enable,InA,InB,InC are : %b %b-%b-%b with result:%d ",Enable, InA,InB,InC,OutA,OutB);
    end
    
  else if({Enable,InA,InB,InC}==4'b1001)
      begin
      OutA=2'b00;OutB=2'b01;
   //   $display("Enable,InA,InB,InC are : %b %b-%b-%b with result:%d ",Enable, InA,InB,InC,OutA,OutB);
    end
    
   else if({Enable,InA,InB,InC}==4'b1010)
      begin
      OutA=2'b00;OutB=2'b10;
    //  $display("Enable,InA,InB,InC are : %b %b-%b-%b with result:%d ",Enable, InA,InB,InC,OutA,OutB);
    end
    
    else    if({Enable,InA,InB,InC}==4'b1011)
      begin
      OutA=2'b00;OutB=2'b11;
     // $display("Enable,InA,InB,InC are : %b %b-%b-%b with result:%d ",Enable, InA,InB,InC,OutA,OutB);
    end
    else begin OutA=2'bxx;OutB=2'bxx; end 
    
  end  
  
  */
  
  /// ----------- USING CASE-------------------//
  
  always@(InA,InB,InC)
     begin
       if(!Enable) begin 
          begin OutA=2'bx0;OutB=2'bx0;end
       end 
       else begin
       
      case({InA,InB,InC})
      3'b000: begin OutA=2'b01;OutB=2'b01; end 
      3'b001: begin OutA=2'b00;OutB=2'b01; end 
      3'b010: begin OutA=2'b00;OutB=2'b10; end 
      3'b011: begin OutA=2'b00;OutB=2'b11; end
      3'b100: begin OutA=2'b11;OutB=2'b00; end 
      3'b101: begin OutA=2'b11;OutB=2'b01; end 
      3'b110: begin OutA=2'b11;OutB=2'b10; end 
      3'b111: begin OutA=2'b11;OutB=2'b11; end
      //  3'b10z: begin OutA=2'bxx;OutB=2'b11; end
        //3'b10x: begin OutA=2'bxx;OutB=2'b11; end
        //3'b10?: begin OutA=2'bxx;OutB=2'b11; end
    default: begin OutA=2'bzz;OutB=2'bzz;end 
      
        endcase
         
       end
    
  end
  

endmodule



TESTBENCH



// Code your testbench here
// or browse Examples

// Testbench
module test;

  reg Ain,Bin;
  reg Cin; 
  wire [1:0]S1_out;
  wire [1:0]S2_out;
  reg Enable;
  
  // Instantiate design under test
  Control_Constructs uut(S1_out,S2_out,Ain,Bin,Cin,Enable);
          
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
  end
  
  initial begin
    Ain=0;Bin=0;Cin=0;Enable=0;

    #2 Ain=0;  Bin=0; Cin=0 ; Enable=1;

    #2 Ain=0;Bin=0;Cin=1;Enable=1;

    #2 Ain=0;Bin=1;Cin=0 ;Enable=1;
    
    #2 Ain=0;Bin=1;Cin=1;Enable=1;
;
    #2 Ain=1;Bin=0;Cin=0;Enable=1;

    #2 Ain=1;Bin=0;Cin=1 ;Enable=1;
  
    #2 Ain=1;Bin=1;Cin=0;Enable=1;

    #2 Ain=1;Bin=1;Cin=1;Enable=0;
    
    #2 Ain=1'bz;Bin=1'bz;Cin=1'bz ;Enable=1;
    
    #2 Ain=1'bx;Bin=1'bx;Cin=1'bx ;Enable=1;
   
        #100 $finish;
  end 
  
  initial  $monitor("time : %0t :::: Enable: Ain: Bin:Cin:%0b-%0b-%0b-%0b: ---- S_out:%b C_out:%b",$time,Enable,Ain,Bin,Cin,S1_out,S2_out);
  
/*  task display;
     #2 $display("time : %0t :::: Enable: Ain: Bin:Cin:%0b-%0b-%0b-%0b: ---- S_out:%b C_out:%b",$time,Enable,Ain,Bin,Cin,S_out,C_out);
    
    
    
  endtask */

endmodule



