module Sequence_Detector_11010_Mealy(input clk_in,reset_in,sequence_in,output detector_out); 
parameter  IDLE=3'd1, 
            GOT1=3'd2, 
             GOT11=3'd3,
            GOT110=3'd4, 
            GOT1101=3'd5,
            GOT11010=3'd6;
reg [2:0] present_state, next_state; // present state and next state
// sequential memory of the Moore FSM
reg dout_next,dout_present; // output handling DFF
always @(posedge clk_in, posedge reset_in)
begin
  if(reset_in==0) begin 
 present_state <= IDLE;// when reset_in=0, reset_in the state of the FSM to "IDLE" State
    dout_present<=1'b0; end
 else begin
 present_state <= next_state; // otherwise, next state
dout_present<=dout_next;
 end
end 
// combinational logic of the Moore FSM
// to determine next state 
always @(present_state,sequence_in)
begin
    {next_state,dout_next}={present_state,dout_present};
 case(present_state) 
   IDLE :begin ({next_state,dout_next})=(sequence_in==1'b1)?({GOT1,dout_next=1'b0}):({IDLE,dout_next=1'b0}); end
   GOT1:begin{next_state,dout_next}=(sequence_in==1'b1)?{GOT11,dout_next=1'b0}:{IDLE,dout_next=1'b0};end
   GOT11:begin{next_state,dout_next}=(sequence_in==1'b0)?{GOT10,dout_next=1'b0}:{GOT11,dout_next=1'b0};end
   GOT110:begin{next_state,dout_next}=(sequence_in==1'b1)?{GOT1101,dout_next=1'b0}:{IDLE,dout_next=1'b0};end
   GOT1101:begin{next_state,dout_next}=(sequence_in==1'b0)?{IDLE,dout_next=1'b1}:{GOT11,dout_next=1'b0};end
   //GOT11010:{next_state,dout_next}=(sequence_in==1'b1)?{GOT1,dout_next=1'b1}:IDLE;
   default:begin{next_state,dout_next} = {IDLE,dout_next=1'b0}; end
 endcase
end
// combinational logic to determine the output
// of the Moore FSM, output only depends on present state
/*  always @(present_state)
begin 
 case(present_state) 
 IDLE:   dout_next = 1'b0;
 GOT1:   dout_next = 1'b0;
 GOT11:   dout_next = 1'b0;
 GOT110:  dout_next = 1'b0;
 GOT1101:  dout_next = 1'b0;
 GOT11010:  dout_next = 1'b1;
 default:  dout_next = 1'b0;
 endcase
end */
// op logic 

assign detector_out=dout_present;



endmodule
