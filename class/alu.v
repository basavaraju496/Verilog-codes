`include"decoder.v"
`include"newarith.v"
`include"new_logical.v"
`include"comparator.v"
`include"mux2by1.v"
`include"code_convertor.v"
`include"mux16by1.v"
`include"shifter.v"
module top_alu(input [3:0]Opcode_in,input init,input [7:0]A,regB,output [15:0]alu_out,input ex_sel ); 
reg [7:0]accumulator;

always@(*)
begin
accumulator=A;
end
 // operand-1 accumulator , operand-2 auxilary register regB  
 //
 //
 
//wire [7:0]accumulator;
/*
opcode-operations

0001-Adder
0010-Subtractor
0011-Multiplier
0100Divider

0101-AND
0110-OR
0111-NOT
1000-NANAD
1001-NOR
1010-XOR

1011-Refresh

1100-8 bit Comparator

1101-Shifter

1110-Code Conversion

1110-Status

*/
// module decoder_4x16 (output reg [15:0]d_out,input [3:0]opcode_in,input init_l);   // active low decoder
wire [15:0]M;
wire [15:0]a1,a2,a3,a4;
wire [7:0]l_out,c_out,s_out;
wire sf;
wire [7:0]mux_out,code_out;    
decoder_4x16 opcode_decoder(M,Opcode_in,init);
wire fdone;
reg [7:0]shifter_out;


//assign accumulator=


new_arithmetic arithmeticblock(A,regB,(M[1]&M[2]&M[3]&M[4]),Opcode_in[1:0],a1,a2,a3,a4);


new_logical for_logicalblock(A,regB,(M[5]&M[6]&M[7]&M[8]&M[9]&M[10]),Opcode_in[2:0],l_out);
//reg [7:0]ac;

//module comparator(input [7:0]a,b,input el,output reg zf,cf,ac,gf,lf);
wire zf,cf,gf,lf;

comparator for_comparatorblock(A,regB,M[12],zf,cf,gf,lf);
//initial #100 $display("decoder op %b",M);

always@(zf,cf,gf,lf)
begin
if((zf==1'b1) && (cf==1'b0) )
begin
accumulator=8'b0000_0000;
$display("accumulator is zero %b ",accumulator);
end
else if(gf==1'b1)
accumulator=8'b1000_0000;
else if(lf==1'b1)
begin
accumulator=8'b0000_0001;
$display("accumulator is zero %b ",accumulator);

end
end

wire sflag;
shifter forshifting(accumulator,regB,s_out,M[13],sflag);
always@(sflag)
begin
if(sflag==1'b1)
shifter_out=s_out;
//else
//shifter_out=shifter_out;
$display("shifter out %b dflag %b ",shifter_out,sflag);
end
always@(*) begin
$display("shifter out %b dflag %b ",shifter_out,sflag);
end

mux2by1 selecting_input_for_code_convertor(shifter_out,regB,ex_sel,mux_out);

codeconvertor codeconversion(code_out,fdone,mux_out,M[14]);

mux16by1 foroutput(16'bz,a1,a2,a3,a4,l_out,l_out,l_out,l_out,l_out,l_out,8'bz,accumulator,s_out,code_out,8'bz,Opcode_in[3:0],alu_out,1'b0);

endmodule
