// look in pins.pcf for all the pin names on the TinyFPGA BX board

module mbsFSK (
    input CLK,    // 16MHz clock
    input PIN_24,     //SW2
    output PIN_18,    //GPIO2
    output PIN_19    //GPIO1
);

    // drive USB pull-up resistor to '0' to disable USB
    // assign USBPU = 0;

    wire SW2;
    reg GPIO1, GPIO2;
    reg SW2_d, SW2_sync;
    wire outReal, outImag, ready, shift;
    wire [18:0] dataOut;

    //Switches
    assign SW2 = PIN_24;

    assign PIN_19 = GPIO1;
    assign PIN_18 = GPIO2;

    //RF Switch inputs
    //A1 A0 | RFX
    //------|----
    //0  0  | RF1 (DTC#1 PE64102, Z0)
    //0  1  | RF2 (DTC#2 PE64909, Z1)
    //1  0  | RF3 (130 ohms)
    //1  1  | RF4 (19.1 ohms)
    // assign GPIO1 = ~(outImag);//~((gfskOSC^gfskOSC_90d));//||SW2_sync);// && SW1_sync;//SW2_sync;  //A0
    // assign GPIO2 = outReal;////SW1_sync;  //A1

    always @(*)
      begin
        if(outReal && outImag)  //RF4_19ohms
          begin
            GPIO1 = 1'b1;
            GPIO2 = 1'b0;
          end
        else if(outReal && ~outImag)
          begin
            GPIO1 = 1'b0;
            GPIO2 = 1'b0;
          end
        else if(~outReal && outImag)
          begin
            GPIO1 = 1'b0;
            GPIO2 = 1'b1;
          end
        else //if(~outReal && ~outImag)
          begin
            GPIO1 = 1'b1;
            GPIO2 = 1'b1;
          end
      end

    always @(posedge CLK)
    begin
        SW2_d      <= SW2;
        SW2_sync   <= SW2_d;
    end


    sampleClockGen #(.CLK_DIV(1),  .CLK_TOTAL(128)) sampClockBlock (
        .CLOCK(CLK),
        .RESET(SW2_sync),
        .SAMP(ready),
        .SHIFT(shift));

   SymbLUT symbolLUT (
  	.CLOCK(CLK),
  	.RESET(SW2_sync),
  	.READY(ready),
  	.SHIFT(shift),
  	.ADDRESS(dataOut[18:14]),
  	.DOUTREAL(outReal),
  	.DOUTIMAG(outImag));

    LFSRmod prnGen (
  	.CLOCK(CLK),
  	.RESET(SW2_sync),
  	.ENABLE(ready),
  	.OUTDATA(dataOut));

endmodule
