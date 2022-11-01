module up_down_counter (input [7:0]Din,input clk_in,ncs_in,nrd_in,nwr_in,start_in,reset_in,A0,A1 ,output reg [7:0]count_out,output reg err_out,ec_out,dir_out);

reg [7:0]Din_wire;  // storing din out value in reg

//assign Din=Din_wire;  // whenever value in din out changes the it iis assigned to din 

localparam IDLE = 5'b00001;                     // one hot encoding
localparam  RUN= 5'b00010;
localparam READ_WRITE_DATA = 5'b00100;
localparam  COUNTER_SETUP = 5'b01000 ;
localparam COUNTING=5'b10000;

reg [4:0]state_present,state_next ;   // state handling registers

reg [7:0]din_present,din_next;   // input data  registers

reg A0_present,A0_next,A1_present,A1_next,ncs_in_present,ncs_in_next,nrd_in_present,nrd_in_next,nwr_in_present,nwr_in_next,start_in_present,start_in_next;    // control ip registers

reg [7:0]plr_present,llr_present,ulr_present,ccr_present,plr_next,llr_next,ulr_next,ccr_next ;

// plr  starting value of counter
// llr lower limit of counter
// ulr upperlimit of counter
// ccr no of times to count

reg [7:0]count_present,count_next;   ///////output count_out register
reg err_present,err_next,ec_present,ec_next,dir_present,dir_next;

// err=1 when plr<llr or plr>ulr
// ec=1 when counter counts all cycles
// dir=1 for upcounting
// dir=0 for downcounting


reg upflag_present,downflag_present,preloadflag_present;
reg upflag_next,downflag_next,preloadflag_next;
// present state logic
always @(posedge clk_in or start_in)
         begin
            if (reset_in==0) // during reset_in 
            begin
                state_present<=IDLE;    // chip not selected initially
                plr_present<=0;                     // preloaded register is 0
                ulr_present<=8'd255;                // upper limit is 255
                llr_present<=0;                     // lower limit register is 0
                ccr_present<=0;                     // cycle count_out register is 0
                ncs_in_present<=1;
                nrd_in_present<=1;
                nwr_in_present<=1;
                din_present<=0;
                count_present<=0;
                err_present<=0;
                ec_present<=0;
                               upflag_present<=0;
                downflag_present<=0;
                preloadflag_present<=0;
                start_in_present<=0;
                
            
            
            end
            else
            begin
                state_present<=state_next;
                plr_present<=plr_next; 
                ulr_present<=ulr_next; 
                llr_present<=llr_next; 
                ccr_present<=ccr_next; 
                din_present<=din_next;
                count_present<=count_next;
                err_present<=err_next;
                ec_present<=ec_next;
                upflag_present=upflag_next;
                downflag_present=upflag_next;
                preloadflag_present=upflag_next;
                start_in_present<=start_in_next;
                dir_present<=dir_next;

            end
    
         end

// next state logic
always@(*)
begin
                state_next=state_present;
                plr_next=plr_present;                     // defaults
                ulr_next=ulr_present; 
                llr_next=llr_present; 
                ccr_next=ccr_present;
                ncs_in_present=ncs_in;                       // taking ips
                nrd_in_present=nrd_in;
                nwr_in_present=nwr_in;
                A0_present=A0;
                A1_present=A1;
                din_present=Din;
                count_next=count_present;
                err_next=err_present;
                ec_next=ec_present;
                              upflag_next= upflag_present;
                downflag_next= downflag_present;
                preloadflag_next= preloadflag_present;
                start_in_present=start_in;
                dir_next<=din_present;


 
            case (state_present)
                IDLE:begin
                    if(ncs_in_present==0)     // chip start_ins work  if ncs_in==0
                    state_next=RUN;
                    else             // chip stopped
                    begin
                        state_next=IDLE;
                    end
                end
                RUN: begin
                    
                    if(nwr_in_present==0)
                    begin
                        case ({A0,A1})
                            2'B00:begin
                                        plr_next=Din;  $display("data loaded into plr register %d",plr_next );
                                  end 
                            2'B01:begin
                                        ulr_next=Din;  $display("data loaded into ulr register %d",ulr_next );
                                  end 
                                  

                            2'B10:begin
                                        llr_next=Din; $display("data loaded into llr register %d",llr_next );
                                  end 
                                  
                            2'B11:begin
                                        ccr_next=Din; $display("data loaded into ccr register %d",ccr_next );
                                  end 
                        endcase
                    end // if end
                    else if(nrd_in_present==0)  // reading data 
                    begin
                        case ({A0,A1})
                            2'B00:begin
                                        Din_wire=plr_present; $display("data loaded into din input %d",plr_present );
                                  end 
                            2'B01:begin
                                        Din_wire=ulr_present; $display("data loaded into din input %d",ulr_present );
                                  end 
                                  

                            2'B10:begin
                                        Din_wire=llr_present; $display("data loaded into din input %d",llr_present );
                                  end 
                                  
                            2'B11:begin
                                        Din_wire=ccr_present; $display("data loaded into din input %d",ccr_present );
                                  end 
                        endcase 
                    end // read data end
                    else begin     // not reading not writing
                    state_next=COUNTING;
                    end

                end // run end

                COUNTER_SETUP: begin
                        

                    if(plr_present<llr_present || plr_present>ulr_present)
                    begin
                        upflag_next=0;
                        downflag_next=0;
                        preloadflag_next=0;
                       err_next=1;
                       start_in_next=IDLE;
                    end
                    else if(start_in_present==1)
                    begin
                        
                        if(ccr_present!=0)
                        begin
                            state_next=COUNTING;
                            	upflag_next=1;
                            dir_next=1;
                            ec_next=0;    // opt
                            count_next=plr_present;


                        end
                        else
                        begin
                            ec_next=1;
                            state_next=IDLE;
                        end


                    end
                    else
                    begin
                        state_next=COUNTER_SETUP;
                    end



                end/// counter setup state end
                COUNTING: begin
                    if(upflag_present==1 && count_present<ulr_present)
                    begin
                            count_next=count_present+1;
                            if(count_present==ulr_present)
                            begin
                                downflag_next=1;
                                upflag_next=0;
                                preloadflag_next=0; // opt
                                dir_next=0;
                            end
                    end
                    else if(downflag_present==1 && count_present>llr_present)
                    begin
                        count_next=count_present-1;
                            if(count_present==llr_present)
                            begin
                                downflag_next=0;
                                upflag_next=0;   // opt
                                preloadflag_next=1;
                                dir_next=1;
                            end

                    end
                    else if(preloadflag_present==1 && count_present<plr_present )
                    begin
                            count_next=count_present+1;
                            if(count_present==plr_present)
                            begin
                                downflag_next=0;
                                upflag_next=0;
                                preloadflag_next=0; 
                                ccr_next=ccr_present-1;
                                dir_next=0; // opt
                                
                            end
                    end
                    else
                    begin
                        state_next=COUNTER_SETUP;
                    end

                    
                end
                default: state_next=IDLE;
            endcase





end




always @(state_present) begin
    case(state_present)

//output [7:0]count_out,output err_out,ec_out,dir_out);
    IDLE:begin
        count_out=count_present;
        err_out=err_present;
        ec_out=ec_present;
        dir_out=dir_present;
    end
    COUNTING:begin
        count_out=count_present;
        err_out=err_present;
        ec_out=ec_present;
        dir_out=dir_present;
    end
    COUNTER_SETUP:begin
        count_out=count_present;
        err_out=err_present;
        ec_out=ec_present;
        dir_out=dir_present;
    end
    RUN:begin
        count_out=count_present;
        err_out=err_present;
        ec_out=ec_present;
        dir_out=dir_present;
    end
    READ_WRITE_DATA:begin
        count_out=count_present;
        err_out=err_present;
        ec_out=ec_present;
        dir_out=dir_present;
    end


    endcase
end




    
endmodule
