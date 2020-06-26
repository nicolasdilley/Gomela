#define lb_for42_0  -1
#define ub_for42_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	
	if
	:: 1 != -1 && numSignals + 1 != -1 -> 
				for(i : 1.. numSignals + 1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	run go_sighandlinghandleSignals4(_ch0,_ch1);
	goto stop_process
stop_process:}

proctype go_sighandlinghandleSignals4(Chandef stop;Chandef done) {
	bool closed; 
	int i;
		for(i : 1.. sigchans) {
for20:
	};
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: true -> 
				done.closing!true;
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	od;
for30_exit:stop_process:
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
