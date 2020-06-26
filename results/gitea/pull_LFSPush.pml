
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
	run go_pipelineRevListObjects6(_ch0);
	do
	:: _ch0.in?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		break
	od;
	goto stop_process
stop_process:}

proctype go_pipelineRevListObjects6(Chandef errChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		errChan.in!0
	:: true;
	fi;
stop_process:
}
