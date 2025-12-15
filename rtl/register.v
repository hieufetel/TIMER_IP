module register 
#(
	parameter TCR 	= 12'h00,
	parameter TDR0	= 12'h04,
	parameter TDR1	= 12'h08,
	parameter TCMP0	= 12'h0c,
	parameter TCMP1 = 12'h10,
	parameter TIER	= 12'h14,
	parameter TISR 	= 12'h18,
	parameter THCSR = 12'h1c
)
(
	input 		wr_en,
	input 		rd_en,
	input [3:0]     tim_pstrb,
	input [31:0]    tim_pwdata,
	input [11:0]    tim_paddr,
	input 		sys_clk,
	input 		sys_rst_n,
	input 		halt_ack,
	input 		cnt_en,
	input		pready,

	output reg div_en,
	output reg [3:0] div_val,
	output reg halt_req,
	output reg timer_en,
	output reg int_en,
	output reg int_st,
	output reg [31:0] rdata,
	output pslverr

);	

	//TCR
	wire tcr_wr_sel;
      	wire tcr_wr_sel_pre;

	assign tcr_wr_sel = wr_en & (tim_paddr == TCR) ;
	assign tcr_wr_sel_pre = (tim_pwdata[11:8] <= 8) & tcr_wr_sel & tim_pstrb[1];	
	
	wire [3:0] div_val_pre;	
	wire div_en_pre, timer_en_pre;
	assign div_val_pre = (tcr_wr_sel_pre && ~pslverr) ? tim_pwdata[11:8] : div_val;
	assign div_en_pre  = (tcr_wr_sel && tim_pstrb[0] && ~pslverr) ? tim_pwdata[1] : div_en;
	assign timer_en_pre = (tcr_wr_sel && tim_pstrb[0] && ~pslverr) ? tim_pwdata[0] : timer_en;

	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			timer_en <= 1'b0;
			div_val  <= 4'b0001;
			div_en 	 <= 1'b0;
		end else begin
			timer_en <= timer_en_pre;
			div_val <= div_val_pre;
			div_en  <= div_en_pre;
		end
	end
	wire [31:0] tcr;
	assign tcr = {20'h0, div_val, 6'h0, div_en, timer_en};
		

	//TDR0; TDR1
	
	wire tdr0_wr_sel;
	wire tdr1_wr_sel;
	reg [31:0] tdr0;
	reg [31:0] tdr1;
	assign tdr0_wr_sel = wr_en & (tim_paddr == TDR0);
	assign tdr1_wr_sel = wr_en & (tim_paddr == TDR1);

	reg timer_en_d;
	wire timer_en_negedge;
	always @(posedge sys_clk or negedge sys_rst_n) begin 
		if(!sys_rst_n) begin
			timer_en_d <= 1'b0;
		end else begin
			timer_en_d <= timer_en;
		end 
	end

	assign timer_en_negedge = (timer_en_d == 1) && (timer_en == 0);


	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
		       tdr0 <= 32'h0;
		       tdr1 <= 32'h0;
	       	end else begin 
				if(tdr0_wr_sel) begin
					if(tim_pstrb[0]) begin
						tdr0[7:0] <= tim_pwdata[7:0];
					end else begin
						tdr0[7:0] <= tdr0[7:0];
					end
					if(tim_pstrb[1]) begin
						tdr0[15:8] <= tim_pwdata[15:8];
					end else begin
						tdr0[15:8] <= tdr0[15:8];
					end
					if(tim_pstrb[2]) begin
						tdr0[23:16] <= tim_pwdata[23:16];
					end else begin
						tdr0[23:16] <= tdr0[23:16];
					end
					if(tim_pstrb[3]) begin
						tdr0[31:24] <= tim_pwdata[31:24];
					end else begin
						tdr0[31:24] <= tdr0[31:24];
					end
				end else if (timer_en_negedge == 1'b1) begin 
				 	tdr0 <= 32'h0; 
				end else begin
					if(cnt_en) begin
						if(tdr0 == 32'hffff_ffff) begin
							tdr0 <= 32'h0;
						end else begin
							tdr0 <= tdr0 + 1;
						end
					end else begin
						tdr0 <= tdr0;
					end
				end

	
				if(tdr1_wr_sel) begin
						if(tim_pstrb[0]) begin
							tdr1[7:0] <= tim_pwdata[7:0];
						end else begin
							tdr1[7:0] <= tdr1[7:0];
						end
						if(tim_pstrb[1]) begin
							tdr1[15:8] <= tim_pwdata[15:8];
						end else begin
							tdr1[15:8] <= tdr1[15:8];
						end
						if(tim_pstrb[2]) begin
							tdr1[23:16] <= tim_pwdata[23:16];
						end else begin
							tdr1[23:16] <= tdr1[23:16];
						end
						if(tim_pstrb[3]) begin
							tdr1[31:24] <= tim_pwdata[31:24];
						end else begin
							tdr1[31:24] <= tdr1[31:24];
						end
					end else if(timer_en_negedge == 1'b1) begin 
						tdr1 <= 32'h0;
					end else begin
						if(cnt_en) begin
							if(tdr0 == 32'hffff_ffff) begin
								if(tdr1 == 32'hffff_ffff) begin
									tdr1 <= 32'h0;
								end else begin
									tdr1 <= tdr1 + 1;
								end
							end
						end else begin
							tdr1 <= tdr1;	
						end
					end

		end
	end
	wire [63:0] tdr; 
	assign tdr = {tdr1, tdr0};

	//TCMP
	
	wire tcmp0_wr_sel, tcmp1_wr_sel;
	assign tcmp0_wr_sel = wr_en & (tim_paddr == TCMP0);
	assign tcmp1_wr_sel = wr_en & (tim_paddr == TCMP1);

	reg [31:0] tcmp0, tcmp1;

	always @(posedge sys_clk or negedge sys_rst_n) begin 
		if(!sys_rst_n) begin
			tcmp0 <= 32'hffff_ffff;
			tcmp1 <= 32'hffff_ffff;
		end else begin 
			if(tcmp0_wr_sel) begin
				if(tim_pstrb[0]) begin
				       tcmp0[7:0] <= tim_pwdata[7:0];
			        end else begin
				       tcmp0[7:0] <= tcmp0[7:0];
			        end

				if(tim_pstrb[1]) begin
					tcmp0[15:8] <= tim_pwdata[15:8];
				end else begin
					tcmp0[15:8] <= tcmp0[15:8];
				end 
				
				if(tim_pstrb[2]) begin
					tcmp0[23:16] <= tim_pwdata[23:16];
				end else begin
					tcmp0[23:16] <= tcmp0[23:16];
				end 

				if(tim_pstrb[3]) begin
					tcmp0[31:24] <= tim_pwdata[31:24];
				end else begin
					tcmp0[31:24] <= tcmp0[31:24];
				end 
			end else begin
				tcmp0 <= tcmp0;
			end


			if(tcmp1_wr_sel) begin
				if(tim_pstrb[0]) begin
				       tcmp1[7:0] <= tim_pwdata[7:0];
			        end else begin
				       tcmp1[7:0] <= tcmp1[7:0];
			        end

				if(tim_pstrb[1]) begin
					tcmp1[15:8] <= tim_pwdata[15:8];
				end else begin
					tcmp1[15:8] <= tcmp1[15:8];
				end 
				
				if(tim_pstrb[2]) begin
					tcmp1[23:16] <= tim_pwdata[23:16];
				end else begin
					tcmp1[23:16] <= tcmp1[23:16];
				end 

				if(tim_pstrb[3]) begin
					tcmp1[31:24] <= tim_pwdata[31:24];
				end else begin
					tcmp1[31:24] <= tcmp1[31:24];
				end 
			end else begin 
				tcmp1 <= tcmp1;	
			end
		end
	end

	wire [63:0] tcmp;
	assign tcmp = {tcmp1, tcmp0};

	//TIER
	wire tier_wr_sel, int_en_pre;

	assign tier_wr_sel = wr_en & (tim_paddr == TIER);
	assign int_en_pre = (tier_wr_sel & tim_pstrb[0]) ? tim_pwdata[0] : int_en;

	always @(posedge sys_clk or sys_rst_n) begin
		if(!sys_rst_n) begin
			int_en <= 1'h0;
		end else begin
			int_en <= int_en_pre;
		end 
	end
	
	wire [31:0] tier;
	assign tier = {31'b0, int_en};


	//TISR
	wire int_set, int_clr, int_st_pre, tisr_wr_sel;
	assign tisr_wr_sel = wr_en & (tim_paddr == TISR);
	assign int_set =(tcmp == tdr);
	assign int_clr = tisr_wr_sel & (tim_pwdata[0] == 1'b1) & tim_pstrb[0];
	assign int_st_pre = (int_clr) ? 1'b0 : (int_set) ? 1'b1 : int_st;
	
	always @(posedge sys_clk or negedge sys_rst_n) begin 
		if(!sys_rst_n) begin
			int_st <= 1'b0;
		end else begin
			int_st <= int_st_pre;
		end 
	end 

	wire [31:0] tisr;
	assign tisr = {31'b0, int_st};



	//THCSR 
	
	wire thcsr_wr_sel;

	assign thcsr_wr_sel = wr_en & (tim_paddr == THCSR);

	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			halt_req <= 1'b0;
		end else begin
			if(thcsr_wr_sel && tim_pstrb[0]) begin
				halt_req <= tim_pwdata[0];
			end else begin
				halt_req <= halt_req;
			end 
		end 
	end 

	wire [31:0] thcsr;
	assign thcsr = {30'h0, halt_ack, halt_req};



	//PSLVERR
	
	assign pslverr = tcr_wr_sel & ((timer_en & tim_pstrb[1] & (tim_pwdata[11:8] != div_val)) | 
					(timer_en & tim_pstrb[0] & (tim_pwdata[1] != div_en)) | 
					(tim_pstrb[1] & (tim_pwdata[11:8] > 4'h8)));

	

	//READ
	
	always @(*) begin
		if(rd_en & pready) begin
			case(tim_paddr)
				TCR: 	rdata = tcr;
				TDR0:	rdata = tdr0;
				TDR1: 	rdata = tdr1;
				TCMP0:	rdata = tcmp0;
				TCMP1:	rdata = tcmp1;
				TIER:	rdata = tier;
				TISR:	rdata = tisr;
				THCSR:	rdata = thcsr;
				default rdata = 32'h0;
			endcase
		end else begin
			rdata = 32'h0;
		end
	end

endmodule
