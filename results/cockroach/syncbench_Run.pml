#define lb_for185_0  -1
#define ub_for185_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [3] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
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
		for(i : 1.. workers) {
for10:
	};
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0);
	
	if
	:: true -> 
		run Anonymous1(_ch0)
	:: true;
	fi;
	
	if
	:: lb_for185_0 != -1 && ub_for185_1 != -1 -> 
				for(i : lb_for185_0.. ub_for185_1) {
for20:			do
			:: true -> 
				do
				:: true -> 
for21:
				od;
				break
			:: _ch0.in?0 -> 
				goto stop_process
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				do
				:: true -> 
for21:
				od;
				break
			:: _ch0.in?0 -> 
				goto stop_process
			od
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.in!0;
stop_process:
}
