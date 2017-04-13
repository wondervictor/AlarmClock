/**
 * Content: 10 bit counter
 * Author: Vic Chan
 * Date: 4/6/2017
 */

module counter_10(Cnt, nCR, EN, CP);
    input CP, EN, nCR;
    output reg [3:0] Cnt;
	
    always @ (posedge CP or negedge nCR) begin
        if (~nCR)
            Cnt <= 4'b0000;
        else if (~EN)
            Cnt <= Cnt;
        else if (Cnt == 4'b1001)
            Cnt <= 4'b0000;
        else
            Cnt <= Cnt + 1'b1;
    end
endmodule //counter_10
