/**
call when time 12:00 13:00 15:00....

*/

module CallTime(
    input CLK,
    input [7:0] Hour,
    input [7:0] Minute,
    output reg Light
);
    reg [7:0] curHour;
    reg [7:0] counter;

    // initial begin
    //     curHour = 8'b0000_0000;
    //     counter = 8'b0000_0000;
    // end
    
    // reg [3:0] counterH;
    // reg [3:0] counterL;
    // reg [7:0] curHour;
    // reg [7:0] counter;
    // reg flag;
    // reg [7:0] mcounter;
    //reg [7:0] flag;
    // initial begin
    //     counterH = 4'b0000;
    //     counterL = 4'b0000;
    //     flag = 0;
    //     mcounter = 8'b0000_0000;
    // end

    always @(posedge CLK) begin
        if (Minute == 8'h00) begin
            curHour = Hour[7:4] * 10 + Hour[38:0];
            if (counter < curHour + curHour) begin
                Light = ~Light;
                counter = counter + 1;
            end
            else begin
                Light = 0;
                counter = counter + 1;
            end
        end
        else begin
            counter = 0;
        end

        // if (CLK) begin
		// 	if(~flag) begin
        //         if (Minute == 8'h00) begin
        //             flag = ~flag;
        //             case (Hour)
        //                 8'h00: counter = 8'b0000_0000;
        //                 8'h01: counter = 8'b0000_0001; 
        //                 8'h02: counter = 8'b0000_0010;
        //                 8'h03: counter = 8'b0000_0011;
        //                 8'h04: counter = 8'b0000_0100;
        //                 8'h05: counter = 8'b0000_0101;
        //                 8'h06: counter = 8'b0000_0110;
        //                 8'h07: counter = 8'b0000_0111;
        //                 8'h08: counter = 8'b0000_1000;
        //                 8'h09: counter = 8'b0000_1001;
        //                 8'h10: counter = 8'b0000_1010;
        //                 8'h11: counter = 8'b0000_1011;
        //                 8'h12: counter = 8'b0000_1100;
        //                 8'h13: counter = 8'b0000_1101;
        //                 8'h14: counter = 8'b0000_1110;
        //                 8'h15: counter = 8'b0000_1111;
        //                 8'h16: counter = 8'b0001_0000;
        //                 8'h17: counter = 8'b0001_0001;
        //                 8'h18: counter = 8'b0001_0010;
        //                 8'h19: counter = 8'b0001_0011;
        //                 8'h20: counter = 8'b0001_0100;
        //                 8'h21: counter = 8'b0001_0101;
        //                 8'h22: counter = 8'b0001_0110;
        //                 8'h23: counter = 8'b0001_0111;
        //             endcase 
        //         end
        //     end
        //     else begin
        //         if (mcounter < counter+counter) begin
        //             mcounter = mcounter + 1'b1;
        //             Light = ~Light;
        //         end
        //         else begin
        //             mcounter = 8'b0000_0000;
        //             flag = 0;
        //         end
        //     end

            // else if(Second == 8'h00 + counter) begin
            //     counter = 0;
            // end

            // if (counter > 0) begin
            //     counter = counter - 1'b1;
            //     Light = 1;
            // end

            // if (counterL < Hour[3:0]) begin
            //     counterL = counterL - 1'b1;
            //     Light = 1;
            // end
            // else begin 
            //     if(counterH > 0) begin
            //         counterH = counterH - 1'b1;
            //         counterL = 4'b1000;
            //         Light = 1;
            //     end
            // end
            // if (counterL > 0 || counterH > 0) begin
            //     Light = 1;
            //     else if (counterL[3:0] > 0) begin
            //         counterL[3:0] = counterL[3:0] - 1'b1;
            //     end
            //     else begin 
            //         if(counterH[3:0] > 0) begin
            //             counterH[3:0] = counterH[3:0] - 1'b1;
            //             counterL[3:0] = 4'b1001; 
            //         end
            //     end
            //end
        // end
        // else begin
        //     Light = 0;
        // end
    end

    // always @(counter) begin
        
    //     if (CLK) begin
    //         if (mcounter < counter) begin
    //             Light = 1;
    //             mcounter = mcounter + 1'b1;
    //         end
    //         else begin
    //             flag = 8'b0000_0000;
    //         end
    //     end
    //     else begin
    //         Light = 0;
    //     end
    // end


endmodule // CallTime
