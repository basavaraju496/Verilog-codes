module test;
reg [3:0]b;
    initial begin
    b=4'd15;
b=b%8;
        $display ("b sliced =%b",b);
        $finish;
    end
endmodule
