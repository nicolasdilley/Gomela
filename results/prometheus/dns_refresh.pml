
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
	do
	:: true -> 
for10:		run Anonymous0()
	od;
	run Anonymous2();
	do
	:: true -> 
for20:
	od;
	goto stop_process
stop_process:}

proctype drefreshOne3(chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for11:
	od;
	do
	:: true -> 
		goto stop_process
	:: ch.in!0 -> 
		ch.sending?state;
		break
	od;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0() {
	bool closed; 
	int i;
	chan child_drefreshOne30 = [0] of {int};
	run drefreshOne3(child_drefreshOne30);
	child_drefreshOne30?0;
stop_process:
}
proctype Anonymous2() {
	bool closed; 
	int i;
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
