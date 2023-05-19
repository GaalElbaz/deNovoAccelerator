	/*HASH MODULE*/
module hashModule(

	/* input & output declarations:
		clk -> Global clk for all desgin.
		rstN -> Not used in this module.
		randA, randB -> Numerical values for hash calculation.
		kmers -> A 49x32 size array representing the kmers of a 128 bit DNA sequence.
		hashResults -> A 49X32 size array representing the result of the hash function on each kmer.*/
	input logic clk, rstN,
	input logic [31:0] randA,
	input logic [31:0] randB,
	input logic unsigned [48:0][31:0] kmers,
	output logic unsigned [48:0][31:0] hashResults

);

	/* local parameters declartions:
		n -> Numerical value for hash calculation.
		SIZE -> Number of kmers.*/
localparam n = 32'd255;
localparam SIZE = 49;

always_ff @(posedge clk, posedge rstN) begin  
		if(rstN == 1'b1) begin
			end
		else begin
				for(int i=0; i< SIZE; i++) begin
						hashResults[i] = (((randA & kmers[i]) | randB) % n);
//						$display("hash is %d", hashResults[i]);
					end
			end
	end

endmodule



