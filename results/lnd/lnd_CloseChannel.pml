#define lb_for2197_0  -1
#define ub_for2197_1  -1

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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef _ch1;
		chan _ch1_in = [1] of {int};
		Chandef _ch0;
		chan _ch0_in = [2] of {int};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch0.in = _ch0_in;
		_ch0.in!0;
		_ch1.in = _ch1_in;
		run go_lndwaitForChanToClose7(_ch1)
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
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
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
out:		do
	:: true -> 
for10:		do
		:: errChan.in?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:;
	goto stop_process
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
