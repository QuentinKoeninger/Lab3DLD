`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  [7:0] sw;
   logic  reset;
   
   logic  [7:0] led;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, sw[7], sw[0], sw[3], led[5], led[6], led[7], led[2], led[1], led[0]);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#600 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b %b %b %b || %b %b %b 0 0 %b %b %b", 
		     reset, sw[7], sw[0], sw[3], led[7], led[6], led[5], led[2], led[1], led[0]);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#41  reset = 1'b0;	
	#0   sw[7:0] = 8'b10000000;
	#80  sw[7:0] = 8'b00000000;
	#20  sw[7:0] = 8'b00000001;
     #80  sw[7:0] = 8'b00000000;
     #20  sw[7:0] = 8'b10000001;
     #80  reset = 1'b1;
     #40  reset = 1'b0;
     #0  sw[7:0] = 8'b00000001;
     #40 sw[7:0] = 8'b00001001;
     #80 sw[7:0] = 8'b10000000;
     end

endmodule // FSM_tb

