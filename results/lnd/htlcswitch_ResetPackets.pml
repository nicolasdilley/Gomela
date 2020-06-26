#define lb_for214_0  -1
#define ub_for214_1  -1

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
	_ch0.in = _ch0_in;
	do
	:: m_pktReset.in!0 -> 
		chan child_msignalUntilReset20 = [0] of {int};
		run msignalUntilReset2(_ch0,child_msignalUntilReset20);
		child_msignalUntilReset20?0;
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype msignalUntilReset2(Chandef done;chan child) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		

		if
		:: true;
		:: true;
		fi;
		do
		:: true -> 
			break
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for10_exit:	child!0;
stop_process:
}
