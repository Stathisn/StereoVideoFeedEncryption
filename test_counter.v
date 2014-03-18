`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:44:41 03/18/2014
// Design Name:   counter
// Module Name:   C:/Users/Nathan/Documents/GitHub/StereoVideoFeedEncryption/test_counter.v
// Project Name:  VmodCAM_Ref_HD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: counter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_counter;

	// Inputs
	reg clk;
	reg reset;
	reg en;

	// Outputs
	wire [2:0] count;

	// Instantiate the Unit Under Test (UUT)
	counter #(
		.COUNT_WIDTH(3),
		.UP_DOWN_COUNT(1),
		.COUNT_LIMIT(6))
		uut (
		.clk(clk), 
		.reset(reset),
		.count(count)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#20;
		reset = 0;
        
		// Add stimulus here

	end
	
	always
		#10 clk = !clk;
      
endmodule

