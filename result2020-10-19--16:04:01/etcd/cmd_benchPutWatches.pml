#define benchPutWatches_watchPutTotal  5
#define benchPutWatches_wk_watches  5
#define benchPutWatches_wc  5
#define benchPutWatches_clients  5

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
	Chandef putreqc;
	int clients = benchPutWatches_clients;
	int wk_watches = benchPutWatches_wk_watches;
	bool state = false;
	int watchPutTotal = benchPutWatches_watchPutTotal;
	int wc = benchPutWatches_wc;
	int i;
	
	if
	:: 0 != -1 && watchPutTotal-1 != -1 -> 
				for(i : 0.. watchPutTotal-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 1.. wk_watches) {
for20:		run Anonymous0(putreqc)
	};
	
	if
	:: clients > 0 -> 
		putreqc.size = clients;
		run emptyChan(putreqc)
	:: else -> 
		run sync_monitor(putreqc)
	fi;
	run Anonymous1(putreqc);
		for(i : 1.. clients) {
for40:		run Anonymous2(putreqc)
	}
stop_process:}

proctype Anonymous0(Chandef putreqc) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Chandef putreqc) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: 0 != -1 && watchPutTotal-1 != -1 -> 
				for(i : 0.. watchPutTotal-1) {
for30:			
			if
			:: putreqc.async_send!0;
			:: putreqc.sync!0 -> 
				putreqc.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: putreqc.async_send!0;
			:: putreqc.sync!0 -> 
				putreqc.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	putreqc.closing!true;
stop_process:
}
proctype Anonymous2(Chandef putreqc) {
	bool closed; 
	int i;
	bool state;
	do
	:: putreqc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: putreqc.async_rcv?0;
			:: putreqc.sync?0;
			fi
		fi
	od;
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

