
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_utilMergeChannelTo30 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run utilMergeChannelTo3(_ch0,child_utilMergeChannelTo30);
	child_utilMergeChannelTo30?0;
	goto stop_process
stop_process:}

proctype utilMergeChannelTo3(Chandef out;chan child) {
	bool closed; 
	int i;
		for(i : 1.. cs) {
for10:		run Anonymous1(out,out)
	};
	run Anonymous2(out,out);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef out;Chandef out) {
	bool closed; 
	int i;
	do
	:: c.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			c.in?0;
			out.in!0;
			out.sending?state
		fi
	od;
stop_process:
}
proctype Anonymous2(Chandef out;Chandef out) {
	bool closed; 
	int i;
	out.closing!true;
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
