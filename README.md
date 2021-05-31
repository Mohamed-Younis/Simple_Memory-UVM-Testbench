# Simple_Memory-UVM-Testbench

This is a uvm testbench for a single port read write memory and it has the following structure.

![memory_tb](https://user-images.githubusercontent.com/46727826/118402912-4711bc80-b66c-11eb-9c92-bfbd94118dd4.png)

## How to run
To simulate using Questasim run the Makefile inside the sim folder.
```
make
```
To run on other simulators compile the following files before running the top module.

* mem_interface.sv
* agent_pkg.sv
* tb_pkg.sv
* memory.sv
* top.sv 
