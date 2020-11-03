#define scan_numSlices 3
#define scan_numChunks 0
#define scan_slices 1
#define scan_chunks 1
#define scan_allMatches 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example195715375/src/matcher.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	int slices = scan_slices;
	Chandef countChan;
	bool state = false;
	int numSlices = scan_numSlices;
	int allMatches = scan_allMatches;
	Chandef resultChan;
	Wgdef waitGroup;
	int numChunks = scan_numChunks;
	int chunks = scan_chunks;
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
	
	if
	:: numSlices > 0 -> 
		resultChan.size = numSlices;
		run emptyChan(resultChan)
	:: else -> 
		run sync_monitor(resultChan)
	fi;
	
	if
	:: numChunks > 0 -> 
		countChan.size = numChunks;
		run emptyChan(countChan)
	:: else -> 
		run sync_monitor(countChan)
	fi;
	run wgMonitor(waitGroup);
		for(i : 0.. slices-1) {
for10:		waitGroup.Add!1;
		run Anonymous0(resultChan,countChan)
	};
	do
	:: countChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: countChan.async_rcv?0;
			:: countChan.sync?0;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
		for(i : 0.. slices-1) {
for30:		
		if
		:: resultChan.async_rcv?0;
		:: resultChan.sync?0;
		fi
	};
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resultChan;Chandef countChan) {
	bool closed; 
	int i;
	bool state;
		for(i : 0.. chunks-1) {
for11:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: countChan.async_send!0;
		:: countChan.sync!0 -> 
			countChan.sending?0
		fi
	};
		for(i : 0.. allMatches-1) {
for12:
	};
	
	if
	:: resultChan.async_send!0;
	:: resultChan.sync!0 -> 
		resultChan.sending?0
	fi;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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


