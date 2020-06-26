#define lb_for403_0  -1
#define ub_for403_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan child_cfetchDone11 = [0] of {int};
	chan _ch0_in = [1] of {int};
	bool state = false;
	chan child_cfetchStart10 = [0] of {int};
	int i;
	Chandef _ch0;
	
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
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
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
	_ch0.in = _ch0_in;
	_ch0.in!0;
	run cfetchStart1(_ch0,child_cfetchStart10);
	child_cfetchStart10?0;
	do
	:: true -> 
for10:		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		:: _ch0.in?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od
	od;
for10_exit:	run cfetchDone1(_ch0,child_cfetchDone11);
	child_cfetchDone11?0
stop_process:}

proctype cfetchStart1(Chandef rootUpdateCh;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype cfetchDone1(Chandef rootUpdateCh;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
