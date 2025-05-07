`timescale 1ns / 1ns

module testbench();

parameter n1=5;
parameter n2=8;

reg clk;
reg we;
reg re;
reg [n2-1:0]write; //Write Input
reg [n1-1:0]WAdr; //Write Address
wire [n2-1:0]read; //Read output
reg [n1-1:0]RAdr; //Read Address 

reg [n2-1:0] mem[n1-1:0]; //Memory Array

DualPortRam UUT(.clk(clk), .write(write), .WAdr(WAdr), .read(read), .RAdr(RAdr), .we(we), .re(re));

//Generate Clock
always
begin
    clk = 0;
    #5;
    clk = 1;
    #5;
end

//Begin test
initial
begin

//Testing simulatneous read and write to different memory cells
#10;
we = 1; re = 1;
#10;
WAdr = 'b0; write = 'b0001;
#10; 
WAdr = 'b1; write = 'b10; RAdr = 'b0; 
//Expecting write = 0010 and read = 0001

//Testing Read enable
#10;
re = 0; 
//Expecting output read = Z 

//Testing write enable
#10;
we = 0; re = 1;
#10;
WAdr = 'b0; write = 'b0011; 
#10;
RAdr = 'b0; 
//Expecting output read to remain same (read = 0001)

//Overwriting a memory cell
#10;
we = 1;
#10;
WAdr = 'b0; write = 'b1111; re = 1;
#10;
RAdr = 'b0; 
//Expecting output read = 1111

//Testing simultaneous read and write operation to the same memory cell
#10;
WAdr = 'b1; write = 'b1100; RAdr = 'b1;  
//Expecting read = write

end
endmodule
