
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_mwatchForUpdates52 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run mwatchForUpdates5(_ch0,child_mwatchForUpdates52);
	child_mwatchForUpdates52?0
stop_process:}

proctype mwatchForUpdates5(Chandef tableUpdateCh;chan child) {
	bool closed; 
	int i;
	chan child_mwatchForGossipUpdates41 = [0] of {int};
	
	if
	:: true -> 
		chan child_mwatchForRangefeedUpdates40 = [0] of {int};
		run mwatchForRangefeedUpdates4(child_mwatchForRangefeedUpdates40);
		child_mwatchForRangefeedUpdates40?0;
		goto stop_process
	:: true;
	fi;
	run mwatchForGossipUpdates4(child_mwatchForGossipUpdates41);
	child_mwatchForGossipUpdates41?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
proctype mwatchForRangefeedUpdates4(chan child) {
	bool closed; 
	int i;
	Chandef _ch1;
	chan _ch1_in = [0] of {int};
	_ch1.in = _ch1_in;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
proctype mwatchForGossipUpdates4(chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
