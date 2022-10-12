module tb;
  parameter N=16;
  reg [N-1:0]D;
  reg el;
  reg [($clog2(N))-1:0]S;
  wire Y;
  integer i;
  muxnby1 #(N) DUT(Y,el,D,S);
  initial begin
    el=1'b1;
    
    D=16'Habcd;
     
for (i=0; i<N; i=i+1) begin
   #5 S=i;
end
  end
  initial begin
    $monitor("time:%5d,data = %b,s = %b , y = %b",$time,D,S,Y);
end
  endmodule