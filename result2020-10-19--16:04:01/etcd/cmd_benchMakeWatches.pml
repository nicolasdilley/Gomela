#define benchMakeWatches_streams  5
#define benchMakeWatches_watchStreams  5
#define benchMakeWatches_watchWatchesPerStream  5

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example134145316/tools/benchmark/cmd/watch.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef keyc;
	int watchWatchesPerStream = benchMakeWatches_watchWatchesPerStream;
	int streams = benchMakeWatches_streams;
	bool state = false;
	Chandef wc;
	int watchStreams = benchMakeWatches_watchStreams;
	int i;
		for(i : 1.. streams) {
for10:
	};
	
	if
	:: watchStreams > 0 -> 
		keyc.size = watchStreams;
		run emptyChan(keyc)
	:: else -> 
		run sync_monitor(keyc)
	fi;
	
	if
	:: streams > 0 -> 
		wc.size = streams;
		run emptyChan(wc)
	:: else -> 
		run sync_monitor(wc)
	fi;
		for(i : 1.. streams) {
for20:		run Anonymous0(keyc,wc)
	};
	run Anonymous1(keyc,wc);
	
	if
	:: 0 != -1 && streams-1 != -1 -> 
				for(i : 0.. streams-1) {
for40:
		}
	:: else -> 
		do
		:: true -> 
for40:
		:: true -> 
			break
		od
	fi;
for40_exit:
stop_process:}

proctype Anonymous0(Chandef keyc;Chandef wc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && watchWatchesPerStream-1 != -1 -> 
				for(i : 0.. watchWatchesPerStream-1) {
for21:			
			if
			:: keyc.async_rcv?0;
			:: keyc.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for21:			
			if
			:: keyc.async_rcv?0;
			:: keyc.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for21_exit:	
	if
	:: wc.async_send!0;
	:: wc.sync!0 -> 
		wc.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef keyc;Chandef wc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && watchStreams * watchWatchesPerStream-1 != -1 -> 
				for(i : 0.. watchStreams * watchWatchesPerStream-1) {
for30:			
			if
			:: keyc.async_send!0;
			:: keyc.sync!0 -> 
				keyc.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: keyc.async_send!0;
			:: keyc.sync!0 -> 
				keyc.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	keyc.closing!true;
stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

