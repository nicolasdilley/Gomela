#define lb_for68_0  -1
#define ub_for68_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example775082382/cinterop/maximally_batched_work.go
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
	Chandef readChan;
	int i;
	Chandef writeChan;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		readChan.size = 2;
		run emptyChan(readChan)
	:: else -> 
		run sync_monitor(readChan)
	fi;
	
	if
	:: 2 > 0 -> 
		writeChan.size = 2;
		run emptyChan(writeChan)
	:: else -> 
		run sync_monitor(writeChan)
	fi;
	run go_cinteropreadBatch(readChan);
	run go_cinteropwriteBatch(writeChan);
	do
	:: readChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: readChan.async_rcv?0;
			:: readChan.sync?0;
			fi;
			
			if
			:: writeChan.async_send!0;
			:: writeChan.sync!0 -> 
				writeChan.sending?0
			fi
		fi
	od;
	writeChan.closing!true
stop_process:}

proctype go_cinteropreadBatch(Chandef copyTo) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: copyTo.async_send!0;
			:: copyTo.sync!0 -> 
				copyTo.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:	copyTo.closing!true
}
proctype go_cinteropwriteBatch(Chandef copyFrom) {
	bool closed; 
	int i;
	bool state;
	do
	:: copyFrom.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: copyFrom.async_rcv?0;
			:: copyFrom.sync?0;
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				fi
			:: true;
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

