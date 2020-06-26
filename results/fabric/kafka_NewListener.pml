
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_l_eventListenerSupportaddListener20 = [0] of {int};
	chan _ch0_in = [listenerChanSize] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run l_eventListenerSupportaddListener2(_ch0,child_l_eventListenerSupportaddListener20);
	child_l_eventListenerSupportaddListener20?0;
	goto stop_process
stop_process:}

proctype l_eventListenerSupportaddListener2(Chandef listener;chan child) {
	bool closed; 
	int i;
	child!0;
stop_process:
}
