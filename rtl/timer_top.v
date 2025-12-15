module timer_top (
	input sys_clk,
	input sys_rst_n,
	input tim_psel,
	input tim_penable,
	input wire [11:0] tim_paddr,
	input wire [31:0] tim_pwdata,
	input wire [3:0] tim_pstrb,
	input tim_pwrite,
	input dbg_mode,

	output wire [31:0] tim_prdata,
	output tim_pready,
	output tim_pslverr,
	output tim_int

);


	wire [3:0] div_val;
	wire wr_en, rd_en, div_en, timer_en, halt_req, halt_ack, int_en, int_st, cnt_en;
	wire [31:0] rdata;

	apb_slave u (
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.tim_psel(tim_psel),
		.tim_pwrite(tim_pwrite),
		.tim_penable(tim_penable),
		.tim_pready(tim_pready),

		.wr_en(wr_en),
		.rd_en(rd_en),
		.rdata(rdata),
		.prdata(tim_prdata)
	);

	register uu(
		.wr_en(wr_en),
		.rd_en(rd_en),
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.tim_pwdata(tim_pwdata),
		.tim_pstrb(tim_pstrb),
		.tim_paddr(tim_paddr),
		.halt_ack(halt_ack),
		.cnt_en(cnt_en),

		.div_en(div_en),
		.div_val(div_val),
		.halt_req(halt_req),
		.timer_en(timer_en),
		.int_en(int_en),
		.int_st(int_st),
		.rdata(rdata),
		.pslverr(tim_pslverr),
		.pready(tim_pready)
	);

	counter_ctrl uuu(
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.div_en(div_en),
		.div_val(div_val),
		.timer_en(timer_en),
		.halt_req(halt_req),
		.dbg_mode(dbg_mode),
		
		.cnt_en(cnt_en),
		.halt_ack(halt_ack)
	);

	interrupt uuuu(
		.int_en(int_en),
		.int_st(int_st),
		.tim_int(tim_int)
	);

	endmodule












