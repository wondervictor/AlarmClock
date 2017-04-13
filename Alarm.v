/**
content: Alarm
*/


module Alarm(CLK, curAlarmHour, curMin, alarmOn, settingButton, outHour, outMin, alarmLight);
    input CLK;
    input [7:0] curAlarmHour;
    input [7:0] curMin;
	 input alarmOn;
    input [1:0] settingButton;
    output reg [7:0] outHour;
    output reg [7:0] outMin;
    output reg alarmLight;

    wire [7:0] alarmClockHour;
    wire [7:0] alarmClockMinute;


    //assign alarmClockHour = 8'b0000_0000;
    //assign alarmClockMinute = 8'b0000_0000;


    wire minL_en, minH_en, hour_en;

    counter_10 alarm_minute_0(.Cnt(alarmClockMinute[3:0]),.nCR(1),.EN(minL_en),.CP(CLK));
											
	counter_6  alarm_minute_1(.Cnt(alarmClockMinute[7:4]),.nCR(1),.EN(minH_en),.CP(CLK));
	
	counter_24 alarm_hour(.CntH(alarmClockHour[7:4]),.CntL(alarmClockHour[3:0]), .nCR(1),.EN(hour_en), .CP(CLK));
	
    assign minL_en = settingButton[0];
    assign minH_en = (settingButton[0] && alarmClockMinute[3:0]==4'h9);
	assign hour_en = settingButton[1];

    always @(posedge CLK or negedge CLK) begin
        if (CLK) begin
            if (alarmOn) begin
                if ((curMin == alarmClockMinute) && (curAlarmHour == alarmClockHour)) begin
                    alarmLight = 1;
                end
            end
        end
        else begin
				alarmLight = 0;
        end
    end
	 
	 always @(*) begin
        outHour = alarmClockHour;
        outMin = alarmClockMinute;		
	 end
	 
endmodule // Alarm
