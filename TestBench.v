`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:43:48 04/11/2017
// Design Name:   clock
// Module Name:   D:/VerilogExperiments/Clock/TestBench.v
// Project Name:  Clock
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench;

	// Inputs
	reg nCR;
	reg EN;
	reg [3:0] settingButtons;
	reg [1:0] settingMode;
	reg hourMode;
	reg openAlarm;
	reg std_cp;
	reg seg_cp;

	// Outputs
	wire [7:0] seg_out;
	wire [3:0] seg_flag;
	
	parameter TIME_PERIOD = 20;
	reg clock_base_signal;

	// Instantiate the Unit Under Test (UUT)
	clock uut (
		.CLK_50(clock_base_signal), 
		.nCR(nCR), 
		.EN(EN), 
		.settingButtons(settingButtons), 
		.settingMode(settingMode), 
		.hourMode(hourMode), 
		.openAlarm(openAlarm), 
		.seg_out(seg_out), 
		.seg_flag(seg_flag),
		.std_cp(std_cp),
		.seg_cp(seg_cp)
	);
	
	

	initial begin
		// Initialize Inputs
		
		nCR = 1;
		EN = 1;
		settingButtons = 0;
		settingMode = 0;
		hourMode = 0;
		openAlarm = 0;
		clock_base_signal = 0;
		seg_cp = 0;
		std_cp = 0;

		// Wait 100 ns for global reset to finish
			
		// Add stimulus here

	end
	
	always begin 
		#(TIME_PERIOD) clock_base_signal = ~clock_base_signal;
	end
endmodule

