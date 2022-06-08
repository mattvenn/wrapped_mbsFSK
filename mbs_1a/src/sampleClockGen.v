/*======================================================================================================
Code: sampleClockGen.sv
Description: Counters to provide the sample and symbol clock
Notes:
Date: 05.13.2020
Author: James Rosenthal
========================================================================================================*/

module sampleClockGen #(parameter CLK_DIV = 2,  CLK_TOTAL=127)(
			input CLOCK, RESET,
			//input [1:0] packetRate,
			output SAMP, SHIFT
			);

//	reg [31:0] count;
	reg sample, shift;
	reg [6:0] pulseCount;

	assign SAMP = sample;
	assign SHIFT = shift;


//%%%%%%%%%%%%%% NEW LOGIC %%%%%%%%%%%%%%%%//
	always @(posedge CLOCK)
		begin
			if(RESET)
			begin
				pulseCount <= 0;
			//	count  <= 0;
				sample <=  0;
				shift  <=  0;
			end
//			else if(count == CLK_DIV-1)
			else
			begin
				if(pulseCount == CLK_TOTAL-1)
				begin
					pulseCount <= 0;
					sample <=  1;
					shift  <=  0;	//consider leaving shift 0 when new samples are taken
			//		count  <= 0;
				end
				else
				begin
					pulseCount <= pulseCount + 1'b1;
					sample <=  0;
					shift	 <=  1;
			//		count  <= 0;
				end
			end
			//else
			//begin
			//	pulseCount <= pulseCount;
			//	sample <= 0;
			//	shift	 <= 0;
			//	count  <= count + 1'b1;
			//end
		end

endmodule

