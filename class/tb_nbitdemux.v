module tb_nbitdemux;
reg [15:0]i;
reg el;
reg [1:0]sel;
wire [15:0]y1,y2,y3,y4;
nbitdemux dut(i,sel,el,y1,y2,y3,y4);

initial 
begin
$monitor($time,"input data = %h, sel=%d output %b %b %b %b ",i,sel,y1,y2,y3,y4);
el=1'b0;
i=16'hffff;
//#5 sel=2'b00;
#5 sel=2'b01;
//#5 sel=2'b10;
//#5 sel=2'b11;
 end
endmodule
