
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_kubernetesenvnewCacheController40 = [0] of {int};
	chan _ch0_in = [0] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run kubernetesenvnewCacheController4(_ch0,child_kubernetesenvnewCacheController40);
	child_kubernetesenvnewCacheController40?0;
	
	if
	:: true -> 
		_ch0.in!0;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype kubernetesenvnewCacheController4(Chandef stopChan;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
stop_process:
}
