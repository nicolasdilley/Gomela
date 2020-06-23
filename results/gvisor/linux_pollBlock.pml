#define lb_for126_0  -1
#define ub_for126_1  -1

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
		_ch0.in = _ch0_in
	:: true;
	fi;
	do
	:: true -> 
for10:		chan child_linuxinitReadiness40 = [0] of {int};
		run linuxinitReadiness4(child_linuxinitReadiness40);
		child_linuxinitReadiness40?0
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for126_0 != -1 && ub_for126_1 != -1 -> 
				for(i : lb_for126_0.. ub_for126_1) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for21:
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
for21:
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype linuxinitReadiness4(chan child) {
	bool closed; 
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
	child!0;
stop_process:
}
