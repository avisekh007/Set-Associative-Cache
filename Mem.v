`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:57 04/15/2019 
// Design Name: 
// Module Name:    Mem 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module Mem(
    input [31:0] wdata,
    input [5:0]  raddr, waddr,
    input clk, CS, reset, RW,
	 
    output [127:0] rdata
    );
	 
	 integer i;
   
    reg [31:0] mem [0:63];

    assign rdata = {mem[raddr], mem[raddr+1], mem[raddr+2], mem[raddr+3]};

    always @(posedge clk) 
    begin 
      if (CS && reset) 
        for (i=0; i<64; i=i+1)
          mem[i] = 0;
      else if (CS && RW)
        mem[waddr] = wdata; 
    end

endmodule
