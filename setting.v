/**
 * Content: setting
 * Author: Vic Chan
 * Date: 4/10/2017
 */

 module setting(
	 CLK,
    add_hour,
    sub_hour,
    add_min,
    sub_min,
    inHour,
    inMinute,
    mode,
	 outHour,
	 outMinute
	 
 );
    // mode = 0 -> 24
    // mode = 1 -> 12
	 input CLK;
    input mode;
    input add_hour;
    input sub_hour;
    input sub_min;
    input add_min;
    input [7:0] inHour;
    input [7:0] inMinute;
	 output reg [7:0] outHour;
	 output reg [7:0] outMinute;



    always @(posedge CLK) begin
        outMinute = inMinute;
        outHour = inHour;
        if (add_min) begin
            // second (x0~x8)
            if (outMinute[3:0] < 4'd9) begin
                outMinute = outMinute + 1;
            end
            // second (x9)
            else if (outMinute[3:0] == 4'd9) begin
                if (outMinute[7:4] < 4'd5) begin
                    outMinute[7:4] = outMinute[7:4] + 1;
                    outMinute[3:0] = outMinute[3:0] + 1;
                end
                // second (59)
                else if (outMinute[7:4] == 4'd5) begin
                    outMinute = 8'h00;
                end
            end   
        end
        else if (add_hour) begin
            if (mode == 0) begin                    
                // hour(0-19)
                if (outHour[7:4] < 4'd2) begin
                    // hour=00~08 // 10 ~ 18
                    if (outHour[3:0] < 4'd9) begin
                        outHour[3:0] = outHour[3:0] + 1'b1;
                    end
                    // hour == 9 / 19
                    else if (outHour[3:0] == 4'd9) begin
                        outHour[7:4] = outHour[7:4] + 1'b1;
                        outHour[3:0] = 4'h0;
                    end
                end
                // hour =20~24
                else if (outHour[7:4] == 4'd2) begin
                    // hour = 20 ~ 22
                    if (outHour[3:0] < 4'd3) begin
                        outHour[3:0] = outHour[3:0] + 1'b1;
                    end
                    else if (outHour[3:0] == 4'd3) begin
                        outHour[7:0] = 8'h00;
                    end
                end
            end
            else if (mode == 1) begin
                if(outHour[7:4] == 4'd0) begin
                    if (outHour[3:0] < 4'd9) begin
                        outHour[3:0] = outHour[3:0] + 1'b1;
                    end
                    else if (outHour[3:0] == 4'd9) begin
                        outHour[7:0] = 8'h10;
                    end 
                end
                else if(outHour[7:4] == 4'd1) begin
                    if(outHour[3:0] < 4'd2) begin
                        outHour[3:0] = outHour[3:0] + 1'b1;
                    end
                    else if (outHour[3:0] == 4'd2) begin
                        outHour[7:0] = 8'h01;
                    end
                end
            end
        end

        else if (sub_min) begin
             // min x1~x9
             if (outMinute[3:0] > 4'h0) begin
                outMinute[3:0] = outMinute[3:0] - 1'b1;
             end
             else if (outMinute[3:0] == 4'h0) begin
                if(outMinute[7:4] > 4'h0) begin
                    outMinute[7:4] = outMinute[7:4] - 1'b1;
                    outMinute[3:0] = 4'h9;
                end
                else if (outMinute[7:4] == 4'h0) begin
                    outMinute[7:0] = 8'h59;
                end
             end
        end
        if (sub_hour) begin
            if(mode == 0) begin
                if(outHour[3:0] > 0) begin
                    outHour[3:0] = outHour[3:0] - 1'b1;
                end
                else if (outHour[3:0] == 0) begin
                    if (outHour[7:4] > 0) begin
                        outHour[7:4] = outHour[7:4] - 1'b1;
                        outHour[3:0] = 4'h9;
                    end
                    else if (outHour[7:4] == 0) begin
                        outHour[7:0] = 8'h23;
                    end
                end
            end
            else if (mode == 1) begin
                if(outHour[3:0] > 0) begin
                    outHour[3:0] = outHour[3:0] - 1'b1;
                end
                else if (outHour[3:0] == 0) begin
                    if (outHour[7:4] > 0) begin
                        outHour[7:4] = outHour[7:4] - 1'b1;
                        outHour[3:0] = 4'h9;
                    end
                    else if (outHour[7:4] == 0) begin
                        outHour[7:0] = 8'h12;
                    end
                end
            end
        end
    end

endmodule // setting
