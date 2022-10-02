```verilog
Reduction Operators – Verilog Example
The Verilog reduction operators are used to convert vectors to scalars.
They operate on all of the bits in a vector to convert the answer to a single bit.
The logic performed on the bit-vectors behaves the same way that normal AND, NAND, OR, NOR, XOR, and XNOR Gates behave inside of an FPGA.
The code below demonstrates the usage of the Verilog reduction operator.

module reduction_operators ();
 
  reg r_C;
   
  // Initial statement is not synthesizable (test code only)
  initial
    begin
      
      $display($time," AND  Reduction of 4'b1101 is: %b", &4'b1101);
      #5
      $display($time," AND  Reduction of 4'b1111 is: %b", &4'b1111);
      #15
 
      $display($time," NAND Reduction of 4'b1101 is: %b", ~&4'b1101);
      $display($time," NAND Reduction of 4'b1111 is: %b", ~&4'b1111);
 
      $display("OR   Reduction of 4'b1101 is: %b", |4'b1101);
      $display("OR   Reduction of 4'b0000 is: %b", |4'b0000);
       
      $display("NOR  Reduction of 4'b1101 is: %b", ~|4'b1101); 
      $display("NOR  Reduction of 4'b0000 is: %b", ~|4'b0000);
       
      $display("XOR  Reduction of 4'b1101 is: %b EVEN PARITY Generator", ^4'b1101);
      $display("XOR  Reduction of 4'b0000 is: %b EVEN PARITY Generator", ^4'b0000);
       
      $display("XNOR Reduction of 4'b1101 is: %b ODD PARITY Generator", ~^4'b1101);
      $display("XNOR Reduction of 4'b0000 is: %b ODD PARITY Generator$time," , ~^4'b0000);
       
      // A bitwise reduction can be stored in another reg.
      r_C = |4'b0010;
 
      $display("Reduction of 4'b0010 stored into a reg is: %b", r_C);
 
    end
endmodule // reduction_operators

The Verilog bitwise operators are used to perform a bit-by-bit operation on two inputs.
They produce a single output.
They take each bit individually and perform a boolean algebra operation with the other input. 

The bitwise operators above can operate on either scalars (single bit inputs) or vectors (multiple bit inputs). 
If one input is not as long as the other, it will automatically be left-extended with zeros to match the length of the other input.values will be appended based on given values

module bitwise_operators ();
 
  reg r_A = 1'b1;
  reg r_B = 1'b0;
 
  reg [3:0] r_X = 4'b0101;
  reg [3:0] r_Y = 4'b0011;
//     reg [3:0] r_Y = 4'b11;  // 0 is appended
  //   reg [3:0] r_Y = 4'bxx;  // x is appended 
  //   reg [3:0] r_Y = 4'bzz;  // z is appended
  //   reg [3:0] r_Y = 4'bxz;  // x is appended
//   reg [3:0] r_Y = 4'bzx;      // z is appended
//   reg [3:0] r_Y = 4'b?11;      // z is appended
//   reg [3:0] r_Y = 4'bx11;      // x is appended
  
  
  wire [3:0] w_AND_VECTOR, w_OR_VECTOR, w_XOR_VECTOR, w_NOT_VECTOR;
  wire w_AND_SCALAR,w_OR_SCALAR,w_XOR_SCALAR,w_NOT_SCALAR;
   
  assign w_AND_SCALAR = r_A & r_B;
  assign w_OR_SCALAR  = r_A | r_B;
  assign w_XOR_SCALAR = r_A ^ r_B;
  assign w_NOT_SCALAR = ~r_A;
 
  assign w_AND_VECTOR = r_X & r_Y;
  assign w_OR_VECTOR  = r_X | r_Y;
  assign w_XOR_VECTOR = r_X ^ r_Y;
  assign w_NOT_VECTOR = ~r_X;
   
  // Initial statement is not synthesizable (test code only)
  initial
    begin
      #10;
      // Scalar Tests:
      $display("AND of 1 and 0 is %b", w_AND_SCALAR);
      $display("OR  of 1 and 0 is %b", w_OR_SCALAR);
      $display("XOR of 1 and 0 is %b", w_XOR_SCALAR);
      $display("NOT of 1 is %b", w_NOT_SCALAR);
      #10;
      // Vector Tests: (bit by bit comparison)
      $display("AND of %b and %b is %b",r_X,r_Y,w_AND_VECTOR);
      $display("OR  of %b and %b is %b",r_X,r_Y,w_OR_VECTOR);
      $display("XOR of %b and %b is %b",r_X,r_Y,w_XOR_VECTOR);
      $display("NOT of %b is %b",r_X, w_NOT_VECTOR);
    end
endmodule
module des;
  reg 		 data1 [4] ;
  reg 		 data2 [4] ;
  int 		 i, j;
  
  initial begin
    data1[0] = 0;  data2[0] = 0;
    data1[1] = 1;  data2[1] = 1;
    data1[2] = 'x; data2[2] = 'x;
    data1[3] = 'z; data2[3] = 'z;
    
    for (i = 0; i < 4; i += 1) begin
      for (j = 0; j < 4; j += 1) begin
        $display ("data1(%0d) & data2(%0d) = %0d", data1[i], data2[j], data1[i] & data2[j]);
      end
    end
  end
endmodule


Relational operators in Verilog work the same way they work in other programming languages. The list of relational operators is as follows:

  <      Less Than
  <=     Less Than or Equal To
  >      Greater Than
  >=     Greater Than or Equal To
These are used to test two numbers for their relationship. If operands are of unequal length, Verilog will zero-fill the shorter of the two to make them the same length. Make sure you are careful when comparing two different length inputs! The === and !== allow for checking of X and Z values. This can be used in test benches only, as it is not synthesizable.
  
  
  module relational_operators();
 
initial
  begin
    $display("Is 2 <= 3?      %b", 2 <= 3);
    $display("Is 4 > 6?       %b", 4 > 6);
    $display("Is 1010 >= 10?  %b", 4'b1010 >= 10);
    $display("4'hx >= 10?     %b", 4'hX >= 10);
    #5;
  end
   
endmodule
module des;
  reg [7:0]  data1;
  reg [7:0]  data2;
  
  initial begin
    data1 = 45;
    data2 = 9;
    $display ("Result for data1 >= data2 : %0d", data1 >= data2);
    
    data1 = 45;
    data2 = 45;
    $display ("Result for data1 <= data2 : %0d", data1 <= data2); data1 = 9; data2 = 8; $display ("Result for data1 > data2 : %0d", data1 > data2);
    
    data1 = 22;
    data2 = 22;
    $display ("Result for data1 < data2 : %0d", data1 < data2);
    
  end
// endmodule
module des;
  reg [7:0]  data1;
  reg [7:0]  data2;
  
  initial begin
    data1 = 255;
    data2 = 5;
    
    $display ("Add + = %b", data1 + data2);
    $display ("Sub - = %d", data1 - data2);
    $display ("Mul * = %d", data1 * data2);
    $display ("Div / = %d", data1 / data2);
    $display ("Mod %% = %d", data1 % data2);
    $display ("Pow ** = %d", data2 ** 2);
    
  end
// endmodule
module des;
  reg [7:0]  data1;
  reg [7:0]  data2;
  
  initial begin
    data1 = 45;     data2 = 9;    
    $display ("Result for data1(%0d) === data2(%0d) : %0d", data1, data2, data1 === data2);
    data1 = 'b101x; data2 = 'b1011; 
    $display ("Result for data1(%0b) === data2(%0b) : %0d", data1, data2, data1 === data2);
    data1 = 'b101x; data2 = 'b101x; 
    $display ("Result for data1(%0b) === data2(%0b) : %0d", data1, data2, data1 === data2);
    data1 = 'b101z; data2 = 'b1z00;
    $display ("Result for data1(%0b) !== data2(%0b) : %0d", data1, data2, data1 !== data2);
    data1 = 39;     data2 = 39;   
    $display ("Result for data1(%0d) == data2(%0d) : %0d", data1, data2, data1 == data2);
    data1 = 14;     data2 = 14;   
    $display ("Result for data1(%0d) != data2(%0d) : %0d", data1, data2, data1 != data2);  
  end
endmodule

module des;
  reg [7:0]  data1;
  reg [7:0]  data2;
  
  initial begin
    data1 = 45;     data2 = 9; 
    $display ("Result of data1(%0d) && data2(%0d) : %0d", data1, data2, data1 && data2);
    data1 = 0;      data2 = 4;
    $display ("Result of data1(%0d) && data2(%0d) : %0d", data1, data2, data1 && data2);
    data1 = 'dx;    data2 = 3;
    $display ("Result of data1(%0d) && data2(%0d) : %0d", data1, data2, data1 && data2);
    data1 = 'b101z; data2 = 5;
    $display ("Result of data1(%0d) && data2(%0d) : %0d", data1, data2, data1 && data2);
    data1 = 45;     data2 = 9;
    $display ("Result of data1(%0d) || data2(%0d) : %0d", data1, data2, data1 || data2);
    data1 = 0;      data2 = 4; 
    $display ("Result of data1(%0d) || data2(%0d) : %0d", data1, data2, data1 || data2);
    data1 = 'dx;    data2 = 3;
    $display ("Result of data1(%0d) || data2(%0d) : %0d", data1, data2, data1 || data2);
    data1 = 'b101z; data2 = 5;
    $display ("Result of data1(%0d) || data2(%0d) : %0d", data1, data2, data1 || data2);
    data1 = 4;            
    $display ("Result of !data1(%0d) : %0d", data1, !data1);
    data1 = 0;            
    $display ("Result of !data1(%0d) : %0d", data1, !data1);    
  end
endmodule

module des;
  reg [7:0] data;
  int       i;
  
  initial begin
    data = 8'h1;
    $display ("Original data = 'd%0d or 'b%0b", data, data);
    for (i = 0; i < 8; i +=1 ) begin
      $display ("data << %0d = 'b%b  %d", i, data << i,data << i);
    end
    
    data = 8'h80;
    $display ("Original data = 'd%0d or 'b%0b", data, data);
    for (i = 0; i < 8; i +=1 ) begin $display ("data >> %0d = 'b%b %h", i, data >> i,data >> i);
    end
    
    data = 8'h1;
    $display ("
data >> 1 = 'b%b", data >> 1);
  end
endmodule



```