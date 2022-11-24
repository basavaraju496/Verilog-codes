
`ifdef BASIC1
//=======================	NORMAL CLASS ===============================//
class Packet;
//=========================data or class properties========================//
reg WRITE;      // write enable
bit [31:0] ADDR;    // address=32 bit
integer WDATA;         // data to write
logic [31:0] RDATA;  // data=32 bit

/*Note: Any data-type can be declared as a class property, except for net types since they are
incompatible with dynamically allocated data*/


//===============SUB ROUTINE===================================//

function void display();  
$display("\n WRITE=%p,\tADDR[31:0]=%h,\tRDATA[31:0]=%h,\tWDATA[31:0]=%h",WRITE,ADDR,RDATA,WDATA);
endfunction
endclass

module tb;
	Packet pkt; // creating object handler for Packet class
initial begin
			pkt=new();   // allocating space for the pkt obj handler
			pkt.display();  // calling it before writing data
			pkt.WRITE=1;
			pkt.ADDR =32'hFFFFFFFf;
			pkt.RDATA=32'h00;
			pkt.WDATA=32'hf0;
			pkt.display();
			end
endmodule

`endif




`ifdef BASIC2
//===========================Constructor inside the class========================//


class packet;
enum {LOW,HIGH}write;

bit[31:0]addr;
int wdata


`endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//								Q1_A
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``

`ifdef Q1A
/*1. Write a class with name “student”. Declare 10 “student” handles. Initialize the properties(student_name, roll_no,
marks, course_name, Pass_Fail) with different values (except the course_name).
b. Write one function and one task to do the manipulations on properties.*/



class student;

//=========================data or class properties========================//

string student_name;
int roll_no;
int marks;
string course_name;
bit result;

//===============SUB ROUTINE===================================//

function void display(); // method for displaying the values written in iobject

$display("\n student_name=%s roll_no=%0d marks=%0d course_name=%s result=%0d",student_name,roll_no,marks,course_name,result );

endfunction
endclass
module tb;
	student student_handler[10]; // creating object handler for Packet class
	string id;
	int i,j;
initial begin
			j=48;
repeat(10) begin
       				 id=string'(j);
			student_handler[i]=new();   // allocating space for the student obj handler
	//		student_handler[i].display();  // calling it before writing data

			student_handler[i].student_name={"student",id};
			student_handler[i].roll_no=j;
			student_handler[i].marks=$urandom_range(80,100);
			student_handler[i].course_name="system_verilog";
			student_handler[i].result=1;
			student_handler[i].display();  // calling it before writing data
			i++;
			j++;
			end




			end

endmodule
`endif




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//								Q1_B
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``
`ifdef Q1B
//b. Write one function and one task to do the manipulations on properties.*/

class student;

//=========================data or class properties========================//

string student_name;
int roll_no;
int marks;
string course_name;
string  result;

//===============SUB ROUTINE===================================//

task display; // method for displaying the values written in iobject

			$display("\n student_name=%s roll_no=%0d marks=%0d course_name=%s result=%0d",student_name,roll_no,marks,course_name,result );

endtask




function new(string student_name,int roll_no,int marks,string course_name,string result);

this.student_name=student_name;
this.roll_no=roll_no;
this.marks=marks;
this.course_name=course_name;
this.result=result;

endfunction






function new(string student_name,int roll_no,int marks,string course_name,string result);

this.student_name=student_name;
this.roll_no=roll_no;
this.marks=marks;
this.course_name=course_name;
this.result=result;

endfunction


endclass
module tb;
	student student_handler[10]; // creating object handler for Packet class
	string id;
	string l1,l2,l3,l4,l5,l6,name;

	int i;
initial begin

repeat(10) begin

			   l1=string'($urandom_range(65,90));
               l2=string'($urandom_range(65,90));
               l3=string'($urandom_range(65,90));
               l4=string'($urandom_range(65,90));
               l5=string'($urandom_range(65,90));
               l6=string'($urandom_range(65,90));
 
    				name={l1,l2,l3,l4,l5,l6};

//function new(string student_name,int roll_no,int marks,string course_name,string result);

			student_handler[i]=new(name,i,$urandom_range(70,100),"SV","pass");   // allocating space for the student obj handler

student_handler[i].display();
			i++;

			end
			end

endmodule

endclass
module tb;
	student student_handler[10]; // creating object handler for Packet class
	string id;
	string l1,l2,l3,l4,l5,l6,name;

	int i;
initial begin

repeat(10) begin

			   l1=string'($urandom_range(65,90));
               l2=string'($urandom_range(65,90));
               l3=string'($urandom_range(65,90));
               l4=string'($urandom_range(65,90));
               l5=string'($urandom_range(65,90));
               l6=string'($urandom_range(65,90));
 
    				name={l1,l2,l3,l4,l5,l6};

//function new(string student_name,int roll_no,int marks,string course_name,string result);

			student_handler[i]=new(name,i,$urandom_range(70,100),"SV","pass");   // allocating space for the student obj handler

student_handler[i].display();
			i++;

			end
			end

endmodule


`endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q2
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``

`ifdef  Q2


class student;

//=========================data or class properties========================//

string student_name;
int roll_no;
int marks;
string course_name;
string  result;

//===============SUB ROUTINE===================================//

task display(); // method for displaying the values written in iobject

			$display("\n student_name=%s roll_no=%0d marks=%0d course_name=%s result=%0d",student_name,roll_no,marks,course_name,result );

endtask




function new(string student_name,int roll_no,int marks,string course_name,string result);

this.student_name=student_name;
this.roll_no=roll_no;
this.marks=marks;
this.course_name=course_name;
this.result=result;

endfunction


endclass
module tb;
	student student_handler[1000]; // creating object handler for Packet class
	string l1,l2,l3,l4,l5,l6,name;
	int i;

initial begin//{

repeat(1000)
		begin//{

			   l1=string'($urandom_range(65,90));
               l2=string'($urandom_range(65,90));
               l3=string'($urandom_range(65,90));
               l4=string'($urandom_range(65,90));
               l5=string'($urandom_range(65,90));
               l6=string'($urandom_range(65,90));
 				name={l1,l2,l3,l4,l5,l6};

			student_handler[i]=new(name,i,$urandom_range(70,100),"SV","pass");   // allocating space for the student obj handler

			student_handler[i].display();

			i++;

			end//}
			end//}

endmodule






`endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q3
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``



`ifdef Q3

/*3. Write a class and initialize the class properties at constructor itself.*/
//Constructor inside the class

class student;

//=========================data or class properties========================//

string student_name;
int roll_no;
int marks;
string course_name;
string  result;

//===============SUB ROUTINE===================================//

task display(); // method for displaying the values written in iobject

			$display("\n student_name=%s roll_no=%0d marks=%0d course_name=%s result=%0d",student_name,roll_no,marks,course_name,result );

endtask




function new;

5student_name="basava";
roll_no=496;
marks=96;
course_name="sv";
result="pass";

endfunction
endclass

module tb;
	student student_handler; // creating object handler for Packet class

initial begin//{

student_handler=new();
			student_handler.display();

			end//}

endmodule




`endif


`ifdef Q4

/*4. Write a class. Declare two handles. Initialize different values to the properites, while constructing the object itself.*/

class student;

//=========================data or class properties========================//

string student_name;
int roll_no;
int marks;
string course_name;
string  result;

//===============SUB ROUTINE===================================//

task display(); // method for displaying the values written in iobject

			$display("\n student_name=%s roll_no=%0d marks=%0d course_name=%s result=%0d",student_name,roll_no,marks,course_name,result );

endtask


function new(string student_name,int roll_no,int marks,string course_name,string result);

this.student_name=student_name;
this.roll_no=roll_no;
this.marks=marks;
this.course_name=course_name;
this.result=result;

endfunction


endclass

module tb;
	student student_handler_1; // creating object handler for Packet class
	student student_handler_2; // creating object handler for Packet class
initial begin//{

			student_handler_1=new("basava",496,96,"sv","pass");
			student_handler_1.display();
			student_handler_1=new("anirudh",497,97,"sv","pass");
			student_handler_2.display();

			end//}

endmodule



`endif
/*


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q5
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q5


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q6
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q6


`endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q7
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q7


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q8
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q8


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q9
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q9


`endif 


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q10
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q10


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q11
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q11


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q12
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``

`ifdef Q12


`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q13
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``

`ifdef Q13


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q14
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q14


`endif




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q15
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q15


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q16
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q16


`endif




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q17
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q17


`endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q18
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q18


`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q19
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``

`ifdef Q19


`endif





//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q20
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q20


`endif




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q21
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q21


`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q22
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q22


`endif




//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q23
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q23


`endif


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q24
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
`ifdef Q24


`endif



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``
//							Q25
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`~~~~~~~~~~~~~``

`ifdef Q25


`endif




*/









