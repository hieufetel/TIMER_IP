module apb_slave (
	input sys_clk,
	input sys_rst_n,
	input tim_psel,
      	input tim_pwrite,
	input tim_penable,
	input wire [31:0] rdata,

	output tim_pready,
	output wr_en,
	output rd_en,
	output wire [31:0] prdata
);
	
	reg wr_pre, rd_pre;
	wire wr_en_pre, rd_en_pre;

	assign	wr_en_pre = tim_psel & tim_pwrite  & tim_penable & ~wr_en ;
	assign  rd_en_pre = tim_psel & ~tim_pwrite & tim_penable & ~rd_en ;

	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin 
			wr_pre <= 0;
			rd_pre <= 0;
		end else begin
			wr_pre <= wr_en_pre;
			rd_pre <= rd_en_pre;
		end 
	end
	assign wr_en = wr_pre;
	assign rd_en = rd_pre;
	assign tim_pready = wr_en | rd_en;
	assign prdata = rdata;
	
	endmodule

