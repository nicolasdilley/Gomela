
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [0] of {int};
		_ch0.in = _ch0_in;
		chan child_routerNew50 = [0] of {int};
		run routerNew5(_ch0,child_routerNew50);
		child_routerNew50?0
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype routerNew5(Chandef shutdownCh;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
