	/*COUNTER MODULE*/
module counterModule(
	/* input & output declarations:
		clk -> Global clk for all desgin.
		rstN -> Reset trigger, resets the jaccardSimilarity variable.
		minValFirstSeq -> A 32 size array representing the minimum value given from the minModule of first DNA sequence.
		minValSecondSeq -> A 32 size array representing the minimum value given from the minModule of second DNA sequence.
		jaccardSimilarity -> A 4 bit value represents the similarity bettwen two DNA sequences.*/
		
	input logic clk, rstN,
	input logic [31:0] minValFirstSeq,
	input logic [31:0] minValSecondSeq,
	output logic unsigned [4:0] jaccardSimilarity
);

logic unsigned [2:0] waitForThirdClock;


always_ff @(posedge clk, posedge rstN) begin
		if(rstN == 1'b1) begin
			jaccardSimilarity <= 0;
			waitForThirdClock <= 0;
		end
		else begin
			if(waitForThirdClock == 2) begin
				if(minValFirstSeq == minValSecondSeq) begin
					jaccardSimilarity <= jaccardSimilarity + 1;
				end
			end
			else begin
				waitForThirdClock <= waitForThirdClock + 3'b001;
			end
		end
	end

endmodule
