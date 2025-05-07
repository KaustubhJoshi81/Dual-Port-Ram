`timescale 1ns / 1ns
module DualPortRam(read,write,RAdr,WAdr,clk,we,re);

parameter n1 = 5;
parameter n2 = 8;

input   clk;
input   we;
input   re;
input   [n2-1:0]write;        //Write Input ie. external device is writing to the Ram
input   [n1-1:0]WAdr;         //Write Address
output  [n2-1:0]read;         //Read output ie. external devices requests to read data
input   [n1-1:0]RAdr;         //Read Address 

reg [n2-1:0] mem[n1-1:0];     //Memory Array
reg [n2-1:0] readbuff;        //Read buffer

always @(negedge clk)
begin
    if (we==1'b1 && re==1'b1)       //Both read and write operations are enabled
    begin
        mem[WAdr] <=  write;
        readbuff  <=  mem[RAdr];
        if (WAdr == RAdr)
        begin
            readbuff <= write;      //Write-first type of output
        end
    end
    
    else if (we==1'b1 && re==1'b0)
    begin
        mem[WAdr] <=  write;
        readbuff  <=  'bz;          //High impedence(Z) output when read operation is disabled
    end
    
    else if (we==1'b0 && re==1'b1)
    begin
        readbuff  <=  mem[RAdr];
        mem[WAdr] <=  mem[WAdr];    //Ignore new write data when write operation is disabled
    end
    
    else
    begin
        readbuff  <=  'bz;          //Both read and write operations are disabled
        mem[WAdr] <=  mem[WAdr];
    end
end

assign read = readbuff;

endmodule
