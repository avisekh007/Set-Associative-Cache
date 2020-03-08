`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:18 04/15/2019
// Design Name:   cache
// Module Name:   D:/Data/Xillinx/CacheMemory/test_cache.v
// Project Name:  CacheMemory
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cache
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_cache;

	// Inputs
	reg [5:0] addr;
	reg [5:0] waddr;
	reg clk;
	reg RW;
	reg CS;
	reg reset;
	reg start;
	reg [31:0] wdata;

	// Outputs
	wire [31:0] data;

	// Instantiate the Unit Under Test (UUT)
	cache uut (
		.addr(addr), 
		.waddr(waddr), 
		.clk(clk), 
		.RW(RW), 
		.CS(CS), 
		.reset(reset),
      .start(start),		
		.wdata(wdata), 
		.data(data),
		.STALL(STALL)
	);
	
	always #5 clk = ~clk;
	integer k;

	initial begin
		// Initialize Inputs
		addr = 0;
		waddr = 0;
		clk = 0;
		RW = 0;
		CS = 0;
		reset = 0;
		wdata = 0;
		start = 0;
		
		for (k=0 ; k<64 ; k=k+1)
		  uut.M.mem[k] = k;
		  
		
		// Wait 100 ns for global reset to finish
        
		// Add stimulus here

	end
      
endmodule

