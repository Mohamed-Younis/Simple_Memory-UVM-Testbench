all: lib sv sim

lib:
	vlib work

sv:
	vlog +incdir+../ ../mem_interface.sv ../agent_pkg.sv ../tb_pkg.sv ../memory.sv 
	vlog ../top.sv 
	vopt top -o top_opt

sim:
	vsim -c top_opt +UVM_TESTNAME=mem_basic_test +UVM_VERBOSITY=UVM_LOW -do "run -all; quit -f"
