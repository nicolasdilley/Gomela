
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
		chan child_cRead10 = [0] of {int};
		run cRead1(child_cRead10);
		child_cRead10?0
	:: true;
	fi
stop_process:}

proctype cRead1(chan child) {
	bool closed; 
	int i;
	run Anonymous1(stream,stream);
	child!0;
stop_process:
}
proctype Anonymous1(Chandef stream;Chandef stream) {
	bool closed; 
	int i;
	do
	:: stream.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			stream.in?0
		fi
	od;
stop_process:
}
