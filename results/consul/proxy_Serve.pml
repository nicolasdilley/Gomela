#define lb_for43_0  -1
#define ub_for43_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
		for(i : lb_for43_0.. ub_for43_1) {
for10:		do
		:: _ch0.in?0 -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				run Anonymous0(_ch0)
			:: true;
			fi;
			do
			:: true -> 
for11:
			od;
			break
		:: true -> 
			goto stop_process
		od
	};
for10_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: true -> 
			_ch0.in!0
		:: true;
		fi
	:: true;
	fi;
stop_process:
}
