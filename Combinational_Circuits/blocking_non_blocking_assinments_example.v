// example for non blocking assignment

 module nonblocking();
   integer a = 10, b = 20, c = 30;
   initial begin
     a <= b;
     b <= c;
     c <= a;
   end
   initial begin
     $monitor("non blocking a=%2d,b=%2d,c=%2d",a,b,c);
   end
 endmodule 

 // example for blocking assingnment

module blocking();
  integer a=100,b=200,c=300;
  initial begin
    a=b;
    b=c;
    c=a;
  end
  initial begin 
    $monitor(" blocking a=%d,b=2%d,c=%3d",a,b,c);
  end
endmodule
