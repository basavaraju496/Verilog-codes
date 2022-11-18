home = /home/chicago/tools/Questa_2021.4_3/questasim/linux_x86_64/../modelsim.ini

work:
	vlib work
map:
	vmap work work
comp:
	vlog -work work +acc pwm.v tb_pwn.v

sim:
	vsim -debugdb -c -do "log -r /*; save -onexit -directive -codeAll;run -all;exit"   work.tb_pwm
wave:   	
	vsim -view vsim.wlf &
clean:
	rm -rf *.ini transcript work regression_status_list *.log merge_list_file *.wlf

