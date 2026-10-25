`timescale 1ns / 1ps

module rr_arbiter_tb;
reg clk;
reg rst;
reg [2:0] req;
wire [2:0] gnt;
rr_arbiter_fsm uut (.gnt(gnt),.req(req),.clk(clk),.rst(rst));

always #5 clk = ~clk;
initial begin
    clk = 0;
    rst = 1;
    req = 3'b000;
    #20;
    rst = 0;
    #10;
    req = 3'b001;
    #30;
    req = 3'b000;
    #20;
    req = 3'b101;
    #30;
    req = 3'b100;
    #30;
    req = 3'b000;
    #20;
    req = 3'b111;
    #30; 
    req = 3'b110;
    #30;
    req = 3'b100;
    #30;
    req = 3'b000;
    #20;
    $finish;

end
endmodule 
