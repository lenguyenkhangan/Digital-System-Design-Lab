// Top-level: A = SW[2], B = SW[1], Cin = SW[0], LEDG[1] = Sum, LEDG[0] = Cout
module lab1_ex3(SW, LEDG, LEDR);
	input  [17:0] SW;
	output [7:0]  LEDG;
	output [17:0] LEDR;

	assign LEDR      = SW;
	assign LEDG[7:2] = 6'b0;

	// Change model here: full_adder_DF / full_adder_BH1 / full_adder_BH2 / full_adder_BH / full_adder_STRU
	full_adder_DF DUT ( .a(SW[2]), .b(SW[1]), .cin(SW[0]), .S(LEDG[1]), .Cout(LEDG[0]) );
endmodule

// Dataflow model:
module full_adder_DF(input a, b, cin, output S, Cout);
  assign S = a ^ b ^ cin;
  assign Cout = (a & b) | (b & cin) | (a & cin);
endmodule

//Behavior Model using case :
module full_adder_BH1(input a, b, cin, output reg S, output reg Cout);
 always @(a or b or cin)
  begin
   case ({a, b, cin})
     3'b000: begin S = 0; Cout = 0; end
     3'b001: begin S = 1; Cout = 0; end
     3'b010: begin S = 1; Cout = 0; end
     3'b011: begin S = 0; Cout = 1; end
     3'b100: begin S = 1; Cout = 0; end
     3'b101: begin S = 0; Cout = 1; end
     3'b110: begin S = 0; Cout = 1; end
     3'b111: begin S = 1; Cout = 1; end
   endcase
  end
endmodule

//Behavior Model using if else :
module full_adder_BH2(input a, b, cin, output reg S, output reg Cout);
always @(a or b or cin)
begin
 if(a==0 && b==0 && cin==0)
  begin S=0; Cout=0; end
 else if(a==0 && b==0 && cin==1)
  begin S=1; Cout=0; end
 else if(a==0 && b==1 && cin==0)
  begin S=1; Cout=0; end
 else if(a==0 && b==1 && cin==1)
  begin S=0; Cout=1; end
 else if(a==1 && b==0 && cin==0)
  begin S=1; Cout=0; end
 else if(a==1 && b==0 && cin==1)
  begin S=0; Cout=1; end
 else if(a==1 && b==1 && cin==0)
  begin S=0; Cout=1; end
 else
  begin S=1; Cout=1; end
end
endmodule

//Behavior Model using always + expressions :
module full_adder_BH(input a, b, cin, output reg S, output reg Cout);
	always @(a, b, cin)
	  begin
		S    = a ^ b ^ cin;
		Cout = (a & b) | (b & cin) | (cin & a);
	  end
endmodule

//Gate-level (Structural Model)  :
module full_adder_STRU(input a, b, cin, output S, Cout);
	wire x, y, z;
	xor g1(x, a, b);
	xor g2(S, x, cin);
	and g3(y, x, cin);
	and g4(z, a, b);
	or  g5(Cout, y, z);
endmodule
