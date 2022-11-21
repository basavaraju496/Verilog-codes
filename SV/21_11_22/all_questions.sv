module  tb;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 1 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ifdef Q1

//==============Take a 2 state variable and assign X and Z to the variable and display the output.=============//

logic four_state_variable;   // four state variable  

bit   two_state_variable;    // two state variable

initial begin //{

$monitor($time," four_state_variable= %0b two_state_variable ",four_state_variable,two_state_variable);


two_state_variable=1'bz;   // assigning z 
four_state_variable=1'bz; 

#5 two_state_variable=1'bx;   //assigning x
 four_state_variable=1'bx; 

#5 four_state_variable=1'b1;
 two_state_variable=1'b1;


#5 four_state_variable=1'b0;
 two_state_variable=1'b0;

/*
#                    0 four_state_variable= z two_state_variable 0  ***
#                    5 four_state_variable= x two_state_variable 0  ***
#                   10 four_state_variable= 1 two_state_variable 1
#                   15 four_state_variable= 0 two_state_variable 0
if we assign X,Z to two state variable it takes as zero(0)
*/





end


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 2 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


`ifdef Q2

//====================Take a logic type variable and use it in always block and assign block. Check the output========/

logic [1:0]both_reg_net; // logic datatype acts as both reg and net


assign 	both_reg_net=2;  // assigning value  2 for both_reg_net continously



always@(*)
begin

both_reg_net=1;   // assigning the vaue 1 whenever any change happens to both_reg_net

end
/*
 * Error (suppressible): Variable 'both_reg_net' written by continuous and procedural assignments 
*/  

`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 3 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ifdef Q3
// ======Check the difference between 4’b1000 and 4’d1000.=======//
bit [3:0]a; //4bit

initial begin 

$monitor($time," a in decimal =%0d a in binary =%b",a,a);




#5 a=5;

#5 a=4'b1000;

#5 a=4'd1000;
//$monitor($time," a in decimal =%0d a in binary =%b",a,a);  


end

`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 4 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


`ifdef Q4
// Write an example for Concatenation operator in verilog.

reg [7:0] variable_a;


initial begin


$monitor($time," variable_a  in binary =%b",variable_a);


#5 variable_a={3'b000,3'b111,2'bxx};
/* same as verilog  
#                    0 variable_a  in binary =xxxxxxxx
#                    5 variable_a  in binary =000111xx
*/

end

`endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 5 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*
`ifdef Q5
//  =============Write a task to add two arrays.====================//



int [5:0]array1;
int [5:0]sum_array;
int [5:0]array2;
shortint i;

initial begin //{

array1='{0,1,2,3,4,5};
array2=array1;


$display(" BEFORE SUM ");
for(i=0; i<6; i++)
begin//{
		$display("array1[%b]=%0d array2[%b]=%0d sumarray[%b]=%0d  ",array1,array2,sumarray);

end//}



#5
$display("  SUM operation started ");

task_array_adder;

end//}

task task_array_adder;
begin//{

for(i=0; i<6; i++)
begin//{
		sum_array[i]=array1[i]+array2[i];
		$display("array1[%b]=%0d array2[%b]=%0d sumarray[%b]=%0d  ",array1,array2,sumarray);

end//}
end//}

//** Error: q1.sv(126): (vlog-13407) Can't have packed array of unpacked type.



`endif



*/
/*
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 6 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q6

//====================== q6.Write a function with return type as array.=========//



function add;

begin
end

endfunction






`endif

*/

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 7 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q7
//====== doubt q7. enum {IDLE, START, STOP=’bx} state; Display the above enum type variable========//

 enum {IDLE,START,STOP='bx } state;

initial begin 

$display("values in enum %b",state.first);
$display("values in enum %b",state.next);
$display("values in enum %b",state.last);

end

//** Error:  Enum member 'STOP' with X or Z assignment is only possible when enum declaration is of 4 state type.


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 7.1 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//================== enum without datatype===========================//

`ifdef Q7_1


 enum {IDLE,START,STOP} state;

initial begin 

$display("values in enum %b",state.first);
$display("values in enum %b",state.next);
$display("values in enum %b",state.last);

end

/*
# values in enum 00000000000000000000000000000000[0]
# values in enum 00000000000000000000000000000001[1]
# values in enum 00000000000000000000000000000010[2]

enum by default is int 32 bit 

*/



`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 7.2 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q7_2

//================== enum with byte(8 bit)  datatype===========================//

 enum byte {IDLE,START,STOP} state;

initial begin 

$display("values in enum %b",state.first);
$display("values in enum %b",state.next);
$display("values in enum %b",state.last);

end

/*
# values in enum 00000000
# values in enum 00000001
# values in enum 00000010
*/

`endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 7.3 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q7_3

//================== enum with byte(8 bit)  datatype===========================//

 enum bit {IDLE,START,STOP} state;

initial begin 

$display("values in enum %b",state.first);
$display("values in enum %b",state.next);
$display("values in enum %b",state.last);

end

/* Error: all_questions.sv(303): (vlog-13003) Enum member 'STOP' has value that is outside the representable range of the enum.*/



`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 7.4 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q7_3

//================== enum with short_int(16 bit)  datatype===========================//

 enum shortint {IDLE,START,STOP} state;

initial begin 

$display("values in enum %b",state.first);
$display("values in enum %b",state.next);
$display("values in enum %b",state.last);

end




`endif



































//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 8 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q8

enum integer {IDLE, START='bx, STOP} state; //Display the above enum type variable

initial begin 

$display("values in enum %b",state.first);
$display("values in enum %b",state.next);
$display("values in enum %b",state.last);

end

//** Error: q1.sv(235): (vlog-13001) An unassigned enumerated name 'STOP' cannot follow the enum member with X or Z assignments.


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 9 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q9

//=================How to come out of “forever” loop in verilog. Give an example?===========//

int count;

reg clk;

initial clk=0;

always #1 clk++;

initial begin //{


$monitor($time," count = %0d",count);

task_count;

task_end;
end//}

task task_count;
begin : block//{
		forever@(posedge clk)
		begin//{
			count++;
				if(count==11) begin
					
				disable block;
				
				//task_end; 
				end
end//}
end//}
endtask


task task_end;
begin//{
count=0;

#100
$finish;
end//}
endtask

`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 10
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ifdef Q10

//============How to come out of “forever” loop in System verilog. Give an example?====//


int count;

reg clk;

initial clk=0;

always #1 clk++;

initial begin //{


$monitor($time," count = %0d",count);

task_count;
$finish;

end//}

task task_count;
begin//{
		forever@(posedge clk)
		begin//{
			count++;
				if(count==20) begin
					break; end
end//}
$display("came out of forever loop");
end//}
endtask

`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 11
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q11

//=============for(int i=9; i >=­7; i­­) Using the above for loop, write an example that displays “i” value only for positive “i” values.===========//


initial begin //{


for(int i=9; i>=-7; i--)
begin//{
if(i>0)
		$display("i=%0d",i);


end//}


end//}



`endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 12
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q12
//Declare a two dimensional(2D) array and initialize the arrray any values and display using verilog constructs and system verilog constructs.









`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 13
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q13
// we can reduce manual work by using task and functions and by using classes,inheritance in OOPS 
`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 14
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q14

//Write a simple code using pre­increment and post­increment operators?//


int var_a,var_b,c,d;

initial begin 


$monitor($time," a=%0d b=%0d c=%0d d=%0d ",var_a,var_b,c,d);
var_a=5;
var_b=5;

#5 c=var_a++; d=++var_b; // $display("inside display c=%0d",c);
 
//$display("a ");

#5 d=--var_b;  c=var_a--;



end

`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 15
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//==================//
`ifdef Q15

integer state;
initial
begin
int count='d10;
#10 state='d20;
end
initial
begin
#1 $display("count=%d",count);
#15 $display("state=%d",state);
end

/** Warning: q1.sv(405): (vlog-2244) Variable 'count' is implicitly static. You must either explicitly declare it as static or automatic or remove the initialization in the declaration of variable.
# ** Error (suppressible): q1.sv(410): (vopt-7063) Failed to find 'count' in hierarchical name 'count'.

always #1 clk_in++;

/*
always @(posedge clk_in) begin
state<=state_next; 



*/


`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 16
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//==================//
`ifdef Q16

bit clk_in;

reg[1:0] state, state_next, count_next;

always #1 clk_in++;

/*
always @(posedge clk_in) begin
state<=state_next; 


$display("state=%0b state_next=%0b count_next=%0b ",state,state_next,count_next);
end

always @(posedge clk_in)
state<=count_next;

*/
always @(*) begin
state<=state_next; 


$display("state=%0b state_next=%0b count_next=%0b ",state,state_next,count_next);
end

always@(*) begin
state<=count_next;
$display(" hi ");
end



initial begin
#100 $finish;
end 

`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 17
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


`ifdef Q17

`endif






//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 18
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//18. Write adddition of two varialbes using task and functions in verilog and system verilog //.

`ifdef Q18

shortint a;
shortint b;
int c,d;

initial
begin
a=10; b=20;

task_add;  // calling add task
d=func_add(a,b); // calling addition function

$display("a=%0d b=%0d\n addition using task >>>>>  c=%0d \n addition using function >>>> d=%0d",a,b,c,d);


end



task task_add;
begin
c=a+b;
end
endtask



function int func_add;
input shortint a,b;

begin
		func_add=a+b;
end
endfunction


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION 19
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//19. Take single bit logic variables and compare using ==? and !=? operators. Apply all possible scenarioes.//

`ifdef Q19

logic var_a,var_b;

initial begin 

#100 $finish;

end

initial begin 

#5 var_a=0;				var_b=0;

#5 var_a=0;				var_b=1;

#5 var_a=1;				var_b=0;

#5 var_a=1;				var_b=1;

#5 var_a='z;				var_b='bz;


#5 var_a='z;				var_b='x;

#5 var_a='x;				var_b='z;

#5 var_a='x;				var_b='x;


end

always@(var_b,var_b)
		begin
		$display("inside == != ");
		if(var_b==var_a)
		$display("var a=%b equal to var b=%b  ",var_a,var_b);

		else if(var_a!=var_b)
		$display("var a=%b not equal to var b=%b  ",var_a,var_b);
		else
		$display("var a=%b not related var b=%b  ",var_a,var_b);

end


always@(var_b,var_b)
		begin
		$display("inside ==? !=? ");
		if(var_b==?var_a)
		$display("var a=%b equal to var b=%b  ",var_a,var_b);

		else if(var_a!=?var_b)
		$display("var a=%b not equal to var b=%b  ",var_a,var_b);
		else
		$display("var a=%b not related var b=%b  ",var_a,var_b);

end











`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION  20
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//Execute the above program.check what will be the state value.Describe your analysis


`ifdef Q20









`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION  21
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef Q21
typedef enum {IDLE, START,STOP, WAIT} state;
state s1;
always_comb
begin
case(s1)
 IDLE:$display("inside case state = %0d", s1);
START:$display("inside start state = %0d", s1);
 STOP:$display("inside stop state = %0d", s1);
 WAIT:$display("inside wait state = %0d", s1);
endcase
end

`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						QUESTION  22
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ifdef Q22

typedef enum {IDLE, START,STOP} state;
parameter WAIT='d3;
state s1;
always_comb
begin
case(s1)
IDLE    : s1 = START;
START: s1 = STOP;
STOP   : s1 = WAIT;
endcase
end

`endif




endmodule
