
module testbench;
    reg a,b,cin;
    wire s,cout;
    integer i;
    FA DUT(a,b,cin,s,cout);
    initial begin
        $dumpfile("test.vcd");
        $dumpvars;

        {a,b,cin}=3'b10;
        for (i=0; i<8; i++) begin
        #6 {a,b,cin}={a,b,cin}+1;
        end
    end
    initial begin
        $monitor("time=%g input a=%b b=%b cin=%b output sum=%b carry=%b",$time,a,b,cin,s,cout);
    end
endmodule
