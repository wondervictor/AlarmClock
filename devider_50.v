/**
 * Content: 50MHz Devider
 * Author: Vic Chan
 * Date: 4/6/2017
 */
`timescale 1ns / 1ps

module Devider50(CLK_50M, nCLR, CLK);
    input CLK_50M;
    input nCLR;
    output reg CLK;
    parameter N = 25;
    parameter  CLK_Freq = 50000000;
    parameter  Ouput_Freq = 1;

    reg [N-1: 0] counter;

    always @ (posedge CLK_50M or negedge nCLR) begin
        if (!nCLR) begin
            CLK <= 0;
            counter <= 0;
        end
        else begin
            if (counter < (CLK_Freq/(2 * Ouput_Freq)-1))
                counter <= counter + 1'b1;
            else begin
                counter <= 0;
                CLK <= ~CLK;
            end
        end
    end

endmodule //Devider50
