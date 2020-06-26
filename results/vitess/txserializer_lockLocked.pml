
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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [txs.concurrentTransactions] of {int};
		_ch0.in = _ch0_in;
		_ch0.in!0
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: q_availableSlots.in!0 -> 
		goto stop_process
	:: true -> 
		break
	od;
	do
	:: q_availableSlots.in!0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

