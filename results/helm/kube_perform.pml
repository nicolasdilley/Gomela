
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [0] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	run go_kubebatchPerform3(_ch0);
	do
	:: true -> 
for20:		_ch0.in?0;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process
stop_process:}

proctype go_kubebatchPerform3(Chandef errs) {
	bool closed; 
	int i;
		for(i : 1.. infos) {
for10:		run Anonymous1(_ch0)
	};
stop_process:
}
proctype Anonymous1(Chandef _ch0) {
	bool closed; 
	int i;
	errs.in!0;
stop_process:
}
