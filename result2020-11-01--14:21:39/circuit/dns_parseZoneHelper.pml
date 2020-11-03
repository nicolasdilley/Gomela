#define parseZoneHelper_chansize 3
#define lb_for492_1  -1
#define ub_for492_2  -1
#define lb_for62_3  -1
#define ub_for62_4  -1
#define lb_for1466_5  -1
#define ub_for1466_6  -1
#define lb_for1498_7  -1
#define ub_for1498_8  -1
#define lb_for1080_9  -1
#define ub_for1080_10  -1
#define lb_for201_11  -1
#define ub_for201_12  -1
#define lb_for1335_13  -1
#define ub_for1335_14  -1
#define lb_for1400_15  -1
#define ub_for1400_16  -1
#define lb_for1554_17  -1
#define ub_for1554_18  -1
#define lb_for225_19  -1
#define ub_for225_20  -1
#define lb_for251_21  -1
#define ub_for251_22  -1
#define lb_for1141_23  -1
#define ub_for1141_24  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example731571677/github.com/miekg/dns/zscan.go
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
	Chandef t;
	int i;
	int chansize = parseZoneHelper_chansize;
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
	bool state;
	Chandef c;
	
	if
	:: 1000 > 0 -> 
		c.size = 1000;
		run emptyChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
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
			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
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
				chan child_dnssetRR87 = [0] of {int};
				run dnssetRR(c,child_dnssetRR3);
				child_dnssetRR87?0;
				
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
stop_process:	
	if
	:: true -> 
		t.closing!true
	:: true;
	fi
}
proctype go_dnszlexer(Chandef c) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for492_1 != -1 && ub_for492_2 != -1 -> 
				for(i : lb_for492_1.. ub_for492_2) {
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
stop_process:	c.closing!true
}
proctype dnsslurpRemainder(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnsgenerate(Chandef c;Chandef t;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
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
	:: lb_for62_3 != -1 && ub_for62_4 != -1 -> 
				for(i : lb_for62_3.. ub_for62_4) {
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
stop_process:	child!0
}
proctype dnssetRR(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsslurpRemainder86 = [0] of {int};
	

	if
	:: true -> 
		chan child_dnssetA3 = [0] of {int};
		run dnssetA(c,child_dnssetA3);
		child_dnssetA3?0;
		goto Slurp
	:: true -> 
		chan child_dnssetAAAA4 = [0] of {int};
		run dnssetAAAA(c,child_dnssetAAAA4);
		child_dnssetAAAA4?0;
		goto Slurp
	:: true -> 
		chan child_dnssetHINFO5 = [0] of {int};
		run dnssetHINFO(c,child_dnssetHINFO5);
		child_dnssetHINFO5?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMINFO6 = [0] of {int};
		run dnssetMINFO(c,child_dnssetMINFO6);
		child_dnssetMINFO6?0;
		goto Slurp
	:: true -> 
		chan child_dnssetNS7 = [0] of {int};
		run dnssetNS(c,child_dnssetNS7);
		child_dnssetNS7?0;
		goto Slurp
	:: true -> 
		chan child_dnssetPTR8 = [0] of {int};
		run dnssetPTR(c,child_dnssetPTR8);
		child_dnssetPTR8?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMF9 = [0] of {int};
		run dnssetMF(c,child_dnssetMF9);
		child_dnssetMF9?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMD10 = [0] of {int};
		run dnssetMD(c,child_dnssetMD10);
		child_dnssetMD10?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMG11 = [0] of {int};
		run dnssetMG(c,child_dnssetMG11);
		child_dnssetMG11?0;
		goto Slurp
	:: true -> 
		chan child_dnssetRT12 = [0] of {int};
		run dnssetRT(c,child_dnssetRT12);
		child_dnssetRT12?0;
		goto Slurp
	:: true -> 
		chan child_dnssetAFSDB13 = [0] of {int};
		run dnssetAFSDB(c,child_dnssetAFSDB13);
		child_dnssetAFSDB13?0;
		goto Slurp
	:: true -> 
		chan child_dnssetX2514 = [0] of {int};
		run dnssetX25(c,child_dnssetX2514);
		child_dnssetX2514?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMX15 = [0] of {int};
		run dnssetMX(c,child_dnssetMX15);
		child_dnssetMX15?0;
		goto Slurp
	:: true -> 
		chan child_dnssetCNAME16 = [0] of {int};
		run dnssetCNAME(c,child_dnssetCNAME16);
		child_dnssetCNAME16?0;
		goto Slurp
	:: true -> 
		chan child_dnssetDNAME17 = [0] of {int};
		run dnssetDNAME(c,child_dnssetDNAME17);
		child_dnssetDNAME17?0;
		goto Slurp
	:: true -> 
		chan child_dnssetSOA18 = [0] of {int};
		run dnssetSOA(c,child_dnssetSOA18);
		child_dnssetSOA18?0;
		goto Slurp
	:: true -> 
		chan child_dnssetSSHFP19 = [0] of {int};
		run dnssetSSHFP(c,child_dnssetSSHFP19);
		child_dnssetSSHFP19?0;
		goto Slurp
	:: true -> 
		chan child_dnssetSRV20 = [0] of {int};
		run dnssetSRV(c,child_dnssetSRV20);
		child_dnssetSRV20?0;
		goto Slurp
	:: true -> 
		chan child_dnssetNAPTR21 = [0] of {int};
		run dnssetNAPTR(c,child_dnssetNAPTR21);
		child_dnssetNAPTR21?0;
		goto Slurp
	:: true -> 
		chan child_dnssetTALINK22 = [0] of {int};
		run dnssetTALINK(c,child_dnssetTALINK22);
		child_dnssetTALINK22?0;
		goto Slurp
	:: true -> 
		chan child_dnssetRP23 = [0] of {int};
		run dnssetRP(c,child_dnssetRP23);
		child_dnssetRP23?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMR24 = [0] of {int};
		run dnssetMR(c,child_dnssetMR24);
		child_dnssetMR24?0;
		goto Slurp
	:: true -> 
		chan child_dnssetMB25 = [0] of {int};
		run dnssetMB(c,child_dnssetMB25);
		child_dnssetMB25?0;
		goto Slurp
	:: true -> 
		chan child_dnssetKX26 = [0] of {int};
		run dnssetKX(c,child_dnssetKX26);
		child_dnssetKX26?0;
		goto Slurp
	:: true -> 
		chan child_dnssetNID27 = [0] of {int};
		run dnssetNID(c,child_dnssetNID27);
		child_dnssetNID27?0;
		goto Slurp
	:: true -> 
		chan child_dnssetL3228 = [0] of {int};
		run dnssetL32(c,child_dnssetL3228);
		child_dnssetL3228?0;
		goto Slurp
	:: true -> 
		chan child_dnssetL6429 = [0] of {int};
		run dnssetL64(c,child_dnssetL6429);
		child_dnssetL6429?0;
		goto Slurp
	:: true -> 
		chan child_dnssetLP30 = [0] of {int};
		run dnssetLP(c,child_dnssetLP30);
		child_dnssetLP30?0;
		goto Slurp
	:: true -> 
		chan child_dnssetNSEC3PARAM31 = [0] of {int};
		run dnssetNSEC3PARAM(c,child_dnssetNSEC3PARAM31);
		child_dnssetNSEC3PARAM31?0;
		goto Slurp
	:: true -> 
		chan child_dnssetEUI4832 = [0] of {int};
		run dnssetEUI48(c,child_dnssetEUI4832);
		child_dnssetEUI4832?0;
		goto Slurp
	:: true -> 
		chan child_dnssetEUI6433 = [0] of {int};
		run dnssetEUI64(c,child_dnssetEUI6433);
		child_dnssetEUI6433?0;
		goto Slurp
	:: true -> 
		chan child_dnssetUID34 = [0] of {int};
		run dnssetUID(c,child_dnssetUID34);
		child_dnssetUID34?0;
		goto Slurp
	:: true -> 
		chan child_dnssetGID35 = [0] of {int};
		run dnssetGID(c,child_dnssetGID35);
		child_dnssetGID35?0;
		goto Slurp
	:: true -> 
		chan child_dnssetLOC36 = [0] of {int};
		run dnssetLOC(c,child_dnssetLOC36);
		child_dnssetLOC36?0;
		goto Slurp
	:: true -> 
		chan child_dnssetNSAPPTR37 = [0] of {int};
		run dnssetNSAPPTR(c,child_dnssetNSAPPTR37);
		child_dnssetNSAPPTR37?0;
		goto Slurp
	:: true -> 
		chan child_dnssetGPOS38 = [0] of {int};
		run dnssetGPOS(c,child_dnssetGPOS38);
		child_dnssetGPOS38?0;
		goto Slurp
	:: true -> 
		chan child_dnssetPX39 = [0] of {int};
		run dnssetPX(c,child_dnssetPX39);
		child_dnssetPX39?0;
		goto Slurp
	:: true -> 
		chan child_dnssetEID41 = [0] of {int};
		run dnssetEID(c,child_dnssetEID40);
		child_dnssetEID41?0;
		goto stop_process
	:: true -> 
		chan child_dnssetNIMLOC43 = [0] of {int};
		run dnssetNIMLOC(c,child_dnssetNIMLOC42);
		child_dnssetNIMLOC43?0;
		goto stop_process
	:: true -> 
		chan child_dnssetNSAP45 = [0] of {int};
		run dnssetNSAP(c,child_dnssetNSAP44);
		child_dnssetNSAP45?0;
		goto stop_process
	:: true -> 
		chan child_dnssetDNSKEY47 = [0] of {int};
		run dnssetDNSKEY(c,child_dnssetDNSKEY46);
		child_dnssetDNSKEY47?0;
		goto stop_process
	:: true -> 
		chan child_dnssetRKEY49 = [0] of {int};
		run dnssetRKEY(c,child_dnssetRKEY48);
		child_dnssetRKEY49?0;
		goto stop_process
	:: true -> 
		chan child_dnssetRRSIG51 = [0] of {int};
		run dnssetRRSIG(c,child_dnssetRRSIG50);
		child_dnssetRRSIG51?0;
		goto stop_process
	:: true -> 
		chan child_dnssetNSEC52 = [0] of {int};
		run dnssetNSEC(c,child_dnssetNSEC52);
		child_dnssetNSEC52?0;
		goto stop_process
	:: true -> 
		chan child_dnssetNSEC353 = [0] of {int};
		run dnssetNSEC3(c,child_dnssetNSEC353);
		child_dnssetNSEC353?0;
		goto stop_process
	:: true -> 
		chan child_dnssetWKS54 = [0] of {int};
		run dnssetWKS(c,child_dnssetWKS54);
		child_dnssetWKS54?0;
		goto stop_process
	:: true -> 
		chan child_dnssetDS56 = [0] of {int};
		run dnssetDS(c,child_dnssetDS55);
		child_dnssetDS56?0;
		goto stop_process
	:: true -> 
		chan child_dnssetCDS58 = [0] of {int};
		run dnssetCDS(c,child_dnssetCDS57);
		child_dnssetCDS58?0;
		goto stop_process
	:: true -> 
		chan child_dnssetDLV60 = [0] of {int};
		run dnssetDLV(c,child_dnssetDLV59);
		child_dnssetDLV60?0;
		goto stop_process
	:: true -> 
		chan child_dnssetTA62 = [0] of {int};
		run dnssetTA(c,child_dnssetTA61);
		child_dnssetTA62?0;
		goto stop_process
	:: true -> 
		chan child_dnssetTLSA64 = [0] of {int};
		run dnssetTLSA(c,child_dnssetTLSA63);
		child_dnssetTLSA64?0;
		goto stop_process
	:: true -> 
		chan child_dnssetTXT66 = [0] of {int};
		run dnssetTXT(c,child_dnssetTXT65);
		child_dnssetTXT66?0;
		goto stop_process
	:: true -> 
		chan child_dnssetURI68 = [0] of {int};
		run dnssetURI(c,child_dnssetURI67);
		child_dnssetURI68?0;
		goto stop_process
	:: true -> 
		chan child_dnssetNINFO70 = [0] of {int};
		run dnssetNINFO(c,child_dnssetNINFO69);
		child_dnssetNINFO70?0;
		goto stop_process
	:: true -> 
		chan child_dnssetHIP71 = [0] of {int};
		run dnssetHIP(c,child_dnssetHIP71);
		child_dnssetHIP71?0;
		goto stop_process
	:: true -> 
		chan child_dnssetSPF73 = [0] of {int};
		run dnssetSPF(c,child_dnssetSPF72);
		child_dnssetSPF73?0;
		goto stop_process
	:: true -> 
		chan child_dnssetDHCID75 = [0] of {int};
		run dnssetDHCID(c,child_dnssetDHCID74);
		child_dnssetDHCID75?0;
		goto stop_process
	:: true -> 
		chan child_dnssetIPSECKEY77 = [0] of {int};
		run dnssetIPSECKEY(c,child_dnssetIPSECKEY76);
		child_dnssetIPSECKEY77?0;
		goto stop_process
	:: true -> 
		chan child_dnssetUINFO79 = [0] of {int};
		run dnssetUINFO(c,child_dnssetUINFO78);
		child_dnssetUINFO79?0;
		goto stop_process
	:: true -> 
		chan child_dnssetCERT81 = [0] of {int};
		run dnssetCERT(c,child_dnssetCERT80);
		child_dnssetCERT81?0;
		goto stop_process
	:: true -> 
		chan child_dnssetOPENPGPKEY83 = [0] of {int};
		run dnssetOPENPGPKEY(c,child_dnssetOPENPGPKEY82);
		child_dnssetOPENPGPKEY83?0;
		goto stop_process
	:: true -> 
		chan child_dnssetRFC359785 = [0] of {int};
		run dnssetRFC3597(c,child_dnssetRFC359784);
		child_dnssetRFC359785?0;
		goto stop_process
	fi;
Slurp:		
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run dnsslurpRemainder(c,child_dnsslurpRemainder86);
	child_dnsslurpRemainder86?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetA(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetAAAA(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetHINFO(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetMINFO(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetNS(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetPTR(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetMF(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetMD(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetMG(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetRT(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetAFSDB(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetX25(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetMX(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetCNAME(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetDNAME(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetSOA(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: 0 != -1 && 5-1 != -1 -> 
				for(i : 0.. 5-1) {
for23:			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi;
			
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
			fi;
			

			if
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for23:			
			if
			:: c.async_rcv?0;
			:: c.sync?0;
			fi;
			
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
			fi;
			

			if
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for23_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetSSHFP(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetSRV(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetNAPTR(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetTALINK(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetRP(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetMR(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetMB(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetKX(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetNID(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	goto stop_process;
stop_process:	child!0
}
proctype dnssetL32(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	goto stop_process;
stop_process:	child!0
}
proctype dnssetL64(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	goto stop_process;
stop_process:	child!0
}
proctype dnssetLP(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
stop_process:	child!0
}
proctype dnssetNSEC3PARAM(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetEUI48(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for1466_5 != -1 && ub_for1466_6 != -1 -> 
				for(i : lb_for1466_5.. ub_for1466_6) {
for24:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for24:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for24_exit:	
	if
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetEUI64(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for1498_7 != -1 && ub_for1498_8 != -1 -> 
				for(i : lb_for1498_7.. ub_for1498_8) {
for25:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for25:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for25_exit:	
	if
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetUID(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetGID(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetLOC(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
		goto East
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
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
		goto East
	:: true;
	fi;
	goto stop_process;
East:		
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
		goto Altitude
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
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
		goto Altitude
	:: true;
	fi;
	goto stop_process;
Altitude:		
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
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: lb_for1080_9 != -1 && ub_for1080_10 != -1 -> 
				for(i : lb_for1080_9.. ub_for1080_10) {
for26:			

			if
			:: true -> 
				

				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					fi
				fi
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
for26:			

			if
			:: true -> 
				

				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					fi
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					fi
				fi
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
for26_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetNSAPPTR(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
stop_process:	child!0
}
proctype dnssetGPOS(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetPX(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetEID(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString40 = [0] of {int};
	run dnsendingToString(c,child_dnsendingToString40);
	child_dnsendingToString40?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnsendingToString(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: lb_for201_11 != -1 && ub_for201_12 != -1 -> 
				for(i : lb_for201_11.. ub_for201_12) {
for27:			

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
for27:			

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
for27_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetNIMLOC(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString42 = [0] of {int};
	run dnsendingToString(c,child_dnsendingToString42);
	child_dnsendingToString42?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetNSAP(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString44 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	run dnsendingToString(c,child_dnsendingToString44);
	child_dnsendingToString44?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetDNSKEY(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString46 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
	fi;
	run dnsendingToString(c,child_dnsendingToString46);
	child_dnsendingToString46?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetRKEY(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString48 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
	fi;
	run dnsendingToString(c,child_dnsendingToString48);
	child_dnsendingToString48?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetRRSIG(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString50 = [0] of {int};
	
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
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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
		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		fi
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	run dnsendingToString(c,child_dnsendingToString50);
	child_dnsendingToString50?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetNSEC(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: lb_for1335_13 != -1 && ub_for1335_14 != -1 -> 
				for(i : lb_for1335_13.. ub_for1335_14) {
for28:			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
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
for28:			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
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
for28_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetNSEC3(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
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
	:: lb_for1400_15 != -1 && ub_for1400_16 != -1 -> 
				for(i : lb_for1400_15.. ub_for1400_16) {
for29:			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
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
for29:			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
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
for29_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetWKS(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		fi
	:: true -> 
		

		if
		:: true;
		:: true;
		:: true -> 
			goto stop_process
		fi
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
	:: lb_for1554_17 != -1 && ub_for1554_18 != -1 -> 
				for(i : lb_for1554_17.. ub_for1554_18) {
for210:			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				:: true;
				fi
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
for210:			

			if
			:: true;
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				:: true;
				fi
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
for210_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetDS(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString55 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
		
		if
		:: true -> 
			goto stop_process
		fi
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
	fi;
	run dnsendingToString(c,child_dnsendingToString55);
	child_dnsendingToString55?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetCDS(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString57 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
		
		if
		:: true -> 
			goto stop_process
		fi
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
	fi;
	run dnsendingToString(c,child_dnsendingToString57);
	child_dnsendingToString57?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetDLV(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString59 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
		
		if
		:: true -> 
			goto stop_process
		fi
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
	fi;
	run dnsendingToString(c,child_dnsendingToString59);
	child_dnsendingToString59?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetTA(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString61 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
		
		if
		:: true -> 
			goto stop_process
		fi
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
	fi;
	run dnsendingToString(c,child_dnsendingToString61);
	child_dnsendingToString61?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetTLSA(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString63 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
	fi;
	run dnsendingToString(c,child_dnsendingToString63);
	child_dnsendingToString63?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetTXT(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToTxtSlice65 = [0] of {int};
	run dnsendingToTxtSlice(c,child_dnsendingToTxtSlice65);
	child_dnsendingToTxtSlice65?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnsendingToTxtSlice(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	

	if
	:: true -> 
		
		if
		:: lb_for225_19 != -1 && ub_for225_20 != -1 -> 
						for(i : lb_for225_19.. ub_for225_20) {
for211:				

				if
				:: true;
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
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
for211:				

				if
				:: true;
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
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
for211_exit:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: lb_for251_21 != -1 && ub_for251_22 != -1 -> 
						for(i : lb_for251_21.. ub_for251_22) {
for212:				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			}
		:: else -> 
			do
			:: true -> 
for212:				
				if
				:: c.async_rcv?0;
				:: c.sync?0;
				fi
			:: true -> 
				break
			od
		fi;
for212_exit:
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetURI(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToTxtSlice67 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	run dnsendingToTxtSlice(c,child_dnsendingToTxtSlice67);
	child_dnsendingToTxtSlice67?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetNINFO(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToTxtSlice69 = [0] of {int};
	run dnsendingToTxtSlice(c,child_dnsendingToTxtSlice69);
	child_dnsendingToTxtSlice69?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetHIP(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	
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
	:: true -> 
		goto stop_process
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
	:: c.async_rcv?0;
	:: c.sync?0;
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
	:: lb_for1141_23 != -1 && ub_for1141_24 != -1 -> 
				for(i : lb_for1141_23.. ub_for1141_24) {
for213:			

			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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
for213:			

			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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
for213_exit:	goto stop_process;
stop_process:	child!0
}
proctype dnssetSPF(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToTxtSlice72 = [0] of {int};
	run dnsendingToTxtSlice(c,child_dnsendingToTxtSlice72);
	child_dnsendingToTxtSlice72?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetDHCID(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString74 = [0] of {int};
	run dnsendingToString(c,child_dnsendingToString74);
	child_dnsendingToString74?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetIPSECKEY(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString76 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	
	if
	:: c.async_rcv?0;
	:: c.sync?0;
	fi;
	run dnsendingToString(c,child_dnsendingToString76);
	child_dnsendingToString76?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetUINFO(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToTxtSlice78 = [0] of {int};
	run dnsendingToTxtSlice(c,child_dnsendingToTxtSlice78);
	child_dnsendingToTxtSlice78?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetCERT(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString80 = [0] of {int};
	
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
	:: true -> 
		goto stop_process
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
	fi;
	run dnsendingToString(c,child_dnsendingToString80);
	child_dnsendingToString80?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetOPENPGPKEY(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString82 = [0] of {int};
	run dnsendingToString(c,child_dnsendingToString82);
	child_dnsendingToString82?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype dnssetRFC3597(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_dnsendingToString84 = [0] of {int};
	
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
	run dnsendingToString(c,child_dnsendingToString84);
	child_dnsendingToString84?0;
	
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
stop_process:	child!0
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


