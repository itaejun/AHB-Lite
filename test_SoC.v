//----------------------------------------------------------------------------
//The information contained in this file may only be used by a person
//authorised under and to the extent permitted by a subsisting licensing 
//agreement from Arm Limited or its affiliates 
//
//(C) COPYRIGHT 2020 Arm Limited or its affiliates
//ALL RIGHTS RESERVED.
//Licensed under the ARM EDUCATION INTRODUCTION TO COMPUTER ARCHITECTURE 
//EDUCATION KIT END USER LICENSE AGREEMENT.
//See https://www.arm.com/-/media/Files/pdf/education/computer-architecture-education-kit-eula
//
//This entire notice must be reproduced on all copies of this file
//and copies of this file may only be made by a person if such person is
//permitted to do so under the terms of a subsisting license agreement
//from Arm Limited or its affiliates.
//----------------------------------------------------------------------------
`timescale 10ms/1ms
	
module test_SoC();

	// Clock feeds to SoC 
	reg 		clk = 0;
	reg         nreset;             // Active low reset

	// UART
	reg			uart_rxd;
	wire		uart_txd;

	// LED
	wire	[7:0]	led;
	
	// 7_SEGMENT
	wire	[6:0]	hex0;
	wire	[6:0]	hex1;
	wire	[6:0]	hex2;
	wire	[6:0]	hex3;

	// GPIO
	reg		[7:0]	SW;

	
	// Clock ratio for SoC. 
	// Changing the ratio and phase can produce unpredictable results. 
	always #1 clk = ~clk;

	// nreset input
	initial begin
		nreset   	<= 0;
		#(10)
		nreset   	<= 1;
	end

	// peripherals
	initial begin
		SW = 0;
		uart_rxd	<= 1;
	end

	// SoC instantiation
	AHBLITE_SYS	SoC (
		.CLK			(clk),
		.RESET			(nreset),
		.RESET_O		(),
		
		// UART
		.UART_RXD		(uart_rxd),
		.UART_TXD		(uart_txd),
		
		// 7_SEG
		.HEX0			(hex0),
		.HEX1			(hex1),
		.HEX2			(hex2),
		.HEX3			(hex3),
		
		//GPIO I/O
		.SW				(SW),
		.LEDR			(led),
		// ETC
		.TCK_SWCLK		(),
		.TDI_NC			(),
		.TMS_SWDIO		(),
		.TDO_SWO		()
	);
	
	// Siganals dump for debugging
	initial
	begin
		
		#(500)
		SW = 8'b0000_0001;
		#(500)
		SW = 8'b0000_0010;
		#(500)
		SW = 8'b0000_0100;
		#(500)
		SW = 8'b0000_1000;
		#(500)
		SW = 8'b0001_0000;
		#(500)
		SW = 8'b0010_0000;
		#(500)
		SW = 8'b0100_0000;
		#(500)

		#(2000000)
		$finish;
	end

endmodule
