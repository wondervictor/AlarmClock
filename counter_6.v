/**
 * Content: 6 bit counter
 * Author: Vic Chan
 * Date: 4/6/2017
 */

`timescale 1ns / 1ps


module counter_6(Cnt, nCR, EN, CP);
    input CP, EN, nCR;
    output reg [3:0] Cnt;

    always @ (posedge CP or negedge nCR) begin
        if (~nCR)
            Cnt <= 4'b0000;
        else if (~EN)
            Cnt <= Cnt;
        else if (Cnt == 4'b0101)
            Cnt <= 4'b0000;
        else
            Cnt <= Cnt + 1'b1;
    end
endmodule //counter_6
