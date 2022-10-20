module tb_110;
reg reset,clk,enable,datain;
wire detected_out;


fsm_moore_110 DUT(reset,enable,clk,datain,detected_out);


initial
begin
 $monitor($time," enable=%b reset=%b clk=%b datain=%b detected_out=%b ",enable,reset,clk,datain,detected_out);
end


initial 
begin 
clk=1'b0;
enable=1'b0;
reset=1'b0;
datain=1'b0;
#5 reset=1'b1;
// datain=1'b1; 


end
always @(posedge clk) datain=$random; 
 

always #4 clk=~clk;

initial #200 $finish;

endmodule
