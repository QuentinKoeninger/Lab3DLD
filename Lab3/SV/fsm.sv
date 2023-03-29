module FSM (clk, reset, Lin, Rin, H, Li, Lm, Lo, Ri, Rm, Ro);

   input logic  clk;
   input logic  reset;
   input logic 	Lin;
   input logic  Rin;
   input logic  H;
   
   output logic Li;
   output logic Lm;
   output logic Lo;
   output logic Ri;
   output logic Rm;
   output logic Ro;

   logic L;
   logic R;

   typedef enum 	logic [1:0] {S0, S1, S2, S3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (H)
      1'b1: begin
        L <= 1'b1;
        R <= 1'b1;
      end
      default: begin
        L <= Lin;
        R <= Rin;
      end
     endcase
     
   always_comb
     case (state)
       S0: begin
	      // y <= 1'b0;	  
	      // if (a) nextstate <= S0;
	      // else   nextstate <= S1;

        Li <= 1'b0;
        Lm <= 1'b0;
        Lo <= 1'b0;
        Ri <= 1'b0;
        Rm <= 1'b0;
        Ro <= 1'b0;

        if (L || R) nextstate <= S1;
        else nextstate <= S0;
       end
       S1: begin
	      // y <= 1'b0;	  	  
	      // if (a) nextstate <= S2;
	      // else   nextstate <= S1;

        if (L) begin
          Li <= 1'b1;
          Lm <= 1'b0;
          Lo <= 1'b0;
        end else begin
          Li <= 1'b0;
          Lm <= 1'b0;
          Lo <= 1'b0;
        end
        if (R) begin
          Ri <= 1'b1;
          Rm <= 1'b0;
          Ro <= 1'b0;
        end else begin
          Ri <= 1'b0;
          Rm <= 1'b0;
          Ro <= 1'b0;
        end

        if (L || R) nextstate <= S2;
        else nextstate <= S0;
       end
       S2: begin
	      // y <= 1'b1;	  	  
	      // if (a) nextstate <= S2;
	      // else   nextstate <= S0;

        if (L) begin
          Li <= 1'b1;
          Lm <= 1'b1;
          Lo <= 1'b0;
        end else begin
          Li <= 1'b0;
          Lm <= 1'b0;
          Lo <= 1'b0;
        end
        if (R) begin
          Ri <= 1'b1;
          Rm <= 1'b1;
          Ro <= 1'b0;
        end else begin
          Ri <= 1'b0;
          Rm <= 1'b0;
          Ro <= 1'b0;
        end

        if (L || R) nextstate <= S3;
        else nextstate <= S0;
       end
       S3: begin
	      // y <= 1'b1;	  	  
	      // if (a) nextstate <= S2;
	      // else   nextstate <= S0;

        if (L) begin
          Li <= 1'b1;
          Lm <= 1'b1;
          Lo <= 1'b1;
        end else begin
          Li <= 1'b0;
          Lm <= 1'b0;
          Lo <= 1'b0;
        end
        if (R) begin
          Ri <= 1'b1;
          Rm <= 1'b1;
          Ro <= 1'b1;
        end else begin
          Ri <= 1'b0;
          Rm <= 1'b0;
          Ro <= 1'b0;
        end

        nextstate <= S0;
       end
       default: begin
	      Li <= 1'b0;
        Lm <= 1'b0;
        Lo <= 1'b0;
        Ri <= 1'b0;
        Rm <= 1'b0;
        Ro <= 1'b0;	  	  
	      nextstate <= S0;
       end
     endcase
   
endmodule
