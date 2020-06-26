#define lb_for835_0  -1
#define ub_for835_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run go_bindinforunSQL4(_ch0);
	do
	:: _ch0.in?0 -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true -> 
		break
	od;
	_ch0.in?0;
	goto stop_process
stop_process:}

proctype go_bindinforunSQL4(Chandef resultChan) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		resultChan.in!0;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	resultChan.in!0;
	
	if
	:: true -> 
		resultChan.in!0
	:: true;
	fi;
stop_process:
}
