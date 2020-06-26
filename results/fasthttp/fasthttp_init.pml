#define lb_for2393_0  -1
#define ub_for2393_1  -1

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
		chan _ch0_in = [maxPendingRequests] of {int};
		_ch0.in = _ch0_in;
		
		if
		:: true -> 
			Chandef _ch1;
			chan _ch1_in = [maxPendingRequests] of {int};
			_ch1.in = _ch1_in
		:: true;
		fi;
		run Anonymous0(_ch0,_ch1)
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		fi
	od;
for10_exit:stop_process:
}
