#define IndexDiff_IndexOperationConcurrency  60
#define IndexDiff_index  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example734324076/provider/aws/index.go
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
	Chandef outch;
	int i;
	int IndexOperationConcurrency = IndexDiff_IndexOperationConcurrency;
	Chandef inch;
	Chandef errch;
	int index = IndexDiff_index;
	bool state = false;
	run sync_monitor(inch);
	run sync_monitor(outch);
	run sync_monitor(errch);
		for(i : 1.. IndexOperationConcurrency-1) {
for10:		run go_pmissingHashes(inch,outch,errch)
	};
for10_exit:	run Anonymous1(inch,outch,errch);
		for(i : 1.. index) {
for30:		do
		:: outch.async_rcv?0 -> 
			break
		:: outch.sync?0 -> 
			break
		:: errch.async_rcv?0 -> 
			goto stop_process
		:: errch.sync?0 -> 
			goto stop_process
		od
	};
	inch.closing!true;
	goto stop_process
stop_process:}

proctype go_pmissingHashes(Chandef inch;Chandef outch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
	do
	:: inch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: inch.async_rcv?0;
			:: inch.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: errch.async_send!0;
				:: errch.sync!0 -> 
					errch.sending?0
				fi
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: outch.async_send!0;
					:: outch.sync!0 -> 
						outch.sending?0
					fi
				:: true -> 
					
					if
					:: outch.async_send!0;
					:: outch.sync!0 -> 
						outch.sending?0
					fi
				:: true -> 
					
					if
					:: outch.async_send!0;
					:: outch.sync!0 -> 
						outch.sending?0
					fi
				fi
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef inch;Chandef outch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
		for(i : 1.. index) {
for20:		
		if
		:: inch.async_send!0;
		:: inch.sync!0 -> 
			inch.sending?0
		fi
	};
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

