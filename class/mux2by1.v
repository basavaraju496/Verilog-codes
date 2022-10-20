module mux2by1(input [7:0]sa,eb,input s,output reg [7:0]y);

//assign y=s?sa:eb;
always@(*)
begin
case(s)
1'b0: y=eb;
1'b1: y=sa;
endcase
end
endmodule
