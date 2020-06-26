#define chansize  ??
#define lb_for502_1  -1
#define ub_for502_2  -1
#define lb_for63_3  -1
#define ub_for63_4  -1
#define lb_for51_5  -1
#define ub_for51_6  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [chansize] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run go_dnsparseZone5(_ch0);
	goto stop_process
stop_process:}

proctype go_dnsparseZone5(Chandef t) {
	bool closed; 
	int i;
	Chandef _ch2;
	chan _ch2_in = [0] of {int};
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	run go_dnszlexer2(_ch2);
	
	if
	:: true -> 
		t.in!0;
		t.sending?state;
		goto stop_process
	:: true;
	fi;
	do
	:: _ch2.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch2.in?0;
			
			if
			:: true -> 
				t.in!0;
				t.sending?state;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true;
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi;
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true -> 
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				c.in?0;
				

				if
				:: true -> 
					c.in?0;
					
					if
					:: true -> 
						
						if
						:: true -> 
							t.in!0;
							t.sending?state;
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsparseZone58 = [0] of {int};
				run dnsparseZone5(t,child_dnsparseZone58);
				child_dnsparseZone58?0
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsslurpRemainder29 = [0] of {int};
				run dnsslurpRemainder2(c,child_dnsslurpRemainder29);
				child_dnsslurpRemainder29?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsslurpRemainder210 = [0] of {int};
				run dnsslurpRemainder2(c,child_dnsslurpRemainder210);
				child_dnsslurpRemainder210?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state
				:: true;
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsgenerate411 = [0] of {int};
				run dnsgenerate4(c,t,child_dnsgenerate411);
				child_dnsgenerate411?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true -> 
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				chan child_dnssetRR412 = [0] of {int};
				run dnssetRR4(c,child_dnssetRR412);
				child_dnssetRR412?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				t.in!0;
				t.sending?state
			fi
		fi
	od;
	
	if
	:: true -> 
		t.closing!true
	:: true;
	fi;
stop_process:
}
proctype go_dnszlexer2(Chandef c) {
	bool closed; 
	int i;
	
	if
	:: lb_for502_1 != -1 && ub_for502_2 != -1 -> 
				for(i : lb_for502_1.. ub_for502_2) {
for10:			
			if
			:: true -> 
				c.in!0;
				c.sending?state;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				c.in!0;
				c.sending?state;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						

						if
						:: true;
						:: true;
						:: true;
						:: true;
						fi;
						c.in!0;
						c.sending?state
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										c.in!0;
										c.sending?state;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi;
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										c.in!0;
										c.sending?state;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi
						:: true;
						fi;
						c.in!0;
						c.sending?state
					fi
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						c.in!0;
						c.sending?state;
						break
					:: true;
					fi;
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						c.in!0;
						c.sending?state
					:: true;
					fi;
					c.in!0;
					c.sending?state
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				:: true;
				fi;
				c.in!0;
				c.sending?state
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: true -> 
					
					if
					:: true -> 
						c.in!0;
						c.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				c.in!0;
				c.sending?state;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				c.in!0;
				c.sending?state;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						

						if
						:: true;
						:: true;
						:: true;
						:: true;
						fi;
						c.in!0;
						c.sending?state
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										c.in!0;
										c.sending?state;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi;
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										c.in!0;
										c.sending?state;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi
						:: true;
						fi;
						c.in!0;
						c.sending?state
					fi
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						c.in!0;
						c.sending?state;
						break
					:: true;
					fi;
					break
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						c.in!0;
						c.sending?state
					:: true;
					fi;
					c.in!0;
					c.sending?state
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					c.in!0;
					c.sending?state
				:: true;
				fi;
				c.in!0;
				c.sending?state
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				

				if
				:: true -> 
					
					if
					:: true -> 
						c.in!0;
						c.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		c.in!0;
		c.sending?state
	:: true;
	fi;
	c.closing!true;
stop_process:
}
proctype dnsparseZone5(Chandef t;chan child) {
	bool closed; 
	int i;
	run go_dnszlexer2(_ch2);
	
	if
	:: true -> 
		t.in!0;
		t.sending?state;
		goto stop_process
	:: true;
	fi;
	do
	:: _ch2.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch2.in?0;
			
			if
			:: true -> 
				t.in!0;
				t.sending?state;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: true;
				:: true -> 
					
					if
					:: true -> 
						break
					:: true;
					fi;
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true;
				:: true -> 
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				c.in?0;
				

				if
				:: true -> 
					c.in?0;
					
					if
					:: true -> 
						
						if
						:: true -> 
							t.in!0;
							t.sending?state;
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsparseZone50 = [0] of {int};
				run dnsparseZone5(t,child_dnsparseZone50);
				child_dnsparseZone50?0
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsslurpRemainder21 = [0] of {int};
				run dnsslurpRemainder2(c,child_dnsslurpRemainder21);
				child_dnsslurpRemainder21?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsslurpRemainder22 = [0] of {int};
				run dnsslurpRemainder2(c,child_dnsslurpRemainder22);
				child_dnsslurpRemainder22?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state
				:: true;
				fi;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				chan child_dnsgenerate43 = [0] of {int};
				run dnsgenerate4(c,t,child_dnsgenerate43);
				child_dnsgenerate43?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true -> 
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					
					if
					:: true -> 
						t.in!0;
						t.sending?state;
						goto stop_process
					:: true;
					fi
				:: true;
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi
			:: true -> 
				chan child_dnssetRR47 = [0] of {int};
				run dnssetRR4(c,child_dnssetRR47);
				child_dnssetRR47?0;
				
				if
				:: true -> 
					t.in!0;
					t.sending?state;
					goto stop_process
				:: true;
				fi;
				t.in!0;
				t.sending?state
			fi
		fi
	od;
	
	if
	:: true -> 
		t.closing!true
	:: true;
	fi;
	child!0;
stop_process:
}
proctype dnsslurpRemainder2(Chandef c;chan child) {
	bool closed; 
	int i;
	c.in?0;
	

	if
	:: true -> 
		c.in?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	:: true;
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype dnsgenerate4(Chandef c;Chandef t;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c.in?0;
BuildRR:		c.in?0;
	
	if
	:: true -> 
		goto BuildRR
	:: true;
	fi;
	
	if
	:: lb_for63_3 != -1 && ub_for63_4 != -1 -> 
				for(i : lb_for63_3.. ub_for63_4) {
for22:			
			if
			:: 0 != -1 && s-1 != -1 -> 
								for(i : 0.. s-1) {
for23:					

					if
					:: true;
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi;
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						:: true;
						fi
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for23:					

					if
					:: true;
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi;
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						:: true;
						fi
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for23_exit:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			t.in!0;
			t.sending?state
		}
	:: else -> 
		do
		:: true -> 
for22:			
			if
			:: 0 != -1 && s-1 != -1 -> 
								for(i : 0.. s-1) {
for23:					

					if
					:: true;
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi;
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						:: true;
						fi
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for23:					

					if
					:: true;
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi;
							
							if
							:: true -> 
								goto stop_process
							:: true;
							fi
						:: true;
						fi
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for23_exit:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			t.in!0;
			t.sending?state
		:: true -> 
			break
		od
	fi;
for22_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype dnssetRR4(Chandef c;chan child) {
	bool closed; 
	int i;
	chan child_dnssetRFC359746 = [0] of {int};
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		chan child_dnsslurpRemainder24 = [0] of {int};
		run dnsslurpRemainder2(c,child_dnsslurpRemainder24);
		child_dnsslurpRemainder24?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run dnssetRFC35974(c,child_dnssetRFC359746);
	child_dnssetRFC359746?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype dnssetRFC35974(Chandef c;chan child) {
	bool closed; 
	int i;
	chan child_dnsendingToString35 = [0] of {int};
	c.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	c.in?0;
	c.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run dnsendingToString3(c,child_dnsendingToString35);
	child_dnsendingToString35?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype dnsendingToString3(Chandef c;chan child) {
	bool closed; 
	int i;
	c.in?0;
	
	if
	:: lb_for51_5 != -1 && ub_for51_6 != -1 -> 
				for(i : lb_for51_5.. ub_for51_6) {
for24:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true -> 
				goto stop_process
			fi;
			c.in?0
		}
	:: else -> 
		do
		:: true -> 
for24:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true;
			:: true;
			:: true -> 
				goto stop_process
			fi;
			c.in?0
		:: true -> 
			break
		od
	fi;
for24_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
