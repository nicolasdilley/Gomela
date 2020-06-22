
typedef Chandef {
	chan in = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
}



init { 
	chan _ch0_in = [concurrency] of {int};
	bool state = false;
	int i;
	Chandef _ch0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	_ch0.in = _ch0_in;
		for(i : 0.. concurrency-1) {
for10:		run Anonymous0(_ch0)
	};
for10_exit:	
	if
	:: 0 != -1 && concurrency-1 != -1 -> 
				for(i : 0.. concurrency-1) {
for20:			_ch0.in?0
		}
	:: else -> 
		do
		:: true -> 
for20:			_ch0.in?0
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype tsm1NewCacheKeyIterator3(chan child) {
	bool closed; 
	int i;
	
	if
	:: 0 != -1 && keys-1 != -1 -> 
				for(i : 0.. keys-1) {
for11:
		}
	:: else -> 
		do
		:: true -> 
for11:
		:: true -> 
			break
		od
	fi;
for11_exit:	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous0(Chandef _ch0) {
	bool closed; 
	int i;
	chan child_tsm1NewCacheKeyIterator30 = [0] of {int};
	run tsm1NewCacheKeyIterator3(child_tsm1NewCacheKeyIterator30);
	child_tsm1NewCacheKeyIterator30?0;
	_ch0.in!0;
stop_process:
}
