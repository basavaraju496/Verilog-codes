vlog -work work +acc tb_final_project_udc.v
vsim -debugDB tb_final_project_udc
add wave -position insertpoint sim:/tb_final_project_udc/*
run -all


vlog tb_tester.v    // compilation  tb file name
vsim -novopt   work.tb_tester  // tb module name      //elaboration no optimisation show complete data base
add wave sim:/tb_tester/*        // wave
run -all                       // simulation



vlog tb_tester.v
vsim  tb_tester
add wave -position insertpoint sim:/tb_tester/DUT/*
run -all
