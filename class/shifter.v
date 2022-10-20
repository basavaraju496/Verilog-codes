module shifter(input [7:0]A,B,output reg [7:0]Y, input el,output reg sflag);
wire [7:4]data=B[7:4]; 			// no of times to shift
wire [1:0]select=B[1:0];			 // select which shift to perform
					// $display("data is %d",data);
always@(*)
 begin
			if(el==0)
				 begin
// $display("data =%b %d",data,data);
        //  data=data%8;
//#100 $display("data =%b %d",data,data);

			    case (select)
			        2'b00: begin Y=A<<data;  sflag=1'b1;	$display("left shift");	        end       // left shift
	        		2'b01: begin Y=A>>data;  	sflag=1'b1;   $display("right shift");		end       // right shift
		        	2'b10: begin Y=rotateleft(A,data); sflag=1'b1;   $display("left rotate");	  end       // rotate left
			        2'b11: begin Y=rotateright(A,data); sflag=1'b1;  end       // rotate right
        				default: Y=8'bz;
    			endcase
				end
			else
			begin 
			Y=8'bz;
			end
end
		function [7:0]rotateleft;   // function to rotate left
			input [7:0]A;
			input [3:0]data;
			reg [3:0]w1;
			reg [7:0]temp;
			begin
			temp=A;
				//	data=(data>7)?(data-8):data;
      			data=data%8;
			w1=8-data;

			rotateleft=(A<<data)+(temp>>w1);

			end
			endfunction

						function [7:0]rotateright;   // function to rotate right
							input [7:0]A;
							input [3:0]data;
							reg [3:0]w1;
							reg [7:0]temp;
						begin
						temp=A;
						data=data%8;
//$display("DATA INSIDE FUNCTION %B",data);
						w1=8-data;
						rotateright=(A>>data)+(temp<<w1);
						end
						endfunction

    
endmodule
