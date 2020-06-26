#define lb_for168_0  -1
#define ub_for168_1  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan _ch0_in = [0] of {int};
	chan _ch1_in = [0] of {int};
	int i;
	Chandef _ch1;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	_ch1.in = _ch1_in;
	run chanMonitor(_ch1);
	run Anonymous0(_ch0,_ch1);
	
	if
	:: true -> 
		chan child_scannernewParallelHasher71 = [0] of {int};
		run scannernewParallelHasher7(_ch1,_ch0,w.Hashers,child_scannernewParallelHasher71);
		child_scannernewParallelHasher71?0;
		goto stop_process
	:: true;
	fi;
	run Anonymous3(_ch0,_ch1);
	goto stop_process
stop_process:}

proctype wwalkAndHashFiles3(Chandef toHashChan;Chandef finishedChan;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_wwalkAndHashFiles30 = [0] of {int};
	run wwalkAndHashFiles3(_ch0,_ch1,child_wwalkAndHashFiles30);
	child_wwalkAndHashFiles30?0;
	
	if
	:: true -> 
		do
		:: true -> 
for10:
		od
	fi;
	_ch0.closing!true;
stop_process:
}
proctype scannernewParallelHasher7(Chandef outbox;Chandef inbox;int workers _1;chan child) {
	bool closed; 
	int i;
		for(i : 0.. workers _1-1) {
for20:
	};
for20_exit:	child!0;
stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	do
	:: true -> 
for40:		do
		:: _ch3.in?0 -> 
			goto stop_process
		:: true -> 
			break
		:: true -> 
			goto stop_process
		od
	od;
for40_exit:stop_process:
}
proctype Anonymous3(Chandef _ch0;Chandef _ch1) {
	bool closed; 
	int i;
	chan child_scannernewParallelHasher72 = [0] of {int};
	chan _ch2_in = [0] of {int};
	Chandef _ch2;
	Chandef _ch3;
	chan _ch2_in = [0] of {int};
	do
	:: _ch0.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			_ch0.in?0
		fi
	od;
	_ch2.in = _ch2_in;
	run chanMonitor(_ch2);
	_ch3.in = _ch3_in;
	chan child_scannernewParallelHasher72 = [0] of {int};
	run scannernewParallelHasher7(_ch1,_ch2,_ch3,child_scannernewParallelHasher72);
	child_scannernewParallelHasher72?0;
	run Anonymous3(_ch0,_ch1);
loop:		do
	:: true -> 
for50:		do
		:: _ch2.in!0 -> 
			_ch2.sending?state;
			break
		:: true -> 
			goto loop;
			break
		od
	od;
	_ch2.closing!true;
stop_process:
}
proctype chanMonitor(Chandef ch) {
	bool closed; 
	int i;
	state = false;
	do
	:: true -> 
		if
		:: state -> 
end:			if
			:: ch.sending!state -> 
				assert(false)
			:: ch.closing?true -> 
				assert(false)
			:: ch.in!0;
			:: ch.is_closed!state;
			fi
		:: else -> 
end1:			if
			:: ch.sending!state;
			:: ch.closing?true -> 
				state = true
			:: ch.is_closed!state;
			fi
		fi
	od;
stop_process:
}
