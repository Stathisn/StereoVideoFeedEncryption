`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:29:30 03/18/2014 
// Design Name: 
// Module Name:    counter 
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
module counter(
    clk,
    count,
    reset
    );
parameter COUNT_WIDTH = 5;
parameter UP_DOWN_COUNT = 1;
parameter COUNT_LIMIT = 10;

input clk;
input reset;
output reg [COUNT_WIDTH - 1 : 0] count = 0;

//always @ (posedge reset)
//begin
//	if (UP_DOWN_COUNT == 0) begin
//		count <= COUNT_LIMIT;
//	end else begin
//		count <= 0;
//	end
//end

always @ (posedge clk)
begin
	if (reset == 1) begin // Reset the counter to max/min value depending on up/down count
		if (UP_DOWN_COUNT == 0) begin
			count <= COUNT_LIMIT;
		end else begin
			count <= 0;
		end
	end else begin
		if (UP_DOWN_COUNT == 0) begin // Check for count up or count down
			if (count == 0) begin // Check if limit reached
				count <= COUNT_LIMIT;
			end else begin
				count <= count - 1; // Decrement
			end
		end else begin
			if (count == COUNT_LIMIT) begin // Check if limit reachec
				count <= 0;
			end else begin
				count <= count + 1; // Increment
			end
		end
	end
end


endmodule
