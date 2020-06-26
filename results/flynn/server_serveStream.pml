
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_h_StoreSubscribe40 = [0] of {int};
	chan _ch0_in = [StreamBufferSize] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run h_StoreSubscribe4(_ch0,child_h_StoreSubscribe40);
	child_h_StoreSubscribe40?0
stop_process:}

proctype h_StoreSubscribe4(Chandef ch;chan child) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		do
		:: true -> 
for10:			ch.in!0
		od
	:: true;
	fi;
	
	if
	:: true -> 
		ch.in!0
	:: true;
	fi;
	
	if
	:: true -> 
		ch.in!0
	:: true;
	fi;
	
	if
	:: true -> 
		ch.in!0
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
