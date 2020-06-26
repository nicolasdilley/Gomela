
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [1] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	
	if
	:: true -> 
		chan child_hubRegisterListener10 = [0] of {int};
		run hubRegisterListener1(_ch0,child_hubRegisterListener10);
		child_hubRegisterListener10?0;
		chan child_hubUnregisterListener11 = [0] of {int};
		run hubUnregisterListener1(_ch0,child_hubUnregisterListener11);
		child_hubUnregisterListener11?0
	:: true;
	fi;
	do
	:: true -> 
for10:		chan child_hubRegisterBlobListener22 = [0] of {int};
		run hubRegisterBlobListener2(_ch0,child_hubRegisterBlobListener22);
		child_hubRegisterBlobListener22?0;
		chan child_hubUnregisterBlobListener23 = [0] of {int};
		run hubUnregisterBlobListener2(_ch0,child_hubUnregisterBlobListener23);
		child_hubUnregisterBlobListener23?0
	od;
	do
	:: _ch0.in?0 -> 
		break
	:: true -> 
		break
	:: true -> 
		break
	od
stop_process:}

proctype hubRegisterListener1(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype hubUnregisterListener1(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype hubRegisterBlobListener2(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
proctype hubUnregisterBlobListener2(Chandef ch;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
