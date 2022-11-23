module tb;


`ifdef THEORY

/*Array is collection of variables, all of same type, and accessed using the
same name plus one or more indices
Arrays are indexed from left bound to right bound
*/
Syntax: <data_type > <vector_width> <name> <dimension>
Example:
//reg [7:0] arr [1:256];
//wire [7:0] arr [256]


wire num [0:1023];          // a 1-dimensional unpacked array of 1024 1-bit nets

reg [7:0] LUT [0:255];      // a 1-dimensional unpacked array of 256 locations of data width 8
reg [7:0] LUT [3:0][0:255]; //4 X 256 locations,each of data width 8


	********ARRAYS in System verilog**********

	PACKED ARRAYS 

System Verilog uses the term "packed array" to refer to the dimensions declared before the object name

bit [7:0] c1;   // c1 is a 8 bit variable
bit [3:0] [7:0] bytes;  // packed array- 4 elements ,each of width 8bit

....Packed arrays can only be made of the single bit types 
....(bit, logic, reg, wire and the other net types) .


// All will be in one row only  

....It can access whole array or slice as a vector or only a bit.
....Integer types with predefined widths cannot have packed array declared. These
....types are: byte, shortint, int, longint and integer.
....An integer type with a predefined width can be treated as a single dimension packed
....array. These types shall be numbered down to 0.
....byte c2; // same as bit [7:0] c2;
....integer i1; // same as logic signed [31:0] i1;
Packed arrays to model:

• Vectors where it is useful to access sub-fields 
logic [39:0][15:0] packet; // 40 location each
packet = input_stream; // assign to all words assign data = select? mem[address]: ‘z;
data = packet[24]; // select the 16-bit of 24 th
location
tag = packet[3][7:0]; // select the 8-bit of 3rd
location


//===================Packed Array Initialization==================//
logic [3:0][7:0] a = 32’h0;
// vector assignment
logic [3:0][7:0] b = {16’hz,16’h0}; // concatenate operator
logic [3:0][7:0] c = {16{2’b01}}; // replicate operator



UNPACKED ARRAYS 

The term "unpacked array" is used to refer to the dimensions declared after the object name.
bit [7:0] b_unpack [3:0]; // unpacked array





Unpacked arrays to model:
• Arrays where typically one element at a time
of the vector is accessed, such as with RAMs and ROM
Example: Example:
of 16-bit module ROM (...);
byte mem [0:4095]; //unpacked array of bytes

//==================Unpacked array initialization===================//
int d [0:1][0:3] =’{ ’{7,3,0,5}, ’{2,0,1,6} };
// d[0][0] = 7
// d[0][1] = 3
// d[0][2] = 0
// d[0][3] = 5
// d[1][0] = 2
// d[1][1] = 0
// d[1][2] = 1
// d[1][3] = 6

Assigning Values to Unpacked Arrays
Specifying a default value to the unpacked array
• System Verilog provides a mechanism to initialize all the elements of an unpacked
array or a slice of an unpacked array, by specifying a default value.
• The value assigned to the array must be compatible with the type of the array. A value
is compatible if it can be cast to that type i.e., assigning the packed to unpacked.
integer a1 [0:7][0:1023] = ’{default : 8’h55};
•
We can also assign values to individual elements or slice or part of the array.
Example :
byte a [0:3][0:3];
a[1][0] = 8’h5; // assign to one element
a = ’{’{0,1,2,3}, ’{4,5,6,7}, ’{7,6,5,4},’{3,2,1,0}}; // assign a list of
values to the full array
a[3] = ’{’hF, ’hA, ’hC, ’hE}; // assign list of values to slice of the array

`endif



`ifdef BASICS


  // Populating arrays using array literals
  logic [3:0] example1 [4] = '{ 4'h1, 4'h2, 4'h3, 4'h4 };
  logic [3:0] example2 [4] = '{ 4{ 4'h0 } };
  logic [3:0] example3 [4] = '{ default : 4'h1 };

  // Create 2D array and assign it using literals
  logic [7:0] example_multi [2][4] = '{ '{4{8'hFF}}, '{default : 8'h0}};

  initial begin//{
    // Show the content of each array
    foreach(example1[i]) begin
	//	example1[i]=0;
      $display("example1[%0d] = %0b", i, example1[i]);
    end
    foreach(example2[i]) begin
//	example2[i]=$random;
      $display("example2[%0d] = %0b", i, example2[i]);
    end
    foreach(example3[i]) begin
//	example3[i]=1;
      $display("example3[%0d] = %0b", i, example3[i]);
    end

	    // Loop through and display the array contents
    foreach(example_multi[i,j]) begin
      $display("example_multi[%0d, %0d] = %0b", i, j, example_multi[i][j]);
    end

  end//}
/*
   
	// New SystemVerilog array declaration method
	logic [3:0] example [16];
	// Verilog style array declaration method
	logic [3:0] example [15:0];



1
	// Array declaration using newer SystemVerilog syntax
2
	logic [7:0] example [2][4];
3
	// Array declaration using the older verilog syntax
4
	logic [7:0] example [1:0][3:0];



	// Create an array to loop over

	logic [3:0] example [8];
	// Loop to access every element in the array
	for (int i =0; i < $size(example); i++) begin
	  // Use the loop variable to access an element
	  example[i];
	end
   In all of the examples which we have considered so far, we have used unpacked arrays.

This means that each of the elements in the array is stored in a different memory location during simulation.*/








`endif




















`ifdef Q1

/*1.reg[1:0] array_s[0:10][0:256];
Using foreach
a. Initialize the above array with positive random values
b. Display all the locations contents*/

reg [1:0] array_s[0:10] [0:256];

// data width=2  11 x 257 locations 



initial 
begin
	   foreach(array_s[i,j])
		begin
				array_s[i][j]=$urandom;
				$display("values in array are array_s[%0d][%0d]=%b",i,j,array_s[i][j]);
		end
	
end







`endif





`ifdef Q2
//reg[7:0] var1[0:10];

reg[7:0] var1[1:10];
initial
begin
var1[0] = 'd10;  // it is not present in array so no use to keep it

var1[1][4:0] ='d31; //  	# var1[1]=xxx11111

//var1[2:10] ='d42;  if we keep like this then we are assigning 42 to all data which is not possible

var1[2:10] = '{9{'d42} };  
var1[2] ='d4;  // # var1[2]=00000100
		foreach(var1[i])
			$display("var1[%0d]=%b",i,var1[i]);

end


`endif


`ifdef Q3
//shortreal mem [7:0][0:3];
//int mem[7:0][0:3];
reg [31:0] mem[7:0][0:3];

initial
begin
mem[0][0]='d40;
//mem[1][0:2]='d52; Cannot assign a packed type 'bit[31:0]' to 52 to all the locations in 
mem[1][0:2]='{3{52}};  // if we assign values in 3 locations it will accept
//mem[1][0:2]='{10.2,10,10};
//mem[1][0:2]={10.2,10,10};


//mem[1][0:2]={10,10,10000}; // same as previous 
//mem[1][3][5:0]='b11110;

		foreach(mem[i,j]) $display("mem[%0d %0d]=%b",i,j,mem[i][j]);
end
`endif



`ifdef Q4

bit[3:0][7:0] var1;
bit[7:0]var2[1:0];//='{2{8'h3}};


initial
begin//{
//var1=10;  // written in 0th location  at last 
//var1[1]=20; // written at index 1


//var1[3:0]='{4,5,6,7};

var1[3:0]='{4{7}};



/*var2[0]='10;
*/
/*
** Error: (vlog-13069) A_22_11_22.sv(302): near "0": syntax error, unexpected INTEGER NUMBER, expecting ';'.
//var2[0]='d10; */
//var2[0]='b1010;  // working

// if we use ' then it will take the four values otherwise it will take 1

var2[1:0]={0,0};

$display("var2=%p",var2);

$display("var1=%p",var1);
		foreach(var1[i]) var1[i]+=10;
		//foreach(var1[i]) $display("var1[%0d]=%0d",i,var1[i]);
		foreach(var2[i]) var2[i]+=10;
		//foreach(var2[j]) $display("var2[%0d]=%0d",j,var2[j]);

$display("var2=%p",var2);

$display("var1=%p",var1);




end//}




`endif


`ifdef Q5a
bit[2:0][7:0] var1,var2; // 8 bit data width 3 contigous locations 
bit[2:0][7:0] sum;   // packed array
initial begin
//var1='{0,0,0};    
//var2='{0,0,0};

/*# var2='{0, 0, 0}
# var1='{0, 0, 0}
//  */

//var1='{10.2,10,10};  
//var1={10.2,10,10};  

var2='{'d10,'d10,'d10};
var1='{10.2,10,10};  





$display("var2=%p",var2);

$display("var1=%p",var1);

		foreach(sum[i])
			begin
				sum[i]=var1[i]+var2[i];
			end
		foreach(sum[i])
			begin
				$display("sum[%0d]=%0d",i,sum[i]);
			end

$display("summ array=%p",sum);



end




`endif




`ifdef Q5b

bit[7:0] var1[3:0],var2[3:0]; // data width = 8 and 4 vertical locations
bit[7:0]sum[3:0];
initial begin
//var1='{8'b11,8'b10,8'b11,8'b00};
//var2='{8'b11,8'b10,8'b11,8'b00};
var1='{10,20,30,40};
var2='{40,30,20,10};
//var1[1:0]={10,20};

//var1[1][3:0]=7;


//var1[3:2][3:0]='{'d1,'d2,'d3};
		foreach(sum[i])
			begin
				sum[i]=var1[i]+var2[i];
			end
		foreach(sum[i])
			begin
				$display("sum[%0d]=%0d",i,sum[i]);
			end
$display("var2=%p",var2);

$display("var1=%p",var1);

$display("summ array=%p",sum);



end


`endif

`ifdef Q6
reg[31:0]array[7:0]='{32'hffff,32'd10,32'o10,32'b1010,96,97,98,99};


//====================ERROR================//
//reg[31:0]array[7:0]='{32'hffff,32'd10,32'o10,32'b1010,97,98,99};
/*Error (suppressible): Illegal assignment pattern. The number of elements (7) doesn't match with the type's width (8). UNPACKED ARRAY

*/

initial begin
		$display("array=%p",array);
end

`endif


`ifdef Q7

/*7.reg[31:0]array[7:0];
Initialize the above array with 5,10, 2, 8, 12, 50, 80. Store the >10 value elemets into another array.
Do it in the simplest way.*/

reg[31:0]array[7:0];   // data with=32 bit // depth=8 unpacked array
reg[31:0]array2[7:0];

int j;

initial begin//{
array='{'d5,'d10, 'd2, 'd8, 'd12, 'd50,'d80,0};

foreach(array[i])
			begin//{
			if(array[i]>10)
					begin//{
							array2[j]=array[i]; 
							j=j+1;
/*
# array1='{5, 10, 2, 8, 12, 50, 80, 0}
# array2='{x, x, x, x, x, 80, 50, 12}
*/


					end//}

end//}
$display("array1=%p",array);

$display("array2=%p",array2);

end
`endif

`ifdef Q8ab

//dynamic array declaration a. Initialize the dynamic array of size 20 elements with random values between 20 and 60.
/*Find out the indexes of the elements whose value is <50. Display those indexes.
b. Change the above dynamic array size to 30 elements and retain the old values.*/



// dynamic arrays  
bit [7:0] dynamic_array1[];
int dynamic_array2[];

int value;

initial
	begin
		dynamic_array1=new[20]; // stores the  datawidth=8 and 20 locations 
    $display("values before writing dynamic_array1=%p",dynamic_array1);  // initialy values are zero
foreach(dynamic_array1[i])
		begin
			dynamic_array1[i]=$urandom_range(20,60);
		end
    $display("values after  writing dynamic_array1=%p",dynamic_array1);  

//find index with value>50

	dynamic_array2=dynamic_array1.find_index with (value<50);

    $display("values after  writing dynamic_array1=%p",dynamic_array2);  // initialy values are zero
///   8b
	dynamic_array1=new[30](dynamic_array1);

    $display("values after  resetting dynamic_array1=%p",dynamic_array1);  

	end

`endif



`ifdef Q9a

//Take an array which should store the student names with respect to total marks



int students_associative_array [ string ];



string qi[$];

initial begin


students_associative_array["Sai"]=90;
students_associative_array["Paul"]=70;
students_associative_array["Rao"]=79;
students_associative_array["Krish"]=75;
students_associative_array["Raone"]=95;

$display("students_associative_array=%p",students_associative_array);

end
/*b. After 10 time units check the name Krish is existed or not. If not then only store it as an element
in the arrray otherwise modify the exisited element value by +10.*/

initial begin

#10

if(students_associative_array.exists("Krish")) // returns 1 or 0
begin

$display("Krishna is exists");
students_associative_array["Krish"]=students_associative_array["Krish"]+ 10;
$display("krishna marks ar added by 10  ",students_associative_array["Krishna"]);
end
else
begin

$display("Krishna is not exists");
students_associative_array["Krish"]=75;

end

$display("students_associative_array=%p",students_associative_array);



end


initial begin 

#15


	qi=students_associative_array.find_index with (item<80);  // use item only other names not working
	$display("students marks less than the 80 are %p",qi);


end










`endif




`ifdef Q10
/*10.
Declare an array with the below indexes and values can be random.
a.indexes 1stloc, 2ndloc, 3rdloc. Print the size of array.
b.indexes 100,200,5,40. Print the size of array.*/

int associative_array_10 [ string ];

int associative_array_10b [ int ];



initial begin


associative_array_10["1stloc"]=$urandom_range(0,10);
associative_array_10["2ndloc"]=$random;
associative_array_10["3rdloc"]=$random;

$display("arr[%s]=%0b,\t %0d","3rdloc",associative_array_10["3rdloc"],32'b1100_0000_1000_1001_0101_1110_1000_0001);

$display( "------------------%0d entries---------------------------\n", associative_array_10.num );

$display("associative_array10a=%p",associative_array_10);
	
associative_array_10b[100]=$urandom;
associative_array_10b[200]=$urandom;
associative_array_10b[5]=$urandom;
associative_array_10b[40]=$urandom;



$display( "------------------%0d entries---------------------------\n", associative_array_10b.num );




$display("associative_array10a=%p",associative_array_10b);

end


`endif





`ifdef Q11
/*
11.Take an array with 20 students names and marks.
a.Then delete the students who got marks >90.
b.Find out how many students got marks <=90. Print the students names who got marks
<=90.*/

int dv05[ string ];


int count;
string marks_gt_90_queue[$];

string marks_lte_90_queue[$];

initial begin
  





               dv05["student1"]=$urandom_range(80,100);
              dv05["student2"]=$urandom_range(80,100);
              dv05["student3"]=$urandom_range(80,100);
              dv05["student4"]=$urandom_range(80,100);
              dv05["student5"]=$urandom_range(80,100);
              dv05["student6"]=$urandom_range(80,100);
              dv05["student7"]=$urandom_range(80,100);
              dv05["student8"]=$urandom_range(80,100);
              dv05["student9"]=$urandom_range(80,100);
              dv05["student10"]=$urandom_range(80,100);
              dv05["student11"]=$urandom_range(80,100);
              dv05["student12"]=$urandom_range(80,100);
              dv05["student13"]=$urandom_range(80,100);
              dv05["student14"]=$urandom_range(80,100);
              dv05["student15"]=$urandom_range(80,100);
              dv05["student16"]=$urandom_range(80,100);
              dv05["student17"]=$urandom_range(80,100);
              dv05["student18"]=$urandom_range(80,100);
              dv05["student19"]=$urandom_range(80,100);
              dv05["student20"]=$urandom_range(80,100);


				$display("dv05 array =%p ",dv05);


$display( "------before deletion---------%0d entries---------------------------\n", dv05.num );

//marks_gt_90_queue=dv05.find_index with (item>90);  // use item only other names not working

//$display("dv05 queue with marks >90 =%p ",marks_gt_90_queue);

//$display( "------------------%0d entries---------------------------\n", marks_gt_90_queue.size );



foreach(dv05[i])
		begin
			if(dv05[i]>90)
				begin
					$display("~~~~~~~~~~~~~~~~~~~deleting %s %0d~~~~~~~~~~~~~~~~~~~~~~~~~~",i,dv05[i]);
					dv05.delete(i);   //i is the index
				end
				else
					begin
							$display("~~~~~~~~~~~~~~~~~~not deleting %s \t %0d~~~~~~~~~~~~~~~~~~~~~~~",i,dv05[i]);
							count++;

					end
		end
		$display("number of students got lessthan 90 are %0d ",count);

				$display("dv05 array =%p ",dv05);

$display( "-------entries after deletion-------%0d entries---------------------------\n", dv05.num );







/*
marks_lte_90_queue=dv05.find_index with (item<=90);  // use item only other names not working


$display("dv05 queue with marks <=90 =%p ",marks_lte_90_queue);

$display( "------------------%0d entries---------------------------\n", marks_lte_90_queue.size );

*/




end


`endif



`ifdef Q12

/*Declare an array with positive and negative indexes. Find out what are the first and last elements.*/



int associative_array_12 [ byte ];

byte index_storage;
// stores index 

initial  begin


associative_array_12[$random]=0;
associative_array_12[$random]=1;
associative_array_12[$random]=2;
associative_array_12[$random]=3;

foreach(associative_array_12[i])
		begin
			$display("\tassociative_array_12[%0d]=%0d",i,associative_array_12[i]);
		end

  $display( "-------````````entries=%0d---------------------------\n", associative_array_12.num );

associative_array_12.first(index_storage);

$display("FIRST ELEMENT %0d ",associative_array_12[index_storage]);

associative_array_12.last(index_storage);

$display("LAST ELEMENT %0d ",associative_array_12[index_storage]);




end





`endif

`ifdef Q13
/*13. array={“RAMA”:10, “RAJU”:20, “KING”:30, “KIND”:5};
Find out the first, next, last elements and how it got stored.*/


int  array[string];

string  index_storage;


initial begin


array["RAMA"]=10;
array["RAJU"]=20;
array["KING"]=30;
array["KIND"]=5;


foreach(array[i])
$display("array[%s]=%0d",i,array[i]);

/*
# ** Warning: A_22_11_22.sv(813): (vopt-2240) Treating stand-alone use of function 'last' as an implicit VOID cast.
*/

array.first(index_storage);
$display("FIRST ELEMENT array[%s]=%0d ",index_storage,array[index_storage]);


array.last(index_storage);

$display("LAST ELEMENT array[%s]=%0d ",index_storage,array[index_storage]);

$display("%p",array);

/*# '{"KIND":5, "KING":30, "RAJU":20, "RAMA":10 }*/



end




`endif


`ifdef Q14
/*
a. int array1[int]={1:10,0:30};
Add index 2 with value 5 and then print the array.
b. int q1[$]={1,10,20};
Insert an element 5 in between 1,10 in the queue.*/


int array1[int]={1:10,0:30};

int q1[$]={1,10,20};

initial
				begin
				$display("array before %p",array1);
				array1[2]=5;
				$display("array after %p",array1);
				end
initial
				begin
					#10
				$display("queuue before insertion %p",q1);

					q1.insert(1,5);
				$display("queueu after insertion %p",q1);
				end


`endif



`ifdef Q15

/*15.
a.q1={10,40,5,100,20};
Delete the elements whose value is >20.(Get the indexes and deletes those indexes)
b. Declare a queue and initialize with random values between 0 to 50.
Delete the elements whose value is >20.(Get the indexes and deletes those indexes)*/


int dma[]={10,40,5,100,20};  // dynamic array  deletes all elements index based deletion is not present

//int q1[$]={10,40,5,100,20};   // queue

int q2[$];   // queue2

initial
				begin
				$display("dynamic array before deletion=%p ",dma);
				foreach(dma[i]) begin
						if(dma[i]>20)
							dma.delete(i);
				end

				$display("dynamic array  after deletion=%p ",dma);


				repeat(10)
						begin
								q2.push_front($urandom_range(0,50));
						end

				$display("queue2 before deletion=%p ",q2);

				foreach(q2[i]) begin
						if(q2[i]>20)
							q2.delete(i);
				end
				$display("queue after deletion=%p ",q2);






end


`endif




`ifdef Q16

/*16.
q1={10,5,20};
a.Put 3 other values at front.
b.Put 4 other values at back.
c.Arrange all items in ascending order.
d. Delete last 4 elements.
e. Keep any 10 new elements at front one after other*/


int q2[$]={10,5,20};


initial  begin

				$display("==================16.a================================");
				$display("queue before addition=%p ",q2);
				repeat(3)
						begin
								q2.push_front($urandom_range(20,30));    // q1={1,2,3};
						end

				$display("queue  after 3 values addition at front =%p ",q2);
				
				$display("==================16.b================================");

				repeat(4) 
						begin
								q2.push_back($urandom_range(40,50));         
						end
				$display("queue  after 4 values addition at back =%p ",q2);


				$display("===================16.c================================");

											q2.sort;
				$display("queue  after sorting low to high =%p ",q2);




				$display("===================16.c.part 2================================");
											q2.rsort;
				$display("queue  after sorting high to low =%p ",q2);





				$display("===================16.d================================");
				repeat(4)
				begin
				q2.pop_back;
				end
				$display("queue  after deletion of last 4 values =%p ",q2);

				$display("===================16.e================================");
				repeat(10)
				begin
				q2.push_front($urandom_range(70,90));
				end


				$display("queue  after additon  10 values at front =%p ",q2);



end

`endif

`ifdef Q17
/*
a. q1={-3,3,-6,4,2”};
Print the sum of all elements.
b. q2={4’b1010, 4’b1100, 4’b0101, 4’b0001};
Print the final XORed value of all elements.*/

int q1[$]={-3,3,-6,4,2};

bit [3:0] q2[$]={4'b1010, 4'b1100, 4'b0101, 4'b0001};

int y;

initial
				begin

				$display("==================17.a================================");
				
				$display("queue before addition=%p ",q1);
						y=q1.sum;
				$display(" addition=%0d ",y);

				$display("==================17.b================================");

				$display("queue before xor=%p ",q1);
						y=q1.xor;// with (item+4);
				$display("after xor=%b ",y);


				end


`endif





`ifdef Q18

/*18.
assoc={“ele1”:10, “ele2”:5, “el1”:5, “el0”:7, “e”:10};
Store the unique values of above array into another array.*/


int assoc [string];

//int assoc_copy [string];
int q1[$];

initial
				begin
						assoc={"ele1":10, "ele2":5, "el1":5, "el0":7, "e":10};
				
				$display("asso array %p ",assoc);
				//unique(): returns all the elements with the unique values
				q1=assoc.unique;

				$display("unique array %p ",q1);
				end


`endif

`ifdef Q19
/*
a. string ass_arr[string];
ass_arr={“SUN”:5, “SOON”:10, “GOODS”:2, “GOOD”:20};
Find out first and last elements.
b. string q1[$];
q1={“SUN”,”SOON”,”GOODS”,”GOOD”};
Find out the first and last elements.
c. Check the difference between the above two outputs. Justify your answer.*/


int ass_arr[string];

string q1[$];



string index_storage;

initial 
begin
ass_arr={"SUN":5, "SOON":10, "GOODS":2, "GOOD":20};

				$display("ass_arr %p ",ass_arr);

				$display("==================19.a================================");
					ass_arr.first(index_storage);


ass_arr.first(index_storage);

$display("FIRST ELEMENT ass_arr[%s] %0d ",index_storage,ass_arr[index_storage]);

ass_arr.last(index_storage);

$display("LAST ELEMENT ass_arr[%s] %0d ",index_storage,ass_arr[index_storage]);


				$display("==================19.b================================");



q1={"SUN","SOON","GOODS","GOOD"};

				$display("queue q1 is  %p ",q1);


				

			//	$display("==================19.c================================");







end








`endif
/*
`ifdef Q20
`endif

`ifdef Q21
`endif

`ifdef Q22
`endif

`ifdef Q23
`endif

`ifdef 24
`endif

`ifdef Q25
`endif
*/




endmodule

