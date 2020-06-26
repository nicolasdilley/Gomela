
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
for11:
		od
	od;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [2] of {int};
		do
		:: true -> 
for20:
		od;
		_ch0.in = _ch0_in;
		run Anonymous0(_ch0)
	:: true;
	fi;
	
	if
	:: 0 != -1 && c.Width-1 != -1 -> 
				for(i : 0.. c.Width-1) {
for40:			
			if
			:: 0 != -1 && c.Height-1 != -1 -> 
								for(i : 0.. c.Height-1) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		}
	:: else -> 
		do
		:: true -> 
for40:			
			if
			:: 0 != -1 && c.Height-1 != -1 -> 
								for(i : 0.. c.Height-1) {
for41:
				}
			:: else -> 
				do
				:: true -> 
for41:
				:: true -> 
					break
				od
			fi;
for41_exit:
		:: true -> 
			break
		od
	fi;
for40_exit:	
	if
	:: 1 != -1 && c.Height-1 != -1 -> 
				for(i : 1.. c.Height-1) {
for50:			
			if
			:: 1 != -1 && c.Width - 1-1 != -1 -> 
								for(i : 1.. c.Width - 1-1) {
for51:
				}
			:: else -> 
				do
				:: true -> 
for51:
				:: true -> 
					break
				od
			fi;
for51_exit:
		}
	:: else -> 
		do
		:: true -> 
for50:			
			if
			:: 1 != -1 && c.Width - 1-1 != -1 -> 
								for(i : 1.. c.Width - 1-1) {
for51:
				}
			:: else -> 
				do
				:: true -> 
for51:
				:: true -> 
					break
				od
			fi;
for51_exit:
		:: true -> 
			break
		od
	fi;
for50_exit:
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
stop_process:
}
