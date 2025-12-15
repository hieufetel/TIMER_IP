coverage exclude -src ../rtl/register.v -code c -line 315 -comment {pready cant be 0 in} 
coverage exclude -scope /test_bench/u/uu -togglenode {tcr[2]} {tcr[3]} {tcr[4]} {tcr[5]} {tcr[6]} {tcr[7]} {tcr[12]} {tcr[13]} {tcr[14]} {tcr[15]} -comment {tcr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tcr[16]} {tcr[17]} {tcr[18]} {tcr[19]} {tcr[20]} {tcr[21]} {tcr[22]} {tcr[23]} {tcr[24]} {tcr[25]} -comment {tcr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tcr[26]} {tcr[27]} {tcr[28]} {tcr[29]} {tcr[30]} {tcr[31]} -comment {tcr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {thcsr[2]} {thcsr[3]} {thcsr[4]} {thcsr[5]} {thcsr[6]} {thcsr[7]} {thcsr[8]} {thcsr[9]} {thcsr[10]} {thcsr[11]} -comment {thcsr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {thcsr[12]} {thcsr[13]} {thcsr[14]} {thcsr[15]} {thcsr[16]} {thcsr[17]} {thcsr[18]} {thcsr[19]} {thcsr[20]} {thcsr[21]} -comment {thcsr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {thcsr[22]} {thcsr[23]} {thcsr[24]} {thcsr[25]} {thcsr[26]} {thcsr[27]} {thcsr[28]} {thcsr[29]} {thcsr[30]} {thcsr[31]}
coverage exclude -scope /test_bench/u/uu -togglenode -comment {thcsr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tier[1]} {tier[2]} {tier[3]} {tier[4]} {tier[5]} {tier[6]} {tier[7]} {tier[8]} {tier[9]} {tier[10]} -comment {tier reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tier[11]} {tier[12]} {tier[13]} {tier[14]} {tier[15]} {tier[16]} {tier[17]} {tier[18]} {tier[19]} {tier[20]} -comment {tier reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tier[21]} {tier[22]} {tier[23]} {tier[24]} {tier[25]} {tier[26]} {tier[27]} {tier[28]} {tier[29]} {tier[30]} -comment {tier reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tier[31]} -comment {tier reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tisr[1]} {tisr[2]} {tisr[3]} {tisr[4]} {tisr[5]} {tisr[6]} {tisr[7]} {tisr[8]} {tisr[9]} {tisr[10]} -comment {tisr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tisr[11]} {tisr[12]} {tisr[13]} {tisr[14]} {tisr[15]} {tisr[16]} {tisr[17]} {tisr[18]} {tisr[19]} {tisr[20]} -comment {tisr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tisr[21]} {tisr[22]} {tisr[23]} {tisr[24]} {tisr[25]} {tisr[26]} {tisr[27]} {tisr[28]} {tisr[29]} {tisr[30]} -comment {tisr reserved bit, cannot toggle} 
coverage exclude -scope /test_bench/u/uu -togglenode {tisr[31]} -comment {tisr reserved bit, cannot toggle} 
