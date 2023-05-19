	/*TOP DESGIN MODULE*/
module topDesginModule(
	input logic clk, rstN,
	input logic [31:0] randA,
	input logic [31:0] randB,
	input logic unsigned [48:0][31:0] kmersSeqOne,
	input logic unsigned [48:0][31:0] kmersSeqTwo,
	output logic unsigned [4:0] jaccardSimilarity

);
	logic unsigned [48:0][31:0] hashResultsSeqOne;
	logic unsigned [48:0][31:0] hashResultsSeqTwo;
	logic [31:0] minValSeqOne;
	logic [31:0] minValSeqTwo;
	
	
	hashModule firstHashInstance(.clk(clk), .rstN(rstN), .randA(randA), .randB(randB), .kmers(kmersSeqOne), .hashResults(hashResultsSeqOne));
	hashModule secondHashInstance(.clk(clk), .rstN(rstN), .randA(randA), .randB(randB), .kmers(kmersSeqTwo), .hashResults(hashResultsSeqTwo));

	minModule firstMinInstance(.clk(clk), .rstN(rstN), .resArray(hashResultsSeqOne), .minVal(minValSeqOne));
	minModule secondMinInstance(.clk(clk), .rstN(rstN), .resArray(hashResultsSeqTwo), .minVal(minValSeqTwo));
	
	counterModule counterInstance(.clk(clk), .rstN(rstN) ,.minValFirstSeq(minValSeqOne), .minValSecondSeq(minValSeqTwo), .jaccardSimilarity(jaccardSimilarity));
	
endmodule
