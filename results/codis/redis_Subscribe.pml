#define sentinels  ??
#define lb_for202_1  -1
#define ub_for202_2  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [sentinels] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:		run Anonymous0(_ch0)
	od;
	
	if
	:: lb_for202_1 != -1 && ub_for202_2 != -1 -> 
				for(i : lb_for202_1.. ub_for202_2) {
for20:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			do
			:: true -> 
				goto stop_process
			:: _ch0.in?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
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
				goto stop_process
			:: _ch0.in?0 -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
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
