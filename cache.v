`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:58:46 04/15/2019 
// Design Name: 
// Module Name:    cache 
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

module cache(
    input [5:0]    addr, waddr, 
	 input          clk, RW, CS, reset, start,
	 input [31:0]   wdata,
	 
    output [31:0]  data,
	 output         STALL
	 
    );
	 
	 wire [127:0]  rdata;
	 wire [5:0]   raddr;
	 wire [1:0]   state;
	 
	 Mem M (
		.wdata(wdata), 
		.raddr(raddr), 
		.waddr(waddr), 
		.clk(clk), 
		.CS(CS), 
		.reset(reset), 
		.RW(RW), 
		.rdata(rdata)
	 );
	 
	 
	 cache_datapath DT (
		.addr(addr), 
		.rdata(rdata), 
		.state(state), 
		.clk(clk),		
		.data(data), 
		.hit(hit),
		.raddr(raddr), 
		.STALL(STALL)
	);	
	
	cache_controller C (
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.hit(hit), 
		.state(state)
	);


endmodule

