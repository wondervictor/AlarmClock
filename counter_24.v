/**
 * Content: 24 bit counter
 * Author: Vic Chan
 * Date: 4/6/2017
 */

`timescale 1ns / 1ps


module counter_24(CntH, CntL, nCR, EN, CP);
    input nCR, EN, CP;
	output reg [3:0] CntH, CntL;
    always @ (posedge CP or negedge nCR) begin
		if (~nCR)
			{CntH, CntL} <= 8'h00;
		else if (~EN)
		    {CntH, CntL} <= {CntH, CntL};
		else if ((CntH>2)||(CntL > 9)||((CntH==2)&&(CntL >=3)))
            {CntH, CntL}  <= 8'h00;
		else if (CntH == 2 && CntL < 3) begin
            CntH <= CntH;
        	CntL <= CntL + 1'b1;
		end
		else if (CntL == 9) begin
			CntH <= CntH + 1'b1;
            CntL <= 4'b0000;
		end
		else begin
			CntH <= CntH;
            CntL <= CntL + 1;
		end
	end

endmodule //counter_24
