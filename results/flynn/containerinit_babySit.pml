#define lb_for525_0  -1
#define ub_for525_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [1] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run Anonymous0(_ch0,sigchan);
	_ch1.in = _ch1_in;
	run Anonymous1(_ch0,_ch1);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for20_exit:	do
	:: _ch0.in?0 -> 
		break
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef _ch0;Chandef sigchan) {
	bool closed; 
	int i;
stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: _ch1.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch1.in?0
		fi
	od;
stop_process:
}
