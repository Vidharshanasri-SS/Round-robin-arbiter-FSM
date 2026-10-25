`timescale 1ns / 1ps
module rr_arbiter_fsm(gnt,req,clk,rst); 
output reg [2:0]gnt;
input wire [2:0] req;
input clk,rst;

localparam IDLE=2'b00,
g1=2'b01,
g2=2'b10,
g3=2'b11;

reg [2:0]ns,s;
reg [1:0]turn,next_turn;

always @(posedge clk or posedge rst)
begin 
if(rst)
    begin
    s<=IDLE;
    turn <= 1'b0;
    end
else
    begin
    s<=ns;
    turn <= next_turn;
    end 
end

always @ (*)
begin
ns=s;
next_turn=turn;
gnt=1'b0;

case(s)
IDLE: begin
    if (turn == 2'b00) begin
        if (req[0])      
            ns = g1;
        else if (req[1]) 
            ns = g2;
        else if (req[2]) 
            ns = g3;
    end
    else if (turn == 2'b01) begin
         if (req[1])      
            ns = g2;
         else if (req[2]) 
            ns = g3;
         else if (req[0]) 
            ns = g1;
    end
    else if (turn == 2'b10) begin
         if (req[2])      
            ns = g3;
         else if (req[0]) 
            ns = g1;
         else if (req[1]) 
            ns = g2;
    end
end 
g1: begin
     gnt[0]=1;                 
     if (req[0]) begin
        ns = g1 ;
     end               
     else begin
         ns = IDLE;
         next_turn = 2'b01;        
     end
end 
      
g2: begin
    gnt[1]=1;                 
    if (req[1]) begin
       ns = g2;
       end 
    else begin
       ns = IDLE;
       next_turn = 2'b10;       
       end
end 

g3: begin
    gnt[2]=1;                 
    if (req[2]) begin
        ns = g3;
    end 
    else begin
        ns = IDLE;
        next_turn = 2'b00;       
    end
end

default: begin
    ns = IDLE;
    next_turn = 2'b00;
    gnt=1'b0;
end

endcase

end 

endmodule
