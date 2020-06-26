#define lb_for281_0  -1
#define ub_for281_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [partitionN] of {int};
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
	
	if
	:: 0 != -1 && i.partitions-1 != -1 -> 
				for(i : 0.. i.partitions-1) {
for10:			do
			:: true -> 
for11:
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			do
			:: true -> 
for11:
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch0.in = _ch0_in;
		for(i : 0.. n-1) {
for20:		run Anonymous0(_ch0)
	};
for20_exit:	
	if
	:: 0 != -1 && partitionN-1 != -1 -> 
				for(i : 0.. partitionN-1) {
for30:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		do
		:: true -> 
for40:
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch0.in!0
	od;
for21_exit:stop_process:
}
