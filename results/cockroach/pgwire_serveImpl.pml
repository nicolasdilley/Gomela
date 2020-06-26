#define lb_for320_0  -1
#define ub_for320_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		do
		:: true -> 
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch0.in = _ch0_in;
		run chanMonitor(_ch0);
		_ch0.closing!true;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
Loop:		do
	:: true -> 
for20:		
		if
		:: true -> 
			goto Loop
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto Loop
				:: true;
				fi;
				
				if
				:: true -> 
					goto Loop
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				goto Loop
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			goto Loop
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					break
				:: true;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true;
		:: true;
		:: true;
		:: true;
		:: true;
		:: true -> 
			goto Loop
		:: true;
		:: true;
		:: true;
		:: true;
		fi;
		
		if
		:: true -> 
			goto Loop
		:: true;
		fi
	od;
for20_exit:;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi
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
