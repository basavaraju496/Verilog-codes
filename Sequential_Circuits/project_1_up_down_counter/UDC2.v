module up_down_counter2556(inout [7:0]Din,input clock_i,ncs,nrd,nwr,start_i,reset_i,A0_i,A1_i ,output reg [7:0]c_out,output  err_o,ec_o,dir_o);
/*module UDC(output [7:0] c_out, output dir_o,err_o,ec_o,
					 inout [7:0] d_in, input A0_i,A1_i,
					 input clock_i, reset_i, ncs, nwr, nrd, start_i);*/
	//============ Default registers PLR, ULR, LLR, CCR===============//
	reg [7:0] PRELOAD_REGISTER, UPPER_LIMIT_REGISTER, LOWER_LIMIT_REGISTER, CYCLE_COUNT_REGISTER;
	
	reg [7:0] PLR_next, ULR_next, LLR_next, CCR_next; //next state registers of PLR,LLR,ULR,CCR;

	reg [1:0] start_pulse_count, start_pulse_count_next; //to count start pulse width

	reg direction_reg, direction_next; //for direction

	reg [7:0] c_out_reg, c_out_next; //for counter output

	reg [8:0] cycles_reg, cycles_next=0; //for counting cycles

	reg ec_o_next=0; // to end of count

	reg start_flag=0, start_flag_next=0; //to start the counter

	reg [7:0] temp_din;

	localparam IDLE = 1'd0, COUNT = 1'd1;

	reg state , state_next;
	
	reg [1:0] flag;
	
	reg err_oo;

	always@(posedge clock_i,ncs) begin
		if(ncs==0) begin
		if(reset_i) begin 						//reset conditions of FF's
			PRELOAD_REGISTER <= 8'b0;				//PLR = 0
			UPPER_LIMIT_REGISTER <= 8'hff;	//ULR = 8'hff
			LOWER_LIMIT_REGISTER <= 8'b0;			//LLR = 0
			CYCLE_COUNT_REGISTER <= 8'b0;			//CCR = 0
			start_pulse_count <= 2'b0;				//start pulse count = 0
			direction_reg <= 1'b0;					//direction = 0
			c_out_reg <= 8'b0;						//counter output = 0
			cycles_reg <= 9'b0;						//cycles count = 0
			start_flag <= 1'b0;
			state <= IDLE;
		end
		else begin 													//FF's created for
			PRELOAD_REGISTER <= PLR_next;						// PLR
			UPPER_LIMIT_REGISTER <= ULR_next;				// ULR
			LOWER_LIMIT_REGISTER <= LLR_next;				// LLR
			CYCLE_COUNT_REGISTER <= CCR_next;				// CCR
			start_pulse_count <= start_pulse_count_next;	// start pulse counting
			direction_reg <= direction_next;					// direction 
			c_out_reg <= c_out_next;							// counter output
			cycles_reg <= cycles_next;							// number of cycles
			start_flag <= start_flag_next;
			state <= state_next;
		end
		end
		else begin
			PRELOAD_REGISTER <= PRELOAD_REGISTER;						// PLR
			UPPER_LIMIT_REGISTER <= UPPER_LIMIT_REGISTER;				// ULR
			LOWER_LIMIT_REGISTER <= LOWER_LIMIT_REGISTER;				// LLR
			CYCLE_COUNT_REGISTER <= CYCLE_COUNT_REGISTER;				// CCR
			start_pulse_count <= start_pulse_count;	// start pulse counting
			direction_reg <= direction_reg;					// direction 
			c_out_reg <= c_out_reg;							// counter output
			cycles_reg <= cycles_reg;							// number of cycles
			start_flag <= 1'b0;
			state <= 0;
		end
	end

	assign d_in = (nrd==0 && nwr==1) ? temp_din :8'bz;
	assign err_o = ((PRELOAD_REGISTER>UPPER_LIMIT_REGISTER)|(PRELOAD_REGISTER<LOWER_LIMIT_REGISTER))? 1'b1 : 1'b0;
	wire start_pulse_count_en = ncs|start_flag_next;//ACTIVE LOW enable
	
	always@(*) begin
		PLR_next = PRELOAD_REGISTER;
		ULR_next = UPPER_LIMIT_REGISTER;
		LLR_next = LOWER_LIMIT_REGISTER;
		CCR_next = CYCLE_COUNT_REGISTER;
		start_flag_next = start_flag;
		//cycles_next = cycles_reg;
		c_out_next = c_out_reg;
		state_next = state;
		if(ncs==0)begin
			case(state)
		  		IDLE: 
		  			begin
						if(nwr==0) begin
							case({A1_i,A0_i})
		 						2'b00: PLR_next = d_in;
								2'b01: ULR_next = d_in;
								2'b10: LLR_next = d_in;
								2'b11: CCR_next = d_in;
		  					endcase
						end
						case({(PRELOAD_REGISTER > UPPER_LIMIT_REGISTER),(PRELOAD_REGISTER<LOWER_LIMIT_REGISTER)})
		  					2'b00: err_oo = 0;
							2'b01: err_oo = 1;
							2'b10: err_oo = 1;
							2'b11: err_oo = 1;
							default: err_oo = 1;
						endcase
						ec_o_next=0;
						if(start_i==1'b0 && start_pulse_count==2'b1 && err_oo==1'b0 &&(CYCLE_COUNT_REGISTER!=8'b0)&&ec_o_next==0)
						begin 
							c_out_next=PRELOAD_REGISTER;
							flag=0;
							state_next=COUNT;
							cycles_next=0;	
						end
					end
				COUNT:
					begin
					ec_o_next=0;
						if(flag==0) begin
							if(c_out_reg==UPPER_LIMIT_REGISTER) flag=1;
							else c_out_next = c_out_reg+1;
						end
						if(flag==1) begin
							if(c_out_reg==LOWER_LIMIT_REGISTER) flag=2;
							else c_out_next = c_out_reg-1;
						end
						if(flag==2) begin
							if(c_out_next==PRELOAD_REGISTER) begin
								cycles_next=cycles_reg+1;
								if(cycles_next==CYCLE_COUNT_REGISTER) begin
									ec_o_next=1;
									start_flag_next = 0;
									c_out_next=8'b0;
									state_next = IDLE;
								end
								else if(PRELOAD_REGISTER == UPPER_LIMIT_REGISTER) begin 
									if(PRELOAD_REGISTER == LOWER_LIMIT_REGISTER) begin flag=2; c_out_next = c_out_reg;end
									else begin flag=1; c_out_next = c_out_reg-1; end
								end
								else flag=0;c_out_next = c_out_reg+1;
							end
							else c_out_next=c_out_reg+1;
						end
					end
			endcase

		//---------------------------------------------------//
		//==================== DIRECTION ====================//
		//---------------------------------------------------//
		direction_next = (c_out_next-c_out_reg==1)? 1 : ((c_out_reg-c_out_next==1)? 0 :1'b0);

		//---------------------------------------------------//
		//===================== START PULSE =================//
		//---------------------------------------------------//
		if(start_pulse_count_en == 1'b0) begin //checking wheather the start pluse FF is enable or not
			if(start_i) begin //checking for high signal start
				//combinational circuit to check start signal width either matches
				//with one clock pulse or not
				
				start_pulse_count_next[1] = start_pulse_count[0]|start_pulse_count[1];
				start_pulse_count_next[0] = ~start_pulse_count_next[1];

				//count is 1 if start pulse is given for only one clock period
				//count is 2 if start pulse is given for more than one clock period
				//count is 0 if start is not given
			end
			else start_pulse_count_next = 2'b0; // if start is 0 default next value is zero
		end
		else start_pulse_count_next = 2'b0;
		end
	end

	always@(posedge clock_i) begin
		if(nrd==0 && nwr==1) begin //enable checking
			case({A1_i,A0_i})
		  		2'b00: temp_din = PRELOAD_REGISTER; // PLR
				2'b01: temp_din = UPPER_LIMIT_REGISTER; // ULR 
				2'b10: temp_din = LOWER_LIMIT_REGISTER; // LLR
				2'b11: temp_din = CYCLE_COUNT_REGISTER; // CCR
				default : temp_din = 8'b0000_0000; //default
			endcase
		end
		else temp_din = 8'b0;
	end
	
	//----------------------------------------------------//
	//=================== OUTPUT =========================//
	//----------------------------------------------------//
	assign c_out = c_out_reg;
	assign ec_o = ec_o_next;
	assign dir_o = direction_next;//==8'bx ? 8'bz: direction_next;
endmodule
