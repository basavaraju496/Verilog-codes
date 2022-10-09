
module testbench;
    reg a,b;
    wire s,c;
    integer i;
    ha DUT(a,b,s,c);
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;

        {a,b}=2'b00;
        for (i=0; i<4; i++) begin
        #6 {a,b}={a,b}+1;
        end
    end
    initial begin
        $monitor("time=%g input a=%b b=%b output sum=%b carry=%b",$time,a,b,s,c);
    end
endmodule
