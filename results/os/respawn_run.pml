#define lb_for132_0  -1
#define ub_for132_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [lines] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	do
	:: true -> 
for10:		run go_respawnexecute2(_ch0)
	od;
	
	if
	:: 0 != -1 && lines-1 != -1 -> 
				for(i : 0.. lines-1) {
for20:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype go_respawnexecute2(Chandef doneChannel) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				break
			:: true;
			fi
		:: true;
		fi
	od;
for11_exit:	doneChannel.in!0;
stop_process:
}
