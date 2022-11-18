home = /home/chicago/tools/Questa_2021.4_3/questasim/linux_x86_64/../modelsim.ini

work:
	vlib work
map:
	vmap work work
comp:
	vlog -work work +acc FINAL_CHECKER_UDC.v +define+BASIC

compf:
	vlog -work work +acc compare_udc.v
	vsim -debugdb -c -do "log -r /*; save -onexit -directive -codeAll;run -all;exit"   work.compare_udc 	




	
sim:
	vsim -debugdb -c -do "log -r /*; save -onexit -directive -codeAll;run -all;exit"   work.tb_checker_udc 	
all:
	vlog -work work +acc file_operation.v
	vsim -debugdb -c -do "log -r /*; save -onexit -directive -codeAll;run -all;exit"   work.file_operation
	
wave:   	
	vsim -view vsim.wlf &
clean:
	rm -rf *.ini transcript work regression_status_list *.log merge_list_file *.wlf

compare_files:
	vlog -work work +acc basic_compare_files.v +define+COMPARE_MUX
	vsim -debugdb -c -do "log -r /*; save -onexit -directive -codeAll;run -all;exit"   work.compare_files

