#define lb_for519_0  -1
#define ub_for519_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [concurrentWorkers] of {int};
	chan _ch1_in = [concurrentWorkers] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
		for(i : 0.. concurrentWorkers-1) {
for10:		run Anonymous0(_ch0,_ch1)
	};
for10_exit:		for(i : 1.. deps) {
for20:		
		if
		:: true -> 
			_ch1.in!0
		:: true;
		fi
	};
	
	if
	:: 0 != -1 && concurrentWorkers-1 != -1 -> 
				for(i : 0.. concurrentWorkers-1) {
for30:			_ch0.in!0
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in!0
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		do
		:: _ch1.in?0 -> 
			break
		:: _ch0.in?0 -> 
			goto stop_process
		od
	od;
for11_exit:stop_process:
}
