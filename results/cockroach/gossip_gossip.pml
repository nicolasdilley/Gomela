#define lb_for149_0  -1
#define ub_for149_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
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
	_ch0.in = _ch0_in;
	_ch1.in = _ch1_in;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for149_0 != -1 && ub_for149_1 != -1 -> 
				for(i : lb_for149_0.. ub_for149_1) {
for10:			
			if
			:: true -> 
				do
				:: true -> 
for11:
				od;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			do
			:: true -> 
				goto stop_process
			:: _ch1.in?0 -> 
				goto stop_process
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: true -> 
				do
				:: true -> 
for11:
				od;
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			do
			:: true -> 
				goto stop_process
			:: _ch1.in?0 -> 
				goto stop_process
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for10_exit:	_ch0.in!0
stop_process:}

