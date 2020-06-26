#define lb_for76_0  -1
#define ub_for76_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [128] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	goto stop_process
stop_process:}

proctype gcColoredSet5(Chandef output;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: output.in!0 -> 
			output.sending?state;
			break
		:: true -> 
			goto stop_process
		od
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: output.in!0 -> 
			output.sending?state;
			break
		:: true -> 
			goto stop_process
		od
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: output.in!0 -> 
			output.sending?state;
			break
		:: true -> 
			goto stop_process
		od
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
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_gcColoredSet50 = [0] of {int};
	run gcColoredSet5(_ch0,child_gcColoredSet50);
	child_gcColoredSet50?0;
	
	if
	:: true -> 
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
loop:		
	if
	:: lb_for76_0 != -1 && ub_for76_1 != -1 -> 
				for(i : lb_for76_0.. ub_for76_1) {
for20:			do
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						do
						:: _ch0.in!0 -> 
							_ch0.sending?state;
							break
						:: true -> 
							goto loop;
							break
						od
					:: true;
					fi;
					do
					:: _ch0.in!0 -> 
						_ch0.sending?state;
						break
					:: true -> 
						goto loop;
						break
					od
				:: true;
				fi;
				break
			:: true -> 
				goto loop;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: true -> 
						do
						:: _ch0.in!0 -> 
							_ch0.sending?state;
							break
						:: true -> 
							goto loop;
							break
						od
					:: true;
					fi;
					do
					:: _ch0.in!0 -> 
						_ch0.sending?state;
						break
					:: true -> 
						goto loop;
						break
					od
				:: true;
				fi;
				break
			:: true -> 
				goto loop;
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:;
	
	if
	:: true -> 
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: true -> 
			goto stop_process
		od
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: _ch0.in!0 -> 
			_ch0.sending?state;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	_ch0.closing!true;
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
