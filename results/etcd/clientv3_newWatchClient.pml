
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_wwaitCancelSubstreams10 = [0] of {int};
	chan _ch1_in = [0] of {int};
	bool state = false;
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	w_resumec.closing!true;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	do
	:: true -> 
for10:
	od;
	do
	:: true -> 
for20:
	od;
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run wwaitCancelSubstreams1(_ch1,child_wwaitCancelSubstreams10);
	child_wwaitCancelSubstreams10?0;
	_ch1.closing!true;
		for(i : 1.. w.resuming) {
for40:
	};
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype wwaitCancelSubstreams1(Chandef stopc;chan child) {
	bool closed; 
	int i;
	Chandef _ch2;
	chan _ch2_in = [0] of {int};
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	do
	:: true -> 
for30:		run Anonymous1(stopc,_ch2,stopc)
	od;
	run Anonymous3(stopc,_ch2,stopc);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef stopc;Chandef _ch2;Chandef stopc) {
	bool closed; 
	int i;
	w_closingc.in!0;
	w_closingc.sending?state;
stop_process:
}
proctype Anonymous1(Chandef stopc;Chandef _ch2;Chandef stopc) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			ws_outc.closing!true
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
		ws_outc.closing!true;
		run Anonymous1(stopc,_ch2,stopc);
		break
	:: stopc.in?0 -> 
		break
	od;
stop_process:
}
proctype Anonymous3(Chandef stopc;Chandef _ch2;Chandef stopc) {
	bool closed; 
	int i;
	_ch2.closing!true;
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
