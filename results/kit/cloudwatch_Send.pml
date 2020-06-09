#define lb_for235_0  -1
#define ub_for235_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [len(batches)] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: lb_for235_0 != -1 && ub_for235_1 != -1 -> 
				for(i : lb_for235_0.. ub_for235_1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch0.in = _ch0_in;
	do
	:: true -> 
for20:		run Anonymous0()
	od;
	
	if
	:: 0 != -1 && cap(_ch0)-1 != -1 -> 
				for(i : 0.. cap(_ch0)-1) {
for30:
		}
	:: else -> 
		do
		:: true -> 
for30:
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0() {
	bool closed; 
	int i;
stop_process:
}
