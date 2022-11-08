vlog -work work +acc tb_final_project_udc.v
vsim -debugDB tb_final_project_udc
add wave -position insertpoint sim:/tb_final_project_udc/*
run -all
