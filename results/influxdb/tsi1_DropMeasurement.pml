#define lb_for608_0  -1
#define ub_for608_1  -1

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
	_ch0.in = _ch0_in;
		for(i : 0.. n-1) {
for10:		run Anonymous0(_ch0)
	};
for10_exit:	
	if
	:: 0 != -1 && cap(_ch0)-1 != -1 -> 
				for(i : 0.. cap(_ch0)-1) {
for20:			_ch0.in?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in?0;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		_ch0.in!0
	od;
for11_exit:stop_process:
}
