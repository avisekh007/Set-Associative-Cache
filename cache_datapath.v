`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:47 04/15/2019 
// Design Name: 
// Module Name:    cache_datapath 
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

module cache_datapath(
    input [5:0]       addr, 
	 input             clk,
	 input [127:0]     rdata,
	 input [1:0]       state,
	 output reg [5:0]  raddr,
    output [31:0]     data,
	 output            hit,
	 output reg        STALL
	 
    );
	  
	 parameter null = 2'b00;
	
	 
	 reg [127:0]   cache_w1 [0:3], cache_w2 [0:3];   // Two ways
	 reg [1:0]     tag_w1 [0:3], tag_w2 [0:3]; 
	 reg           way [0:3];
	 
	 wire [1:0]    index, offset, tag;
	 
	 reg [31:0]    data_w1, data_w2;
	 wire [127:0]  row_cache_w1, row_cache_w2;
	 wire          sel;
	 wire          z1, z2;
	 
	 
	 parameter reset_state = 2'b00,
	           wait_state  = 2'b01,
				  fetch_state = 2'b11;
	 
	 
	 assign tag    = addr[5:4],
		     index  = addr[3:2],
		     offset = addr[1:0];
			  
	 assign row_cache_w1 = cache_w1[index],
           row_cache_w2 = cache_w2[index];
			  
		

	 integer k;
	 
	 
	 always @(posedge clk)
	 begin
	 
	 STALL <= !hit;
	 
		case(state)
		
		reset_state : for (k=0 ; k<4 ; k=k+1)
		              begin
							cache_w1[k] <= 128'b0;
							cache_w2[k] <= 128'b0;
							tag_w1[k]   <= 2'b11;
							tag_w2[k]   <= 2'b11;
							way[k]      <= 1'b1;
		              end
						  
						  
		wait_state : begin
		
					    case (offset)
		             2'b00 : begin data_w1 <= row_cache_w1[127:96]; data_w2 <= row_cache_w2[127:96]; end
		             2'b01 : begin data_w1 <= row_cache_w1[95:64];  data_w2 <= row_cache_w2[95:64];  end
		             2'b10 : begin data_w1 <= row_cache_w1[63:32];  data_w2 <= row_cache_w2[63:32];  end
		             2'b11 : begin data_w1 <= row_cache_w1[31:0];   data_w2 <= row_cache_w2[31:0];   end
	                endcase
		
	                end
						  
		fetch_state : begin
	 
		              if (way[index])
		              begin	  
							cache_w1[index] <= rdata;
							tag_w1[index]   <= tag;
		              end
		  
		              else if (!way[index])
		              begin
							cache_w2[index] <= rdata;
							tag_w2[index]   <= tag;
		              end
						  
						  way[index] <= !(way[index]);
						  
						  end
						  
		endcase
		  
	 end
	 
	 always @(*)
			raddr <= {tag, index, null};
	 
		
	 assign z1 = (tag == tag_w1[index])? 1'b1 : 1'b0,
	        z2 = (tag == tag_w2[index])? 1'b1 : 1'b0,
	        hit = z1 || z2,
	        sel = z1 && !z2;
	 
	 assign data = sel ? data_w1 : data_w2;	    
	 

endmodule
