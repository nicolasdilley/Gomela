#define lb_for644_0  -1
#define ub_for644_1  -1
#define lb_for664_2  -1
#define ub_for664_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [i.PartitionN] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for644_0 != -1 && ub_for644_1 != -1 -> 
				for(i : lb_for644_0.. ub_for644_1) {
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
		for(i : 0.. n-1) {
for20:		run Anonymous0(_ch0)
	};
for20_exit:	
	if
	:: 0 != -1 && cap(_ch0)-1 != -1 -> 
				for(i : 0.. cap(_ch0)-1) {
for30:			_ch0.in?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			_ch0.in?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
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
		
		if
		:: true -> 
			_ch0.in!0
		:: true;
		fi;
		do
		:: true -> 
for22:			
			if
			:: true -> 
				do
				:: true -> 
for23:
				od
			:: true;
			fi
		od;
		_ch0.in!0
	od;
for21_exit:stop_process:
}
