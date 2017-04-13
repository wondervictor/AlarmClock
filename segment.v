`timescale 1ns / 1ps

module segment(num,seg);
	input [3:0] num;
	output reg [7:0] seg;
    always @ (num) begin
        case (num)
		    4'b0000:seg = 8'b00000011;
		    4'b0001:seg = 8'b10011111;
		    4'b0010:seg = 8'b00100101;
		    4'b0011:seg = 8'b00001101;
		    4'b0100:seg = 8'b10011001;
		    4'b0101:seg = 8'b01001001;
		    4'b0110:seg = 8'b01000001;
		    4'b0111:seg = 8'b00011011;
		    4'b1000:seg = 8'b00000001;
		    4'b1001:seg = 8'b00001001;
           4'hF:   seg = 8'b11111111;
			default:seg=8'b1111_1111; 
        endcase
    end
endmodule //segmet
