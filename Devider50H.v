/**
 * Content: 50MHz Devider to get 50Hz
 * Author: Vic Chan
 * Date: 4/10/2017
 */


module Devider50H(CLK_50M, nCLR, CLK);
    input CLK_50M;
    input nCLR;
    output reg CLK;
    reg [31:0] counter = 0;
    parameter  CLK_Freq = 50000000;
    parameter  Ouput_Freq = 50;

    always @ (posedge CLK_50M or negedge nCLR) begin
        if (!nCLR) begin
            CLK <= 0;
            counter <= 0;
        end
        else if (counter >= 100000) begin
            CLK <= ~CLK;
            counter <= 0;
        end
        else begin
            counter <= counter + 1'b1;
        end

    end
endmodule //Devider50H
