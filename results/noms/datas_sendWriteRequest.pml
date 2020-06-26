
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	bool state = false;
	chan child_datasbuildWriteValueRequest10 = [0] of {int};
	chan _ch0_in = [1024] of {int};
	int i;
	Chandef _ch0;
	_ch0.in = _ch0_in;
	run chanMonitor(_ch0);
	run Anonymous0(_ch0);
	run datasbuildWriteValueRequest1(_ch0,child_datasbuildWriteValueRequest10);
	child_datasbuildWriteValueRequest10?0
stop_process:}

proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	_ch0.closing!true;
stop_process:
}
proctype datasbuildWriteValueRequest1(Chandef chunkChan;chan child) {
	bool closed; 
	int i;
	run Anonymous2(chunkChan,chunkChan);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous2(Chandef chunkChan;Chandef chunkChan) {
	bool closed; 
	int i;
	do
	:: chunkChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			chunkChan.in?0
		fi
	od;
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
