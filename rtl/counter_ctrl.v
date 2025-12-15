module counter_ctrl(
	input sys_clk,
	input sys_rst_n,
	input div_en,
	input [3:0] div_val,
	input timer_en,
	input halt_req,
	input dbg_mode,

	output cnt_en,
	output halt_ack
);

	wire [7:0] limit, int_cnt_pre;
	reg  [7:0] int_cnt;
	wire cnt_rst, halt;
	wire cnt, cnt_1, cnt_2, cnt_3;
	assign limit = (1 << div_val) - 1;
	assign cnt_rst = ~div_en | ~timer_en | (limit == int_cnt);
	assign cnt = timer_en & div_en & (div_val != 0);
	assign halt = halt_req & dbg_mode;

		 
/*	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) begin
			int_cnt <= 8'h0;
		end else begin 
			if(halt) begin
				int_cnt <= int_cnt;
			end else begin
				if(cnt_rst) begin
					int_cnt <= 8'h0;
				end else begin
					if(cnt) begin
						int_cnt <= int_cnt + 1;
					end	
				end
			end
		end
	end  */
	assign int_cnt_pre = (halt) ? int_cnt : ((cnt_rst) ? 8'h0 : ((cnt) ? int_cnt + 1 : int_cnt)); 

	always @(posedge sys_clk or negedge sys_rst_n) begin
		if(!sys_rst_n) 
			int_cnt <= 8'h0;
		else 
			int_cnt <= int_cnt_pre;
	end

	assign cnt_1 = (int_cnt == limit) && div_en && timer_en && div_val != 0;
	assign cnt_2 = ~div_en && timer_en;
	assign cnt_3 = (div_val == 0) && div_en && timer_en;
/*	assign cnt_en = (~halt) & (((div_val == 0) & div_en & timer_en)
       				| (int_cnt == limit & timer_en & div_en ) // & div_val != 0) 
				| (~div_en & timer_en));
*/

	assign cnt_en = (~halt) & (cnt_1 | cnt_2 | cnt_3);
	assign halt_ack = halt;
endmodule

