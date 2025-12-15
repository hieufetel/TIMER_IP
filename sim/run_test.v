task run_test();
	reg [31:0] temp;

	begin 


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

	//TIER
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

end
endtask

