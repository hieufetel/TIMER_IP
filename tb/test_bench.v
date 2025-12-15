module test_bench;

	reg sys_clk;
	reg sys_rst_n;
	reg tim_psel;
	reg tim_penable;
	reg [11:0] tim_paddr;
	reg [31:0] tim_pwdata;
	reg [3:0] tim_pstrb;
	reg tim_pwrite;
	reg dbg_mode;

	wire [31:0] tim_prdata;
	wire tim_pready;
	wire tim_pslverr;
	wire tim_int;
	
	reg pslverr_detected;
	reg pslverr_exp;
	integer err;
	reg [31:0] tmp;
	parameter TCR   = 12'h00;
	parameter TDR0  = 12'h04;
	parameter TDR1  = 12'h08;
	parameter TCMP0 = 12'h0c;
	parameter TCMP1 = 12'h10;
	parameter TIER  = 12'h14;
	parameter TISR  = 12'h18;
	parameter THCSR = 12'h1c;

	timer_top u(
		.sys_clk(sys_clk),
		.sys_rst_n(sys_rst_n),
		.tim_psel(tim_psel),
		.tim_penable(tim_penable),
		.tim_paddr(tim_paddr),
		.tim_pwdata(tim_pwdata),
		.tim_pstrb(tim_pstrb),
		.tim_pwrite(tim_pwrite),
		.dbg_mode(dbg_mode),
		.tim_prdata(tim_prdata),
		.tim_pready(tim_pready),
		.tim_pslverr(tim_pslverr),
		.tim_int(tim_int)
	);

	`include "run_test.v"
	
	initial begin
		sys_clk = 0;
		forever #25 sys_clk = ~sys_clk;
	end

	initial begin
		sys_rst_n = 1'b0;
		#50;
		sys_rst_n = 1'b1;
	end 

	initial begin
		#200;
		run_test();
		#500;
		if(err != 0) begin 
			$display("Test_result FAILED");
		end else begin
			$display("Test_result PASSED");
		end
		$finish;
	end

	initial begin
	tim_psel = 0;
	tim_penable = 0;
	tim_penable = 0;
	dbg_mode = 0;
	err = 0;
	pslverr_exp = 0;
	#500;

//	read(12'h00, tmp);
//	cmp(tmp, 12'h00, 32'h0000_0100, 32'hffff_ffff);
	
//	#500;
//	$finish;
	end

	task write;
		input [11:0] addr;
		input [31:0] data;
		begin
			tim_pstrb = 4'b1111;
		//	pslverr_detected = 0;
			$display("t=%10d [TB_WRITE]: addr=%x data=%x", $time, addr, data);

			@(posedge sys_clk);
			#1;
			tim_psel = 1;
			tim_pwrite = 1;
			tim_paddr = addr;
			tim_pwdata = data;
			
			@(posedge sys_clk);
			#1;
			tim_penable = 1;
			wait(tim_pready == 1);
			#1;

			if(tim_pslverr == 1) begin
				if(pslverr_exp == 1 ) begin 
					pslverr_detected = 1;
				end else begin 
			end
			end
			
			@(posedge sys_clk);
			#1;
			tim_pwrite = 0;
			tim_psel = 0;
			tim_penable = 0;
			tim_paddr = 0;
			tim_pwdata = 0;
			#10;
		end
	endtask

			
	task read;
		input [11:0] addr;
		output [31:0] data;
		begin
			pslverr_detected = 0;

			@(posedge sys_clk);
			#1;
			tim_psel = 1;
			tim_pwrite = 0;
			tim_paddr = addr;
			
			@(posedge sys_clk);
			#1;
			tim_penable = 1;
			wait(tim_pready == 1);
			#1;
			data = tim_prdata;
			if(tim_pslverr == 1) begin
				if(pslverr_exp == 1 ) begin 
					pslverr_detected = 1;
				end else begin 
				$display("=================================================");
				$display("t=%10d PASS: pslverr detected", $time);
				$display("=================================================");
			//	err = err + 1;
				end
			end
			
			@(posedge sys_clk);
			#1;
			tim_pwrite = 0;
			tim_psel = 0;
			tim_penable = 0;
			tim_paddr = 0;
			tim_pwdata = 0;

			$display("t=%10d [TB_READ]: addr=%x, data=%x", $time, addr, data);
			#10;
		end
	endtask
	
	task write_pstrb;
		input [11:0] addr;
		input [31:0] data;
		input [3:0] pstrb;

		begin
			pslverr_detected = 0;
			$display("%10d WRITE_PSTRB: addr=%x, data=%x, pstrb=%x", $time, addr, data, pstrb);
			@(posedge sys_clk);
			#1;
			tim_psel = 1;
			tim_pwrite = 1;
			tim_paddr = addr;
			tim_pwdata = data;
			tim_pstrb = pstrb;
			
			@(posedge sys_clk);
			#1;
			tim_penable = 1;
			wait(tim_pready == 1);
			#1;

			if(tim_pslverr == 1) begin
				if(pslverr_exp == 1 ) begin 
					pslverr_detected = 1;
				end else begin 
				$display("=================================================");
				$display("t=%10d PASS: pslverr detected", $time);
				$display("=================================================");
			//	err = err + 1;
				end
			end
			
			@(posedge sys_clk);
			#1;
			tim_pwrite = 0;
			tim_psel = 0;
			tim_penable = 0;
			tim_paddr = 0;
			tim_pwdata = 0;
			tim_pstrb = 0;
			#10;
		end
	endtask


	
	task cmp;
		input [31:0] data;
		input [31:0] addr;
		input [31:0] exp_data;
		input [31:0] mask;

		begin
			if((data & mask ) === (exp_data & mask)) begin
				$display("=================================================");
				$display("%10d PASS: rdata = %x at address %x is correct", $time, data, addr);
				$display("=================================================");
			end else begin
				$display("=================================================");
				$display("%10d FAIL: rdata = %x at address %x is not correct, exp_data = %x", $time, data, addr, exp_data);
				$display("=================================================");
				err = err + 1;
			end
		end
	endtask
		
	
			



endmodule
