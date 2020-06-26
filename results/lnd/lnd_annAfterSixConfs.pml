
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
		chan _ch0_in = [1] of {int};
		_ch0.in = _ch0_in;
		chan child_f_cfgNotifyWhenOnline20 = [0] of {int};
		run f_cfgNotifyWhenOnline2(_ch0,child_f_cfgNotifyWhenOnline20);
		child_f_cfgNotifyWhenOnline20?0;
		do
		:: _ch0.in?0 -> 
			break
		:: true -> 
			goto stop_process
		od;
		
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
		do
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

proctype f_cfgNotifyWhenOnline2(Chandef peerChan;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: peerChan.in!0 -> 
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	child!0;
stop_process:
}
