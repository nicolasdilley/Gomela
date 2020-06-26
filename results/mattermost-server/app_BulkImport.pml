#define workers  ??
#define lb_for94_1  -1
#define ub_for94_2  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [2 * workers + 1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	
	if
	:: lb_for94_1 != -1 && ub_for94_2 != -1 -> 
				for(i : lb_for94_1.. ub_for94_2) {
for10:			
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
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					linesChan.closing!true;
					
					if
					:: true -> 
						_ch0.in?0;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi;
								for(i : 0.. workers-1) {
for11:
				};
for11_exit:
			:: true;
			fi;
			do
			:: linesChan.in!0 -> 
				linesChan.sending?state;
				break
			:: _ch0.in?0 -> 
				
				if
				:: true -> 
					linesChan.closing!true;
					goto stop_process
				:: true;
				fi;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
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
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					linesChan.closing!true;
					
					if
					:: true -> 
						_ch0.in?0;
						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					:: true;
					fi
				:: true;
				fi;
								for(i : 0.. workers-1) {
for11:
				};
for11_exit:
			:: true;
			fi;
			do
			:: linesChan.in!0 -> 
				linesChan.sending?state;
				break
			:: _ch0.in?0 -> 
				
				if
				:: true -> 
					linesChan.closing!true;
					goto stop_process
				:: true;
				fi;
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		linesChan.closing!true
	:: true;
	fi;
	
	if
	:: true -> 
		_ch0.in?0;
		
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
	goto stop_process
stop_process:}

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
