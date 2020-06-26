
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	chan _ch2_in = [0] of {int};
	bool state = false;
	chan _ch1_in = [numWorkers] of {int};
	int i;
	Chandef _ch2;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
		for(i : 0.. numWorkers-1) {
for10:		run go_hugolibpageRenderer5(_ch1,_ch0)
	};
for10_exit:	_ch1.closing!true;
	_ch0.closing!true;
	_ch2.in?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype go_hugolibpageRenderer5(Chandef pages;Chandef results) {
	bool closed; 
	int i;
	do
	:: pages.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			pages.in?0;
			
			if
			:: true -> 
				results.in!0;
				results.sending?state
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					results.in!0;
					results.sending?state
				:: true;
				fi
			:: true;
			fi
		fi
	od;
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
