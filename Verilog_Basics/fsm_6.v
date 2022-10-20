// Code your design here

`define logic0=9;      // taken logic0 as lessthan 10
`define logic1=11;     // taken  logic1 as greater than 10


module led_sequence(input clk_in,reset_in,PIR_in,input [4:0]PS_in,output reg [3:0]led_out,output reg buzzer_out);  // PS_in ip is 0 or 1 PIR_in ip is leesthan or greater or equal to 10
parameter  IDLE=5'b00001, 
            S0=5'b00010, 
             S1=5'b00100,
            S2=5'b01000, 
            S3=5'b10000;
localparam logic0=9,logic1=11;

reg [4:0] present_state, next_state; // present state and next state handling registers to store states
													// sequential memory of the Moore FSM

reg present_PIR_in,next_PIR_in; // P IR sensor ip taken in Dffs
reg [4:0]present_PS_in,next_PS_in; // Photo Sensor ip taken in Dffs

reg present_buzzer,next_buzzer; // buzzer op data storing in Dffs with same dimension

reg [3:0]present_led_out,next_led_out;  // led o/p data storing in Dffs with same dimension


always@(posedge clk_in,negedge reset_in)
begin
 					 if(reset_in==0) begin 
							 present_state <= IDLE;								// when reset_in=0,  the state of the FSM to "IDLE" State
							 {present_led_out,present_buzzer,present_PS_in,present_PIR_in}<=0; 			 // make all ips and ops to zero
							$display(" present_led_out=%d ,present_buzzer=%b ,present_PS_in=%b ,present_PIR_in=%b",present_led_out,present_buzzer,present_PS_in,present_PIR_in);
 							 end
					 else 
						begin
						present_state <= next_state; 
						present_led_out <= next_led_out;
						present_buzzer <=next_buzzer;
						present_PS_in <=next_PS_in;
						present_PIR_in <=next_PIR_in;
						end 
end
// combinational logic of the Moore FSM  to determine next state 

always@(present_state)
begin						
						next_state = present_state;  			// default taken
						next_led_out = present_led_out;
						next_buzzer = present_buzzer;

						next_PS_in = PS_in;                                  // ip taken here 
						next_PIR_in =PIR_in;                                 // ip taken here

			 case(present_state) 
					  IDLE : begin
							next_led_out=4'b0000;
							next_buzzer=1'b0;
							next_state=S0;
						end

 					  S0: begin
							next_led_out=4'b1010;
							next_buzzer=1'b0;
							next_state=stateselector(present_PIR_in,present_PS_in);
						end
 					  S1: begin 
							next_led_out=4'b0101;
							next_buzzer=1'b1;
							next_state=stateselector(present_PIR_in,present_PS_in);
							
						end
 					  S2: begin 
							next_led_out=4'b1100;
							next_buzzer=1'b0;
							next_state=stateselector(present_PIR_in,present_PS_in);
							
						end
 					  S3: begin 
							next_led_out=4'b0011;
							next_buzzer=1'b0;
							next_state=stateselector(present_PIR_in,present_PS_in);
							
						end
 		
					 default: begin 
							next_state = IDLE; 
							next_led_out=4'b0000;
							next_buzzer=1'b0;


						  end
			 endcase
end
				// op logic 
function [4:0]stateselector;
input present_PIR_in;
input [4:0]present_PS_in;
begin
						if((present_PIR_in==0) && (present_PS_in==logic0))
							begin
							stateselector=S0;
							end

						else if((present_PIR_in==0) && (present_PS_in==logic1))
							begin
							stateselector=S1;
							end

						else if((present_PIR_in==1) && (present_PS_in==logic0))
							begin
							stateselector=S2;		
							end

						else if((present_PIR_in==1) && (present_PS_in==logic1))
							begin
							stateselector=S3;	
							end

						else
							begin
							stateselector=IDLE;		
							end

end
endfunction


							//  combinational logic to determine the output of moore FSM op only depend on present state  



always @(present_state)
begin 
						 case(present_state) 
						 IDLE:  begin  led_out = next_led_out; buzzer_out=next_buzzer;    end
 						 S0:    begin  led_out = next_led_out; buzzer_out=next_buzzer;    end
						 S1:    begin  led_out = next_led_out; buzzer_out=next_buzzer;    end
						 S2:    begin  led_out = next_led_out; buzzer_out=next_buzzer;    end
						 S3:   begin  led_out = next_led_out; buzzer_out=next_buzzer;    end

						 default:  led_out =4'b0000;  // buzzer_out=1'b0;  

						 endcase
end 



endmodule
