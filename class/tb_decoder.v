module tb_decoder4to16;
  reg [3:0]opcode_in;
  reg init_l;
  wire [15:0]d_out;
integer i;
  
  decoder_4x16 DUT(d_out,opcode_in,init_l);

  
  initial begin
    $monitor($time," input opcode %B output data %b %D",opcode_in,d_out,d_out);
		opcode_in = 4'b000;
 init_l=1'b1;
    
for (i=0; i<16; i=i+1) begin
#5 opcode_in=i;
    end
  end
endmodule
