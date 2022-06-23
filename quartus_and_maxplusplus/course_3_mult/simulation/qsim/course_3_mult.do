onerror {quit -f}
vlib work
vlog -work work course_3_mult.vo
vlog -work work course_3_mult.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.course_3_mult_vlg_vec_tst
vcd file -direction course_3_mult.msim.vcd
vcd add -internal course_3_mult_vlg_vec_tst/*
vcd add -internal course_3_mult_vlg_vec_tst/i1/*
add wave /*
run -all
