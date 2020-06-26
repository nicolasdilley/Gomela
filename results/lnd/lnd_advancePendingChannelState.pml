
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		run Anonymous0();
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
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
proctype Anonymous0() {
	bool closed; 
	int i;
	chan child_f_cfgNotifyWhenOnline20 = [0] of {int};
	Chandef _ch0;
	chan _ch0_in = [1] of {int};
	chan child_f_cfgNotifyWhenOnline20 = [0] of {int};
	run f_cfgNotifyWhenOnline2(_ch0,child_f_cfgNotifyWhenOnline20);
	child_f_cfgNotifyWhenOnline20?0;
	do
	:: _ch0.in?0 -> 
		break
	:: true -> 
		goto stop_process
	od;
stop_process:
}
