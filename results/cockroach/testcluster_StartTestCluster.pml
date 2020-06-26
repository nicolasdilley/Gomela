#define nodes  ??

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
for10:
	od;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
	
	if
	:: true -> 
		Chandef _ch0;
		chan _ch0_in = [nodes] of {int};
		_ch0.in = _ch0_in
	:: true;
	fi;
		for(i : 0.. nodes-1) {
for30:		
		if
		:: true -> 
			run Anonymous0(_ch0)
		fi
	};
for30_exit:	
	if
	:: true -> 
		
		if
		:: 0 != -1 && nodes-1 != -1 -> 
						for(i : 0.. nodes-1) {
for40:
			}
		:: else -> 
			do
			:: true -> 
for40:
			:: true -> 
				break
			od
		fi;
for40_exit:
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	errCh.in!0;
stop_process:
}
