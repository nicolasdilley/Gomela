#define lb_for286_0  -1
#define ub_for286_1  -1
#define lb_for482_2  -1
#define ub_for482_3  -1

typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_craftTLSRotatePhased41 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
	
	if
	:: true -> 
		chan child_craftTLSRotateDirect30 = [0] of {int};
		run craftTLSRotateDirect3(_ch0,child_craftTLSRotateDirect30);
		child_craftTLSRotateDirect30?0;
		goto stop_process
	:: true;
	fi;
	run craftTLSRotatePhased4(_ch0,child_craftTLSRotatePhased41);
	child_craftTLSRotatePhased41?0;
	goto stop_process
stop_process:}

proctype craftTLSRotateDirect3(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	
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
	run Anonymous1(stopCh,stopCh);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous1(Chandef stopCh;Chandef stopCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		do
		:: true -> 
			break
		:: stopCh.in?0 -> 
			goto stop_process
		od
	od;
for10_exit:stop_process:
}
proctype craftTLSRotatePhased4(Chandef stopCh;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for20:
	od;
	
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
	run Anonymous3(stopCh,stopCh);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous3(Chandef stopCh;Chandef stopCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: true -> 
			break
		:: true -> 
			break
		:: stopCh.in?0 -> 
			goto stop_process
		od
	od;
for30_exit:stop_process:
}
