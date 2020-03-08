`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:58:44 03/08/2020 
// Design Name: 
// Module Name:    cache_controller 
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
module cache_controller(
    input clk, reset, start, hit,
	 output reg [1:0] state
    );
	 
	 reg [1:0] next_state;
	 
	 parameter reset_state = 2'b00,
	           wait_state  = 2'b01,
				  fetch_state = 2'b11;
	 
	 always @(posedge clk, negedge reset)
	 begin
		if (~reset)
			state <= reset_state;
		else
			state <= next_state;
	 end
	 
	 always @(state, start, hit )
	 begin
	 
	 next_state = state;
	 
		case(state)
		
			reset_state : if(start) next_state = wait_state;
			
	      wait_state  : if(!hit) next_state = fetch_state;
			
		   fetch_state :  next_state = wait_state;
			
			default     : next_state = state;
			
		endcase
		
	 end
		
	 
endmodule
