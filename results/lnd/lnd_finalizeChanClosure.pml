
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
	
	if
	:: true -> 
		
		if
		:: true -> 
			closeReq_Err.in!0
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		closeReq_Updates.in!0
	:: true;
	fi;
	run go_lndwaitForChanToClose7(_ch0)
stop_process:}

proctype go_lndwaitForChanToClose7(Chandef errChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			errChan.in!0
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:
}
