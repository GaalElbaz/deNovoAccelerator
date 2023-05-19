module topDesgin_tb();

	logic clk, rstN;
	logic [5:0] randA;
	logic [5:0] randB;
	logic unsigned [3:0][5:0] kmersSeqOne;
	logic unsigned [3:0][5:0] kmersSeqTwo;
	logic unsigned [2:0] jaccardSimilarity;
	
	topDesginModule myTopDesginTB(.clk(clk), .rstN(rstN), .randA(randA), .randB(randB), .kmersSeqOne(kmersSeqOne), .kmersSeqTwo(kmersSeqTwo), .jaccardSimilarity(jaccardSimilarity));
	
	always begin
		#40 clk = ~clk;
	end
	
	initial begin 
		clk = 1'b0;
		rstN = 1'b1;
		kmersSeqOne[0] = 10;
		kmersSeqOne[1] = 5;
		kmersSeqOne[2] = 20;
		kmersSeqOne[3] = 21;
		kmersSeqTwo[0] = 10;
		kmersSeqTwo[1] = 5;
		kmersSeqTwo[2] = 20;
		kmersSeqTwo[3] = 21;
		// first random couple.
		randA = 30;
		randB = 15;
		#20 rstN = 1'b0;
		#20
		kmersSeqOne[0] = 10;
		kmersSeqOne[1] = 5;
		kmersSeqOne[2] = 20;
		kmersSeqOne[3] = 21;
		kmersSeqTwo[0] = 10;
		kmersSeqTwo[1] = 5;
		kmersSeqTwo[2] = 20;
		kmersSeqTwo[3] = 21;
		// second random couple.
		randA = 23;
		randB = 10;
		#300
		$stop;
		$finish;
	end
	
	endmodule
	