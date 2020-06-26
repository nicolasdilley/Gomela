#define lb_for467_0  -1
#define ub_for467_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [10] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 0.. n-1) {
for20:		run Anonymous0(outputs,inputs)
	};
for20_exit:	run Anonymous2(outputs,inputs);
Outer:		do
	:: true -> 
for40:
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: true -> 
for50:
		od;
		goto stop_process
	:: true;
	fi;
	
	if
	:: 0 != -1 && n-1 != -1 -> 
				for(i : 0.. n-1) {
for60:			.closing!true;
			do
			:: true -> 
for61:
			od
		}
	:: else -> 
		do
		:: true -> 
for60:			.closing!true;
			do
			:: true -> 
for61:
			od
		:: true -> 
			break
		od
	fi;
for60_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	
	if
	:: true -> 
		
		if
		:: 0 != -1 && n-1 != -1 -> 
						for(i : 0.. n-1) {
for10:				.closing!true;
				do
				:: true -> 
for11:
				od
			}
		:: else -> 
			do
			:: true -> 
for10:				.closing!true;
				do
				:: true -> 
for11:
				od
			:: true -> 
				break
			od
		fi;
for10_exit:
	:: true;
	fi
stop_process:}

proctype hprocessWALSamples3(chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		do
		:: true -> 
for22:
		od;
		output.in!0;
		output.sending?state
	od;
	goto stop_process;
	output.closing!true;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef ;Chandef ) {
	bool closed; 
	int i;
	chan child_hprocessWALSamples30 = [0] of {int};
	run hprocessWALSamples3(child_hprocessWALSamples30);
	child_hprocessWALSamples30?0;
stop_process:
}
proctype Anonymous2(Chandef ;Chandef ) {
	bool closed; 
	int i;
	
	if
	:: lb_for467_0 != -1 && ub_for467_1 != -1 -> 
				for(i : lb_for467_0.. ub_for467_1) {
for30:			

			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				decoded.in!0;
				decoded.sending?state
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				decoded.in!0;
				decoded.sending?state
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				decoded.in!0;
				decoded.sending?state
			:: true -> 
				goto stop_process
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			

			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				decoded.in!0;
				decoded.sending?state
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				decoded.in!0;
				decoded.sending?state
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				decoded.in!0;
				decoded.sending?state
			:: true -> 
				goto stop_process
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	_ch0.closing!true;
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
