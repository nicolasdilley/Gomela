#define sentinels  ??

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1] of {int};
	chan _ch1_in = [sentinels] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(results);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	od;
	_ch1.in = _ch1_in;
	do
	:: true -> 
for20:		run Anonymous1(_ch1)
	od;
	do
	:: true -> 
for30:		do
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: _ch1.in?0 -> 
			break
		od
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef results) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
	goto stop_process;
	_ch0.in!0;
stop_process:
}
proctype Anonymous1(Chandef _ch1) {
	bool closed; 
	int i;
	_ch1.in!0;
stop_process:
}
