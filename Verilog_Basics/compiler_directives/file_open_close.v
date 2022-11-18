    module tb;  
        // Declare a variable to store the file handler  This is unique for each file
		integer fd;  
      
        initial begin  
            // Open a new file by the name "my_file.txt"  
            // with "write" permissions, and store the file  
            // handler pointer in variable "fd"  Users can specify only the name of a file as an argument.          
fd = $fopen("my_file.txt", "w");  
     // By default, before the simulator terminates, all open files are closed.
            // Close the file handle pointed to by "fd"  
$fclose(fd);  
        end  
    endmodule  
