module seq110_moore (input clk_in,reset_in,seq_in,output detected_out);
parameter IDLE =4'B0001 , // using one hot coding only one bit is high
 GOT1 = 4'B0010 ,
 GOT11 = 4'B0100 ,
 GOT110=4'B1000;

reg[3:0] present_state,next_state; // state handling registers

// present_state state logic
    always @(posedge clk_in)
      begin
        if(reset_in==0)
        begin
            present_state<=IDLE;
        end
        else
        begin
            present_state<=next_state;
        end
    end
    // next_state state logic
    always @(present_state,seq_in)
      begin
        next_state=present_state;
        case (present_state)
            IDLE:begin next_state=seq_in?GOT1:IDLE; end
            GOT1:begin next_state=seq_in?GOT11:GOT1; end
            GOT11:begin next_state=(seq_in==0)?GOT110:GOT11; end
            GOT110:begin next_state=  seq_in?GOT1:IDLE; end
          default: begin next_state=IDLE; end
        endcase
    end
    // output logic
  assign detected_out=(present_state==GOT110)?1'b1:1'b0;
endmodule


TESTBENCH

// Code your testbench here
// or browse Examples
module tb_fsm_110_mealy;
  reg clk,reset,seq_in;
  wire detected_out;
  integer i;
  seq110_moore DUT( clk,reset,seq_in, detected_out);
  
  initial clk = 0;
  always #2 clk = ~clk;
  
  
  //stimulus and reset
  initial begin
reset=1'b0;
    for (i=0; i<30; i=i+1)
      begin
       #4 seq_in=$random; //120
      end
 #10   reset=1'b1;    //130
    
    for (i=0; i<30; i=i+1)
      begin
       #4 seq_in=$random;    // 250
      end

    
    
  end
  initial #300 $finish;
  
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
  end
 
  
// NOT GETTING OP IN NEXT CLK GETTING INSTANTLY
endmodule
