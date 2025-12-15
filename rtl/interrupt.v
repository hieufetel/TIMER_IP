module interrupt (
	input int_en,
	input int_st,
	output tim_int
);

assign tim_int = int_en & int_st;

endmodule
