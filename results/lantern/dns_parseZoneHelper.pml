#define chansize  5
#define lb_for502_1  -1
#define ub_for502_2  -1
#define lb_for63_3  -1
#define ub_for63_4  -1
#define lb_for51_5  -1
#define ub_for51_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example498611768/archive/src/github.com/miekg/dns/zscan.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	int i;
	Chandef t;
	bool state = false;
	
	if
	:: chansize > 0 -> 
		t.size = chansize;
		run emptyChan(t)
	:: else -> 
		run sync_monitor(t)
	fi;
	run go_dnsparseZone(t);
	goto stop_process
stop_process:}

proctype go_dnsparseZone(Chandef t) {
	bool closed; 
	int i;
	Chandef c;
	run sync_monitor(c);
	run go_dnszlexer(c);
	
	if
	:: true -> 
		
		if
		:: t.async_send!0;
		:: t.sync!0 -> 
			t.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			c.in?0;
			
			if
			:: true -> 
				
				if
				:: t.async_send!0;
				:: t.sync!0 -> 
					t.sending?0
				fi;
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
						
						if
						:: t.async_send!0;
						:: t.sync!0 -> 
							t.sending?0
						fi;
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
						
						if
						:: t.async_send!0;
						:: t.sync!0 -> 
							t.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi;
				

				if
				:: true -> 
					
					if
					:: c.async_rcv?0;
					:: c.sync?0;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: t.async_send!0;
							:: t.sync!0 -> 
								t.sending?0
							fi;
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				fi;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				chan child_dnsslurpRemainder0 = [0] of {int};
				run dnsslurpRemainder(c,child_dnsslurpRemainder0);
				child_dnsslurpRemainder0?0;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				chan child_dnsslurpRemainder1 = [0] of {int};
				run dnsslurpRemainder(c,child_dnsslurpRemainder1);
				child_dnsslurpRemainder1?0;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				chan child_dnsgenerate2 = [0] of {int};
				run dnsgenerate(c,t,child_dnsgenerate2);
				child_dnsgenerate2?0;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
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
						
						if
						:: t.async_send!0;
						:: t.sync!0 -> 
							t.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				fi
			:: true -> 
				

				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: t.async_send!0;
						:: t.sync!0 -> 
							t.sending?0
						fi;
						goto stop_process
					:: true;
					fi
				:: true;
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true -> 
				chan child_dnssetRR6 = [0] of {int};
				run dnssetRR(c,child_dnssetRR3);
				child_dnssetRR6?0;
				
				if
				:: true -> 
					
					if
					:: t.async_send!0;
					:: t.sync!0 -> 
						t.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: t.async_send!0;
				:: t.sync!0 -> 
					t.sending?0
				fi
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
proctype go_dnszlexer(Chandef c) {
	bool closed; 
	int i;
	
	if
	:: lb_for502_1 != -1 && ub_for502_2 != -1 -> 
				for(i : lb_for502_1.. ub_for502_2) {
for10:			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
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
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
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
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi
						:: true;
						fi;
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
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
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi
						:: true;
						fi;
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					fi
				fi;
				
				if
				:: true -> 
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
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
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
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
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi;
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
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					:: true;
					fi;
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
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
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
				:: true;
				fi;
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
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
					break
				:: true;
				fi;
				

				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi;
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
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
				fi;
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
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
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
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi
						:: true;
						fi;
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
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
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							:: true -> 
								
								if
								:: true -> 
									
									if
									:: true -> 
										
										if
										:: c.async_send!0;
										:: c.sync!0 -> 
											c.sending?0
										fi;
										goto stop_process
									:: true;
									fi
								:: true;
								fi
							fi
						:: true;
						fi;
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					fi
				fi;
				
				if
				:: true -> 
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
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
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
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
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi;
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
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi
					:: true;
					fi;
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
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
					
					if
					:: c.async_send!0;
					:: c.sync!0 -> 
						c.sending?0
					fi
				:: true;
				fi;
				
				if
				:: c.async_send!0;
				:: c.sync!0 -> 
					c.sending?0
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
					break
				:: true;
				fi;
				

				if
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: c.async_send!0;
						:: c.sync!0 -> 
							c.sending?0
						fi;
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
		
		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi
	:: true;
	fi;
	c.closing!true;
stop_process:
}
proctype dnsslurpRemainder(Chandef c;chan child) {
	bool closed; 
	int i;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	

	if
	:: true -> 
		
		if
		:: c.async_rcv?0;
		:: c.sync?0;
		fi;
		
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
proctype dnsgenerate(Chandef c;Chandef t;chan child) {
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
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
BuildRR:		
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: true -> 
		goto BuildRR
	:: true;
	fi;
	
	if
	:: lb_for63_3 != -1 && ub_for63_4 != -1 -> 
				for(i : lb_for63_3.. ub_for63_4) {
for21:			
			if
			:: 0 != -1 && s-1 != -1 -> 
								for(i : 0.. s-1) {
for22:					

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
for22:					

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
for22_exit:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: t.async_send!0;
			:: t.sync!0 -> 
				t.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for21:			
			if
			:: 0 != -1 && s-1 != -1 -> 
								for(i : 0.. s-1) {
for22:					

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
for22:					

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
for22_exit:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: t.async_send!0;
			:: t.sync!0 -> 
				t.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for21_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype dnssetRR(Chandef c;chan child) {
	bool closed; 
	int i;
	chan child_dnssetRFC35975 = [0] of {int};
	
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
		chan child_dnsslurpRemainder3 = [0] of {int};
		run dnsslurpRemainder(c,child_dnsslurpRemainder3);
		child_dnsslurpRemainder3?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	run dnssetRFC3597(c,child_dnssetRFC35974);
	child_dnssetRFC35975?0;
	goto stop_process;
	child!0;
stop_process:
}
proctype dnssetRFC3597(Chandef c;chan child) {
	bool closed; 
	int i;
	chan child_dnsendingToString4 = [0] of {int};
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run dnsendingToString(c,child_dnsendingToString4);
	child_dnsendingToString4?0;
	
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
proctype dnsendingToString(Chandef c;chan child) {
	bool closed; 
	int i;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: lb_for51_5 != -1 && ub_for51_6 != -1 -> 
				for(i : lb_for51_5.. ub_for51_6) {
for23:			
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
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for23:			
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
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for23_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

