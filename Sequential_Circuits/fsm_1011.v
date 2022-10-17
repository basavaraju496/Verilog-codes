// Verilog project: Verilog code for Sequence Detector using Moore FSM
// The sequence being detected is "1011" 
module Sequence_Detector_1011_MOORE_Verilog(sequence_in,clk_in,reset_in,detector_out);
input clk_in; // clk_in signal
input reset_in; // reset_in input
input sequence_in; // binary input
output reg detector_out; // output of the sequence detector
parameter  IDLE=5'b00001, // "IDLE" State
  GOT1=5'b00010, // "GOT1" State
  GOT10=5'b00100, // "GOT10" State
  GOT101=5'b01000, 
  GOT1011=5'b10000;// "GOT1011" State
reg [4:0] present_state, next_state; // present state and next state
// sequential memory of the Moore FSM
always @(posedge clk_in, posedge reset_in)
begin
 if(reset_in==0) 
 present_state <= IDLE;// when reset_in=1, reset_in the state of the FSM to "IDLE" State
 else
 present_state <= next_state; // otherwise, next state
end 
// combinational logic of the Moore FSM
// to determine next state 
always @(present_state,sequence_in)
begin
 case(present_state) 
 IDLE:begin
  if(sequence_in==1)
   next_state = GOT1;
  else
   next_state = IDLE;
 end
 GOT1:begin
  if(sequence_in==0)
   next_state = GOT10;
  else
   next_state = GOT1;
 end
 GOT10:begin
  if(sequence_in==0)
   next_state = IDLE;
  else
   next_state = GOT101;
 end 
 GOT101:begin
  if(sequence_in==0)
   next_state = GOT10;
  else
   next_state = GOT1011;
 end
 GOT1011:begin
  if(sequence_in==0)
   next_state = GOT10;
  else
   next_state = GOT1;
 end
 default:next_state = IDLE;
 endcase
end
// combinational logic to determine the output
// of the Moore FSM, output only depends on present state
always @(present_state)
begin 
 case(present_state) 
 IDLE:   detector_out = 0;
 GOT1:   detector_out = 0;
 GOT10:  detector_out = 0;
 GOT101:  detector_out = 0;
 GOT1011:  detector_out = 1;
 default:  detector_out = 0;
 endcase
end 
endmodule



TB



module tb_Sequence_Detector_Moore_FSM_Verilog;

 // Inputs
 reg sequence_in;
 reg clock;
 reg reset;

 // Outputs
 wire detector_out;

 // Instantiate the Sequence Detector using Moore FSM
  Sequence_Detector_1011_MOORE_Verilog DUT(sequence_in,clk_in,reset_in,detector_out);

 
 initial begin
 clock = 0;
 forever #5 clock = ~clock;
 end 
 initial begin
  // Initialize Inputs
  sequence_in = 0;
  reset = 1;
  // Wait 100 ns for global reset to finish
  #30;
      reset = 0;
  #40;
  sequence_in = 1;
  #10;
  sequence_in = 0;
  #10;
  sequence_in = 1; 
  #20;
  sequence_in = 0; 
  #20;
  sequence_in = 1; 
  #20;
  sequence_in = 0;  
  // Add stimulus here

 end
      
endmodule
