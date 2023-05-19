	/*MIN FINDER MODULE*/
module minModule(
	/* input & output declarations:
		clk -> Global clk for all desgin.
		rstN -> Reset trigger, resets currRes variable.
		resArray -> A 49X32 size array representing the result of the hash function on each kmer.
		minVal -> A 32 bit array representing the minimum value in resArray.*/
		
	input logic rstN, clk,
	input logic unsigned [48:0][31:0] resArray,
	output logic [31:0] minVal
	);

	/* local parameters declartions:
		SIZE -> Number of kmers.*/
localparam SIZE = 49;

logic unsigned [31:0] currRes;
logic unsigned [1:0] waitForSecondClock;

always_ff @(posedge clk, posedge rstN) begin
	if(rstN == 1'b1) begin
		currRes <= 255;
		waitForSecondClock <= 0;
	end
	else begin
	if (waitForSecondClock == 1) begin
		currRes <= 255;
		for(int i = 0; i < SIZE; i++) begin
			if( resArray[i] < currRes) begin
				currRes = resArray[i];
				minVal = resArray[i];
			end
		end
	end
	else begin
		waitForSecondClock <= 2'b01;
	end
	end
end

endmodule
