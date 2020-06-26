#define lb_for57_0  -1
#define ub_for57_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [1024] of {int};
	chan _ch1_in = [1024] of {int};
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
	run go_udpForwardUserConn3(_ch1,_ch0);
	goto stop_process
stop_process:}

proctype go_udpForwardUserConn3(Chandef readCh;Chandef sendCh) {
	bool closed; 
	int i;
	run Anonymous1(_ch0,_ch1);
	do
	:: true -> 
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: sendCh.in!0 -> 
			break
		:: true -> 
			break
		od
	od;
for20_exit:stop_process:
}
proctype Anonymous1(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: readCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			readCh.in?0
		fi
	od;
stop_process:
}
