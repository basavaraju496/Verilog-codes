module ha (
    input a,b,output reg sum,carry
);
always @(a,b) begin
    case ({a,b})
        2'b00: begin sum=0; carry=0; end
        2'b01: begin sum=1; carry=0; end
        2'b10: begin sum=1; carry=0; end
        2'b11: begin sum=0; carry=1; end 
        default: begin sum=1'bx; carry=1'bx; end

    endcase
end
    
endmodule
