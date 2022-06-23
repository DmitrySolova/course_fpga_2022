onerror {quit -f}
vlib work
vlog -work work course_9_mult.vo
vlog -work work course_9_mult.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.course_9_mult_vlg_vec_tst
vcd file -direction course_9_mult.msim.vcd
vcd add -internal course_9_mult_vlg_vec_tst/*
vcd add -internal course_9_mult_vlg_vec_tst/i1/*
add wave /*
run -all
