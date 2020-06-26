#define iterations  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [iterations] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
		for(i : 0.. number-1) {
for10:		run Anonymous0()
	};
for10_exit:
stop_process:}

proctype tRandomTests2(int iterations _1;chan child) {
	bool closed; 
	int i;
	run Anonymous1(quit,iterations _1,quit);
	do
	:: true -> 
		break
	:: quit.in?0 -> 
		quit.in!0;
		quit.sending?state;
		break
	:: true -> 
		quit.in!0;
		quit.sending?state;
		break
	od;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef quit;Chandef iterations _1;Chandef quit) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && iterations _1-1 != -1 -> 
				for(i : 0.. iterations _1-1) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	finished.closing!true;
stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	chan child_tRandomTests20 = [0] of {int};
	run tRandomTests2(iterations,child_tRandomTests20);
	child_tRandomTests20?0;
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
