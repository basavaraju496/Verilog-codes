module nby1mux #(parameter N=8) (input [N-1:0]D ,input [($clog2(N))-1:0]sel,input el,output reg Y);

always@(*)
begin
if(el==0) begin
Y=D[sel];
$display("selection is  = %b",sel);
end
else
Y=1'bz;
end

endmodule
