#define lb_for565_0  -1
#define ub_for565_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : lb_for565_0.. ub_for565_1) {
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				run Anonymous0(_ch0,done,stop)
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true;
		fi;
		run Anonymous1(_ch0,done,stop)
	};
for10_exit:	_ch0.closing!true
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef done;Chandef stop) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	stop.closing!true;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef done;Chandef stop) {
	bool closed; 
	int i;
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
