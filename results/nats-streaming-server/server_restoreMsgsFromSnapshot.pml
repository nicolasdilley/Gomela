
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example429967708/server/snapshot.go
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	Wgdef s_ioChannelWG;
	Wgdef s_wg;
	int i;
	
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
			:: true;
			fi
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(s_wg);
	run wgMonitor(s_ioChannelWG);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: first != -1 && last != -1 -> 
				for(i : first.. last) {
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
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
						:: true;
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
						break
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					break
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
							break
						:: true;
						fi
					:: true;
					fi
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
							break
						:: true;
						fi
					:: true;
					fi
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					break
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
							break
						:: true;
						fi
					:: true;
					fi
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
							break
						:: true;
						fi
					:: true;
					fi
				fi
			fi;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
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
						:: true;
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
						break
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					break
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
							break
						:: true;
						fi
					:: true;
					fi
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
							break
						:: true;
						fi
					:: true;
					fi
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi;
				
				if
				:: true -> 
					break
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
							break
						:: true;
						fi
					:: true;
					fi
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
							break
						:: true;
						fi
					:: true;
					fi
				fi
			fi;
			do
			:: true -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od;
stop_process:
}
