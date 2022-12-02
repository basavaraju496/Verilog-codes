`include"MCS_dv05_subtractor_transaction1.sv"  //starts here
`include"MCS_dv05_subtractor_generator2.sv"    //getting class from transaction

`include"MCS_dv05_subtractor_interface.sv" // doesnot dep on any 
`include"MCS_dv05_subtractor_dut.sv" // doesnot dep on any 
`include"MCS_dv05_subtractor_driver3.sv"   // we are taking intf sg from the intf file
module tb;
generator hg; // handle for generator class
transaction ht;  // handle for transaction class
mailbox mbx;     // creating mailbox handle  so that it will pass to the generator and driver
driver hd;      // creating handle for driver class
//virtual adder_intf h_vintf;  // creating handle for virtual interface
bit clk;
always #1 clk++;
 adder_intf h_vintf(clk);  // creating handle for virtual interface

initial begin 

ht=new();     // creating handle for transaction
mbx=new();    // creating handle for mailbox
hg=new(mbx); // passing this mailbox to the generator class for putting data
//h_vintf=new();  // creating memory for virtual interface object
hd=new(h_vintf,mbx);    // since vinterface is same for both we pass handle here

hg.task_to_randomize_data_in_generator;   // calling task for randomizing data and then displaying it
hd.task_to_give_data_to_dut();  // calling a task which is inside driver class inorder  to_give_data_to_dut 

end


endmodule




