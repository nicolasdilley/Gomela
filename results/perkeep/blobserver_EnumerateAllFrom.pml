#define lb_for38_0  -1
#define ub_for38_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : lb_for38_0.. ub_for38_1) {
for10:		run Anonymous0(_ch0,ch);
		chan child_srcEnumerateBlobs40 = [0] of {int};
		run srcEnumerateBlobs4(child_srcEnumerateBlobs40);
		child_srcEnumerateBlobs40?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch0.in?0;
		
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
	};
for10_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef ch) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:
	od;
	_ch0.in!0;
	_ch0.sending?state;
stop_process:
}
proctype srcEnumerateBlobs4(chan child) {
	bool closed; 
	int i;
	dest.closing!true;
	goto stop_process;
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
