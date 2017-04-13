`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:11:39 04/06/2017 
// Design Name: 
// Module Name:    clock 
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
module clock(
		input CLK_50,
		input nCR, EN,
		// set time or alarm buttons : 3 - 0 [min-,min+,hour-, hour+]
		input [1:0] settingTime,
		input [1:0] displayMode,
		input timeMode,
		// 0 -> 24 ,1 -> 12
		input alarmON,
		input [1:0] alarmSettings,
		// open Alarm
		output BaoshiLight,
		output [7:0] seg_out,
		output [3:0] seg_flag,
		output secondLight,
		output time_mode,
		output alarmLight
		);
	wire [7:0] Hour, Minute, Second;
	wire [7:0] alarmHour;
	wire [7:0] alarmMinute;
	wire minL_en, minH_en, hour_en;
	wire std_cp;
	wire seg_cp;
	reg [7:0] displayHour;
	reg [7:0] displayMinute;
	
	wire [7:0] callTimeHour;
//	wire [7:0] callTimeHour;
	

	//initial begin 
		//alarmHour = 8'h00;
		//alarmMinute = 8'h00;
	//end
	
	//assign alarmHour = 8'h00;
	//assign alarmMinute = 8'h00;

	//wire [7:0] setOutMinute;

	//parameters
	// mode 1 -> time
	// mode 2 -> set time
	// mode 3 -> set alarm
	//integer mode = 0;
	
	// displayMode = 0 -> display time
	// displayMode = 1 -> display Seconds
	// displayMode = 2 -> display Alarm
		
	// generate Standard 1 ms Counter 
	Devider50 default_counter(.CLK_50M(CLK_50), .nCLR(nCR), .CLK(std_cp));
	defparam default_counter.N = 25,
				default_counter.CLK_Freq = 50000000,
				default_counter.Ouput_Freq = 1;
	
	// 50Hz cp for segment
	Devider50H segCounter(.CLK_50M(CLK_50), .nCLR(nCR), .CLK(seg_cp));

	// Define Hour / Minute / Second Counter;
	// Second
	counter_10 second_counter_0(.Cnt(Second[3:0]),.nCR(nCR),.EN(EN),.CP(std_cp));
										
	counter_6  second_counter_1(.Cnt(Second[7:4]),.nCR(nCR),.EN(Second[3:0]==4'h9), .CP(std_cp));
	// Minute
	counter_10 minute_counter_0(.Cnt(Minute[3:0]),.nCR(nCR),.EN(minL_en),.CP(std_cp));
											
	counter_6  minute_counter_1(.Cnt(Minute[7:4]),.nCR(nCR),.EN(minH_en),.CP(std_cp));
	
	counter_24 hour_counter(.CntH(Hour[7:4]),.CntL(Hour[3:0]), .nCR(nCR),.EN(hour_en), .CP(std_cp));
	
	assign minL_en = settingTime[0] ? 1 : Second == 8'h59;
	assign minH_en = (settingTime[0] && Minute[3:0]==4'h9)||Minute[3:0] == 4'h9 && Second == 8'h59;
	assign hour_en = settingTime[1] ? 1 : (Minute == 8'h59 && Second == 8'h59);
	assign time_mode = timeMode;
	assign callTimeHour = Hour;

	Alarm myAlarm(.CLK(std_cp), 
				.curAlarmHour(Hour), 
				.curMin(Minute), 
				.alarmOn(alarmON), 
				.settingButton(alarmSettings), 
				.outHour(alarmHour), 
				.outMin(alarmMinute), 
				.alarmLight(alarmLight));


	segment_driver seg_dr(.MCLK9(seg_cp), 
						.timeMode(timeMode),
						.displayMode(displayMode), 
						.Hour(Hour), 
						.Minute(Minute), 
						.Second(Second), 
						.AlarmHour(alarmHour),
						.AlarmMin(alarmMinute), 
						.d1_wx(seg_flag), 
						.d1_out(seg_out));

	CallTime callTime(.CLK(std_cp),.Hour(callTimeHour),.Minute(Minute),.Light(BaoshiLight));

	SecondLights second_light(.CLK(std_cp),.light(secondLight));

endmodule
