module SymbLUT(CLOCK, RESET, READY, SHIFT, ADDRESS, DOUTREAL, DOUTIMAG);
	input wire CLOCK;
	input wire RESET;
	input wire READY;
	input wire SHIFT;
	input wire [4:0] ADDRESS;
	output reg DOUTREAL;
	output reg DOUTIMAG;

	wire [127:0] dataREAL [31:0];
	wire [127:0] dataIMAG [31:0];
	reg [4:0]	 dataADDR_d,dataADDR_q;
	reg [127:0] databuffREAL,databuffIMAG;

	always @(*)
	 	begin
			DOUTREAL = databuffREAL[127];
			DOUTIMAG = databuffIMAG[127];
		end

	always @(posedge CLOCK)
		begin
			if(RESET)
			begin
				dataADDR_d <= 0;
				databuffREAL <= 0;
				databuffIMAG <= 0;
			end
			else
			begin

			/////////// UPDATE LUT ADDRESS  ////////////

				if(READY)
				begin
					dataADDR_d <= ADDRESS;
					databuffREAL <= dataREAL[dataADDR_q];
					databuffIMAG <= dataIMAG[dataADDR_q];
				end
				else
				begin
					dataADDR_d <= dataADDR_d;

					if(SHIFT)
					begin
						databuffREAL <= {databuffREAL[126:0],1'b0};
						databuffIMAG <= {databuffIMAG[126:0],1'b0};
					end
				end

			/////////// 	SHIFT DATA		 ////////////

			end
		end

	always @(posedge CLOCK)
		begin
			if(RESET)
			begin
				dataADDR_q <= 0;
			end
			else
			begin
				dataADDR_q <= dataADDR_d;
			end
		end

	assign dataREAL[0] = 128'b00110000000011001100001110000011100110111111111001111100111111011101111110011111001111111110110011100000111000011001100000000110;
	assign dataREAL[1] = 128'b00011000000110011000001101100011110011001101110011111001001110111110111001001111100111011001100111100011011000001100110000001100;
	assign dataIMAG[0] = 128'b11100100111110011001111100111111001111111111110111100001111100111001100000111100001000000000000110000001100000110011000001101100;
	assign dataIMAG[1] = 128'b11110011011100111100111011001111101110111011100111100011111000111001110000011100001100010001000110000110010001100001100010011000;
	assign dataREAL[2] = 128'b00001100011001001000000110000011101000110011000011111100111111111111111110011111100001100110001011100000110000001001001100011000;
	assign dataREAL[3] = 128'b00011100000100110010001111000110110001101111100111111000111101110111011110001111110011111011000110110001111000100110010000011100;
	assign dataREAL[4] = 128'b00100011000011001000110000110001101100011110011011100111001111001001111001110011101100111100011011000110000110001001100001100010;
	assign dataREAL[5] = 128'b00000001000011110000011001100000111010011100100111111011001111110111111001101111110010011100101110000011001100000111100001000000;
	assign dataREAL[6] = 128'b00000110000001100000100110011000111100111111001111101110111111100011111110111011111001111110011110001100110010000011000000110000;
	assign dataREAL[7] = 128'b10001100000000110001001100000100111000011111000110011111011111100011111101111100110001111100001110010000011001000110000000011000;
	assign dataREAL[8] = 128'b00100000011000001100000000010011000111110001111001100111111110011100111111110011001111000111110001100100000000011000001100000010;
	assign dataREAL[9] = 128'b00010001101100001110001001100110000111001001111110110011111100111110011111100110111111001001110000110011001000111000011011000100;
	assign dataREAL[10] = 128'b00000000011000001111100110011101000111110011111111101100111001111111001110011011111111100111110001011100110011111000001100000000;
	assign dataREAL[11] = 128'b10001000011100000011000001001110010011100001110110011011111000111110001111101100110111000011100100111001000001100000011100001000;
	assign dataREAL[12] = 128'b01100001100011001100110000111001001110011110011111100111100111011101110011110011111100111100111001001110000110011001100011000011;
	assign dataREAL[13] = 128'b10000001100100000011011000110100011111001100111110000111101111111111111011110000111110011001111100010110001101100000010011000000;
	assign dataREAL[14] = 128'b11000000010001000001100000011000011100110011011111001111110011111111100111111001111101100110011100001100000011000001000100000001;
	assign dataREAL[15] = 128'b11000000100000110011100000111100011011111001101110011111111001110111001111111100111011001111101100011110000011100110000010000001;
	assign dataREAL[16] = 128'b00111111011111001100011111000011100100000110010001100000000110001000110000000011000100110000010011100001111100011001111101111110;
	assign dataREAL[17] = 128'b00111111101110111110011111100111100011001100100000110000001100000000011000000110000010011001100011110011111100111110111011111110;
	assign dataREAL[18] = 128'b01111110011011111100100111001011100000110011000001111000010000000000000100001111000001100110000011101001110010011111101100111111;
	assign dataREAL[19] = 128'b10011110011100111011001111000110110001100001100010011000011000100010001100001100100011000011000110110001111001101110011100111100;
	assign dataREAL[20] = 128'b01110111100011111100111110110001101100011110001001100100000111000001110000010011001000111100011011000110111110011111100011110111;
	assign dataREAL[21] = 128'b11111111100111111000011001100010111000001100000010010011000110000000110001100100100000011000001110100011001100001111110011111111;
	assign dataREAL[22] = 128'b11101110010011111001110110011001111000110110000011001100000011000001100000011001100000110110001111001100110111001111100100111011;
	assign dataREAL[23] = 128'b11011111100111110011111111101100111000001110000110011000000001100011000000001100110000111000001110011011111111100111110011111101;
	assign dataREAL[24] = 128'b01110011111111001110110011111011000111100000111001100000100000011100000010000011001110000011110001101111100110111001111111100111;
	assign dataREAL[25] = 128'b11111001111110011111011001100111000011000000110000010001000000011100000001000100000110000001100001110011001101111100111111001111;
	assign dataREAL[26] = 128'b11111110111100001111100110011111000101100011011000000100110000001000000110010000001101100011010001111100110011111000011110111111;
	assign dataREAL[27] = 128'b11011100111100111111001111001110010011100001100110011000110000110110000110001100110011000011100100111001111001111110011110011101;
	assign dataREAL[28] = 128'b11100011111011001101110000111001001110010000011000000111000010001000100001110000001100000100111001001110000111011001101111100011;
	assign dataREAL[29] = 128'b11110011100110111111111001111100010111001100111110000011000000000000000001100000111110011001110100011111001111111110110011100111;
	assign dataREAL[30] = 128'b11100111111001101111110010011100001100110010001110000110110001000001000110110000111000100110011000011100100111111011001111110011;
	assign dataREAL[31] = 128'b11001111111100110011110001111100011001000000000110000011000000100010000001100000110000000001001100011111000111100110011111111001;
	assign dataIMAG[0] = 128'b11100100111110011001111100111111001111111111110111100001111100111001100000111100001000000000000110000001100000110011000001101100;
	assign dataIMAG[1] = 128'b11110011011100111100111011001111101110111011100111100011111000111001110000011100001100010001000110000110010001100001100010011000;
	assign dataIMAG[2] = 128'b11111000110011111011111100011111111011101110011111110001110010011011011000111000000011000100010010000011100000010000011001110000;
	assign dataIMAG[3] = 128'b10111000111001100110111100011111100111111111001111110011111001001110110000011000000110000000001100000011100001001100110001110001;
	assign dataIMAG[4] = 128'b11101110001111011011110111110111111001111100111111001100111110011011000001100110000001100000110010001000001000010010000111000100;
	assign dataIMAG[5] = 128'b10110110001111100111110011101111110110111001111111100110011100001111100011001100000000110001001000000100011000001100000111001001;
	assign dataIMAG[6] = 128'b10011100110111000011101100111011110001111110011111011001110110001111001000110010000011000000111000010001100100011110001001100011;
	assign dataIMAG[7] = 128'b10011000001111100111111111111101110011111110011100110011111111001110000000011001100011000000011000100000000000001100000111110011;
	assign dataIMAG[8] = 128'b11100111110000111101111111111110011111100111110011001111100100111001101100000110011000001100000011000000000000100001111000001100;
	assign dataIMAG[9] = 128'b11100011111000111100111011101110111110011011100111100111011001111000110010001100001100010011000011000100010001100001110000011100;
	assign dataIMAG[10] = 128'b11001001110001111111001110111011111111000111111011111001100011111000011100110000010000001110000010010001000110000000111000110110;
	assign dataIMAG[11] = 128'b10010011111001111110011111111100111111000111101100110011100011101100011100011001100100001110000001100000000011000000110000011011;
	assign dataIMAG[12] = 128'b11001111100110011111100111110011111101111101111011011110001110111001000111000010010000100000100010011000001100000011001100000110;
	assign dataIMAG[13] = 128'b10000111001100111111110011101101111110111001111100111110001101101100100111000001100000110001000000100100011000000001100110001111;
	assign dataIMAG[14] = 128'b10001101110011011111001111110001111011100110111000011101100111001110001100100011110001001100010000111000000110000010011000100111;
	assign dataIMAG[15] = 128'b10011111111001100111001111111001110111111111111100111110000011001110011111000001100000000000001000110000000110001100110000000011;
	assign dataIMAG[16] = 128'b11100000000110011000110000000110001000000000000011000001111100111001100000111110011111111111110111001111111001110011001111111100;
	assign dataIMAG[17] = 128'b11110010001100100000110000001110000100011001000111100010011000111001110011011100001110110011101111000111111001111101100111011000;
	assign dataIMAG[18] = 128'b11111000110011000000001100010010000001000110000011000001110010011011011000111110011111001110111111011011100111111110011001110000;
	assign dataIMAG[19] = 128'b10110000011001100000011000001100100010000010000100100001110001001110111000111101101111011111011111100111110011111100110011111001;
	assign dataIMAG[20] = 128'b11101100000110000001100000000011000000111000010011001100011100011011100011100110011011110001111110011111111100111111001111100100;
	assign dataIMAG[21] = 128'b10110110001110000000110001000100100000111000000100000110011100001111100011001111101111110001111111101110111001111111000111001001;
	assign dataIMAG[22] = 128'b10011100000111000011000100010001100001100100011000011000100110001111001101110011110011101100111110111011101110011110001111100011;
	assign dataIMAG[23] = 128'b10011000001111000010000000000001100000011000001100110000011011001110010011111001100111110011111100111111111111011110000111110011;
	assign dataIMAG[24] = 128'b11100111110000011000000000000010001100000001100011001100000000111001111111100110011100111111100111011111111111110011111000001100;
	assign dataIMAG[25] = 128'b11100011001000111100010011000100001110000001100000100110001001111000110111001101111100111111000111101110011011100001110110011100;
	assign dataIMAG[26] = 128'b11001001110000011000001100010000001001000110000000011001100011111000011100110011111111001110110111111011100111110011111000110110;
	assign dataIMAG[27] = 128'b10010001110000100100001000001000100110000011000000110011000001101100111110011001111110011111001111110111110111101101111000111011;
	assign dataIMAG[28] = 128'b11000111000110011001000011100000011000000000110000001100000110111001001111100111111001111111110011111100011110110011001110001110;
	assign dataIMAG[29] = 128'b10000111001100000100000011100000100100010001100000001110001101101100100111000111111100111011101111111100011111101111100110001111;
	assign dataIMAG[30] = 128'b10001100100011000011000100110000110001000100011000011100000111001110001111100011110011101110111011111001101110011110011101100111;
	assign dataIMAG[31] = 128'b10011011000001100110000011000000110000000000001000011110000011001110011111000011110111111111111001111110011111001100111110010011;


endmodule