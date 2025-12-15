task run_test();
	reg [31:0] temp;
	begin 

		$display("==============================================================");
		$display("=======================Check Initial Value====================");
		test_bench.read(TCR, temp);
		test_bench.read(TDR0, temp);
		test_bench.read(TDR1, temp);
		test_bench.read(TCMP0, temp);
		test_bench.read(TCMP1, temp);
		test_bench.read(TIER, temp);
		test_bench.read(TISR, temp);
		test_bench.read(THCSR, temp);
			
		//TCR
		$display("==============================================================");
		$display("=======================TCR====================");
		$display("RW check");
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCR, 32'h5555_5555);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h501, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCR, 32'hAAAA_AAAA);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h501, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCR, 32'h500);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h500, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCR, 32'h5678_1234);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h200, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h0, 32'hffff_ffff);
		//Write PSTRB TCR
		$display("============");	
		$display("Write prohibit");
		test_bench.write(TCR, 32'hffff_ffff);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h0, 32'hffff_ffff);
	
		$display("=");
		test_bench.write(TCR, 32'hffff_f7ff);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h703, 32'hffff_ffff);

		$display("=");
		test_bench.write(TCR, 32'h702);
		test_bench.write(TCR, 32'h700);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h700, 32'hffff_ffff);

		$display("=");
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h0, 32'hffff_ffff);

		$display("============");	
		$display("WRITE_PSTRB");
		write_pstrb(TCR, 32'hffff_fff3, 1);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h3, 32'hffff_ffff);
		
		$display("=");
		test_bench.write(TCR, 32'h2);
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		$display("===============================================================");
		$display("Write PSTRB");
		write_pstrb(TCR, 32'hffff_f4ff, 2);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h400, 32'hffff_ffff);
	
		write_pstrb(TCR, 32'hffff_f4ff, 4);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h400, 32'hffff_ffff);
	
		write_pstrb(TCR, 32'hffff_f4ff, 8);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h400, 32'hffff_ffff);
	
		write_pstrb(TCR, 32'hffff_f4ff, 3);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h403, 32'hffff_ffff);
	
		test_bench.write(TCR, 32'h402);
		test_bench.write(TCR, 32'h400);
		write_pstrb(TCR, 32'hffff_f4ff, 12);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h400, 32'hffff_ffff);
		test_bench.write(TCR, 32'h0);

		write_pstrb(TCR, 32'h3333_3333, 15);
		test_bench.read(TCR, temp);
		test_bench.cmp(temp,TCR, 32'h303, 32'hffff_ffff);
		$display("===============================================================");
		$display("======================================================================");
		#5;	
			
		//TDR0
		$display("======================================================================");
		$display("=======================TDR0====================");
		$display("RW check");
		test_bench.write(TDR0, 32'h0);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TDR0, 32'h5555_5555);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'h5555_5555, 32'hffff_ffff);
		$display("=");
		test_bench.write(TDR0, 32'hffff_ffff);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'hffff_ffff, 32'hffff_ffff);
		$display("=");
		test_bench.write(TDR0, 32'h5445_5445);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'h5445_5445, 32'hffff_ffff);
	
		//Write PSTRB TDR0
		$display("===============================================================");
		$display("Write PSTRB");
		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 1);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'hff, 32'hffff_ffff);

		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 2);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'hff00, 32'hffff_ffff);

		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 4);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'h00ff_0000, 32'hffff_ffff);

		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 8);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'hff00_0000, 32'hffff_ffff);
	
		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 3);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'hffff, 32'hffff_ffff);

		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 12);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'hffff_0000, 32'hffff_ffff);

		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 6);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp,TDR0, 32'h00ff_ff00, 32'hffff_ffff);
		write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 15);
		repeat(10) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		$display("======================================================================");


		//TDR1
		$display("======================================================================");
		$display("=======================TDR1====================");
		$display("RW check");
		test_bench.write(TDR1, 32'h0);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TDR1, 32'h5555_5555);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'h5555_5555, 32'hffff_ffff);
		$display("=");
		test_bench.write(TDR1, 32'hffff_ffff);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'hffff_ffff, 32'hffff_ffff);
		$display("=");
		test_bench.write(TDR1, 32'h5445_5445);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'h5445_5445, 32'hffff_ffff);


		//Write PSTRB TDR1
		$display("===============================================================");
		$display("Write PSTRB");
		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 1);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'hff, 32'hffff_ffff);

		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 2);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'hff00, 32'hffff_ffff);

		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 4);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'h00ff_0000, 32'hffff_ffff);

		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 8);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'hff00_0000, 32'hffff_ffff);
	
		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 3);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'hffff, 32'hffff_ffff);

		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 12);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'hffff_0000, 32'hffff_ffff);

		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 6);
		test_bench.read(TDR1, temp);
		test_bench.cmp(temp,TDR1, 32'h00ff_ff00, 32'hffff_ffff);
		write_pstrb(TDR1, 32'h0, 15);	
		write_pstrb(TDR1, 32'hffff_ffff, 15);
		write_pstrb(TDR0, 32'hffff_ffff, 15);
		repeat(10) @(posedge test_bench.sys_clk);
		test_bench.read(TDR1, temp);	
		#10;	
				

		//TCMP0
		$display("======================================================================");
		$display("=======================TCMP0====================");
		$display("RW check");
		test_bench.write(TCMP0, 32'h0);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCMP0, 32'h5555_5555);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'h5555_5555, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCMP0, 32'hffff_ffff);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'hffff_ffff, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCMP0, 32'h5445_5445);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'h5445_5445, 32'hffff_ffff);

		//Write PSTRB TCMP0
		$display("===============================================================");
		$display("Write PSTRB");
		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 1);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'hff, 32'hffff_ffff);

		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 2);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'hff00, 32'hffff_ffff);

		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 4);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'h00ff_0000, 32'hffff_ffff);

		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 8);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'hff00_0000, 32'hffff_ffff);
	
		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 3);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'hffff, 32'hffff_ffff);

		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 12);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TCMP0, 32'hffff_0000, 32'hffff_ffff);

		write_pstrb(TCMP0, 32'h0, 15);	
		write_pstrb(TCMP0, 32'hffff_ffff, 6);
		test_bench.read(TCMP0, temp);
		test_bench.cmp(temp,TDR0, 32'h00ff_ff00, 32'hffff_ffff);
	/*	write_pstrb(TDR0, 32'h0, 15);	
		write_pstrb(TDR0, 32'hffff_ffff, 15);
		repeat(10) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);*/
		$display("======================================================================");


		//TCMP1
		$display("======================================================================");
		$display("=======================TCMP1====================");
		$display("RW check");
		test_bench.write(TCMP1, 32'h0);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCMP1, 32'h5555_5555);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'h5555_5555, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCMP1, 32'hffff_ffff);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'hffff_ffff, 32'hffff_ffff);
		$display("=");
		test_bench.write(TCMP1, 32'h5445_5445);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'h5445_5445, 32'hffff_ffff);

		$display("===============================================================");
		//Write PSTRB
		$display("Write PSTRB");
		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 1);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'hff, 32'hffff_ffff);

		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 2);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'hff00, 32'hffff_ffff);

		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 4);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'h00ff_0000, 32'hffff_ffff);

		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 8);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'hff00_0000, 32'hffff_ffff);
	
		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 3);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'hffff, 32'hffff_ffff);

		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 12);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'hffff_0000, 32'hffff_ffff);

		write_pstrb(TCMP1, 32'h0, 15);	
		write_pstrb(TCMP1, 32'hffff_ffff, 6);
		test_bench.read(TCMP1, temp);
		test_bench.cmp(temp,TCMP1, 32'h00ff_ff00, 32'hffff_ffff);
		$display("======================================================================");
		#10;

		//TIER
		$display("======================================================================");
		$display("=======================TIER====================");
		$display("RW check");
		test_bench.write(TIER, 32'h0);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TIER, 32'h5555_5555);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h1, 32'hffff_ffff);
		$display("=");
		test_bench.write(TIER, 32'h4444_4444);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h0, 32'hffff_ffff);
		$display("======================================================================");
		#10;
		write_pstrb(TIER, 32'h1, 15);
		write_pstrb(TIER, 32'h0, 14);
		test_bench.cmp(temp, TIER, 32'h1, 32'h2);

		$display("Write PSTRB");
		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 1);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h1, 32'hffff_ffff);

		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 2);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h00, 32'hffff_ffff);

		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 4);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h0000_0000, 32'hffff_ffff);

		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 8);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h0000_0000, 32'hffff_ffff);
	
		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 3);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h1, 32'hffff_ffff);

		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 12);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h0000, 32'hffff_ffff);

		write_pstrb(TIER, 32'h0, 15);	
		write_pstrb(TIER, 32'hffff_ffff, 6);
		test_bench.read(TIER, temp);
		test_bench.cmp(temp,TIER, 32'h00, 32'hffff_ffff);
	
		//TISR
		$display("======================================================================");
		$display("=======================TISR====================");
		$display("RW check");
		test_bench.write(TISR, 32'h1); //cho nay phai write 1 vi da test tdr0 va tdr1 tran
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TISR, 32'h0);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TISR, 32'h5555_5555);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(TISR, 32'h4444_4444);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0, 32'hffff_ffff);
		$display("=");

		$display("Write PSTRB");
		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 1);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0, 32'hffff_ffff); //write this bit when 0 has no effect

		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 2);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h00, 32'hffff_ffff);

		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 4);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0000_0000, 32'hffff_ffff);

		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 8);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0000_0000, 32'hffff_ffff);
	
		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 3);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0, 32'hffff_ffff); //write this bit when 0 has no effect

		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 12);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h0000, 32'hffff_ffff);

		write_pstrb(TISR, 32'h0, 15);	
		write_pstrb(TISR, 32'hffff_ffff, 6);
		test_bench.read(TISR, temp);
		test_bench.cmp(temp,TISR, 32'h00, 32'hffff_ffff);
	
		//THCSR
		$display("======================================================================");
		$display("=======================THCSR====================");
		$display("RW check");
		test_bench.write(THCSR, 32'h0); //cho nay phai write 1 vi da test tdr0 va tdr1 tran
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(THCSR, 32'h5555_5555); 
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h1, 32'hffff_ffff);
		$display("=");
		test_bench.write(THCSR, 32'h4444_4444);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h0, 32'hffff_ffff);
		$display("=");
		test_bench.write(THCSR, 32'hffff_ffff);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h1, 32'hffff_ffff);
		$display("=");
		$display("===============================================================");
		$display("Write PSTRB");
		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 1);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h1, 32'hffff_ffff);

		test_bench.write(THCSR, 32'h0);
		
		$display("Write PSTRB");
		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 1);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h1, 32'hffff_ffff);

		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 2);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h00, 32'hffff_ffff);

		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 4);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h0000_0000, 32'hffff_ffff);

		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 8);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h0000_0000, 32'hffff_ffff);
	
		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 3);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h1, 32'hffff_ffff);

		write_pstrb(THCSR, 32'h0, 15);	
		write_pstrb(THCSR, 32'hffff_ffff, 12);
		test_bench.read(THCSR, temp);
		test_bench.cmp(temp,THCSR, 32'h0000_0000, 32'hffff_ffff);


		$display("======================================================================");

		test_bench.sys_rst_n = 1'b0;
		#100;
		test_bench.sys_rst_n = 1'b1;
		#500;

		//READ RANDOM REGISTER
		$display("======================================================================");
		$display("=======================RANDOM READ====================");
		test_bench.read(12'h28, temp);
		$display("======================================================================");

		
		//PSLVERR
		$display("======================================================================");
		$display("=======================PSLAVE_ERROR====================");
		$display("RW check");
		write_pstrb(TCR, 32'h0000_0a00, 15);//div_val = 10
		test_bench.write(TCR, 32'h1); //timer_en 
		#90;
		test_bench.write(TCR, 32'h3); //change div_en when timer_en high
		test_bench.write(TCR, 32'h403);	//change div_val when timer_en high	
		
		test_bench.read(TCR, temp);
		test_bench.write(TCR, 32'h302);
		test_bench.write(TCR, 32'h000);	



		$display("=======================================================================");
		$display("===========================Counter Control=============================");
		$display("============================default====================================");
		test_bench.write(TCR, 32'h0);
		test_bench.write(TCR, 32'h1);
		repeat(100) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h67, 32'hffff);

		//div_val = 0
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h003);
		repeat(200) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'hcb, 32'hffff);

		//div_val = 1
		test_bench.write(TCR, 32'h2);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h103);
		repeat(200) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h65, 32'hffff);

		//div_val = 2
		test_bench.write(TCR, 32'h102);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h203);
		repeat(200) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h32, 32'hffff);

		//div_val = 3
		test_bench.write(TCR, 32'h202);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h303);
		repeat(200) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h19, 32'hffff);


		//div_val = 4
		test_bench.write(TCR, 32'h302);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h403);
		repeat(400) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h19, 32'hffff);

		//div_val = 5
		test_bench.write(TCR, 32'h402);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h503);
		repeat(400) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h0c, 32'hffff);

		//div_val = 6
		test_bench.write(TCR, 32'h502);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h603);
		repeat(400) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h06, 32'hffff);

		//div_val = 7
		test_bench.write(TCR, 32'h602);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h703);
		repeat(400) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h03, 32'hffff);

		//div_val = 8
		test_bench.write(TCR, 32'h702);
		test_bench.write(TCR, 32'h0);
		#10;
		test_bench.write(TCR, 32'h803);
		repeat(400) @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.cmp(temp, TDR0, 32'h01, 32'hffff);

		test_bench.write(TCR, 32'h802);
		test_bench.write(TCR, 32'h0);
		#10;

		//Interrupt Occur -> Count continue
		test_bench.write(TDR0, 32'hffff_fffa);
		test_bench.write(TDR1, 32'hffff_ffff);
		#10;
		test_bench.write(TIER, 32'h1);
		test_bench.write(TCR,  32'h1);

		repeat(200) @(posedge test_bench.sys_clk);

		test_bench.read(TDR0, temp);
		test_bench.read(TISR, temp);

		//TIER.int_en = 0 -> TISR.int_st = 0
		test_bench.write(TCR, 32'h0);
		test_bench.read(TDR0, temp);
		test_bench.write(TIER, 32'h0);
		test_bench.read(TIER, temp);
		test_bench.read(TISR, temp);

		//TISR parital
		write_pstrb(TIER, 32'h1, 2);
		test_bench.read(TIER, temp);

		//TCR pslverr
		test_bench.write(TCR, 32'h3);
		#100;
		write_pstrb(TCR, 32'h0, 14);
		write_pstrb(TCR, 32'h0, 15);
		
		//TCR write error_respone with byte strb
		test_bench.write(TCR, 32'h0);
		write_pstrb(TCR, 32'h3, 15);
		write_pstrb(TCR, 32'h2, 14);
		write_pstrb(TCR, 32'h2, 15);
		write_pstrb(TCR, 32'h0, 15);

		write_pstrb(TCR, 32'h803, 15);
		write_pstrb(TCR, 32'h802, 15);
		write_pstrb(TCR, 32'h000, 15);

		//TCR RW reserved bits
		write_pstrb(TCR, 32'hffff_ffff, 15);
		test_bench.read(TCR, temp);

		write_pstrb(TCR, 32'h3, 1);
		#100;
		write_pstrb(TCR, 32'h1, 1);
		#100;
		write_pstrb(TCR, 32'h1, 2);
		#100;
		write_pstrb(TCR, 32'h0, 1);

		//TIER interrupt pending
		test_bench.write(TDR0, 32'hffff_fffe);
		test_bench.write(TDR1, 32'hffff_ffff);
		test_bench.write(TCR, 32'h3);	
		repeat(50) @(posedge test_bench.sys_clk);
		 
		test_bench.write(TIER, 32'h1);
		test_bench.write(TISR, 32'h1);
		test_bench.read(TISR, temp);
		test_bench.read(TIER, temp);
		//test_bench.write(TDR0, 32'hffff_fffe);
		//test_bench.write(TDR1, 32'hffff_ffff);
		//test_bench.write(TCR, 32'3);	
		repeat(50) @(posedge test_bench.sys_clk);
		test_bench.write(TIER, 32'h1);
		test_bench.write(TISR, 32'h1);
		repeat(5) @(posedge test_bench.sys_clk); 
		test_bench.read(TISR, temp);
		test_bench.read(TIER, temp);	

		
		
		//debug mode
		//halt = 1, debug_mode = 0
		test_bench.read(TCR, temp);
		test_bench.write(TCR, 32'h2);
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.dbg_mode = 1'b0;
		
		test_bench.write(TCR, 32'h3);
		repeat(100) @(posedge test_bench.sys_clk);
		test_bench.write(THCSR, 32'h1);
		repeat(10)  @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.write(THCSR, 32'h0);

	 	$display("================================================================");
		//halt = 1, debug_mode = 1;
		test_bench.read(TCR, temp);
		test_bench.write(TCR, 32'h2);
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.dbg_mode = 1'b1;
				

		test_bench.write(TCR, 32'h3);
		repeat(100) @(posedge test_bench.sys_clk);
		test_bench.write(THCSR, 32'h1);
		repeat(10)  @(posedge test_bench.sys_clk);
		test_bench.read(TDR0, temp);
		test_bench.read(THCSR, temp); 
		test_bench.write(THCSR, 32'h0);
		test_bench.dbg_mode = 1'b0;
		
		//clear
		test_bench.write(TIER, 32'h0);
		test_bench.write(TDR0, 32'h0);	
		test_bench.write(TDR1, 32'h0);
		test_bench.write(TCMP0, 32'h0);
		test_bench.write(TCMP1, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.read(TDR0, temp);
		test_bench.read(TDR1, temp);
		test_bench.read(TCMP0, temp);
		test_bench.read(TCMP1, temp);
		test_bench.read(TIER, temp);
		test_bench.read(TISR, temp);
		test_bench.read(THCSR, temp);	
	 	$display("====CHECK Relation between timer_en, div_en and div_val relate to the interrupt ============================================================");
		test_bench.dbg_mode = 1'b0;
		test_bench.write(THCSR, 32'h0);
		#100;

		test_bench.read(TCR, temp);
		test_bench.write(TCR, 32'h2);
		test_bench.write(TCR, 32'h0);
		test_bench.read(TCR, temp);
		test_bench.read(THCSR, temp);
		test_bench.write(TCR, 32'h0000_0001);
		#1000;
		test_bench.write(TCR, 32'h2);
		#1000;
		test_bench.write(TCR, 32'h0000_0003);
		#1000;
		test_bench.write(TCR, 32'h0000_0001);
		#10;
		test_bench.write(TCR, 32'h0000_0002);
		test_bench.write(TCR, 32'h0000_0000);

		test_bench.write(TCR, 32'h0000_0103);
		repeat(1000) @(posedge test_bench.sys_clk);
		test_bench.write(TCR, 32'h0000_0102);
		test_bench.write(TCR, 32'h0000_0000);

		test_bench.write(TCR, 32'h0000_0100);
		test_bench.write(TCR, 32'h0000_0102);
		test_bench.write(TCR, 32'h0000_0103);
		test_bench.write(TCR, 32'h0000_0102);
		test_bench.write(TCR, 32'h0000_0100);
			
		test_bench.write(TCR, 32'h0000_0000);
		test_bench.write(TCR, 32'h0000_0000);
		test_bench.write(TCR, 32'h0000_0002);
		#100;
		test_bench.write(TCR, 32'h0000_0002);
		test_bench.write(TCR, 32'h0000_0003);
		test_bench.write(TCR, 32'h0000_0002);
		test_bench.write(TCR, 32'h0000_0000);


		test_bench.write(TCR, 32'h0000_0100);
		test_bench.write(TCR, 32'h0000_0102);
		test_bench.write(TCR, 32'h0000_0103);
		test_bench.write(TCR, 32'h0000_0803);
		test_bench.write(TCR, 32'h0000_0103);
		test_bench.write(TCR, 32'h0000_0703);
		test_bench.write(TCR, 32'h0000_0102);
		test_bench.write(TCR, 32'h0000_0100);
			
		test_bench.write(TIER, 32'h0000_0000);
		test_bench.write(TCR, 32'h0);

		//clear interrupt
		
		test_bench.write(TISR, 32'h0);
		test_bench.write(TCMP0, 32'h0);
		test_bench.write(TCMP1, 32'h0);

		test_bench.write(TDR0, 32'hFFFF_FFFF);
		test_bench.write(TCR, 32'h3);

	end
endtask

