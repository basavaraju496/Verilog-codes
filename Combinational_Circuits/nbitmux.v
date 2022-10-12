module muxnby1 #(parameter SIZE=2)(output reg Y,input el, input [SIZE-1:0]D,input [($clog2(SIZE))-1:0]S);

  always@(D,S,el) begin
    Y=el?Y:D[S];
end
endmodule