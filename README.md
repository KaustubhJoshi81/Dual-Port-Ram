# Dual-Port-Ram
Synchronous Dual Port Ram implementation using Verilog in AMD Vivado. 
One of the ports performs read operation while the other performs write operation. Each port also has a memory address input and read/write enable. Parameters are used to easily customize the size of the memory array.

//Testbench//

The testbench is written in Verilog and performs the following tests:
1. Testing simulatneous read and write to different memory cells
2. Testing Read enable
3. Testing write enable
4. Overwriting a memory cell
5. Testing simultaneous read and write operation to the same memory cell
