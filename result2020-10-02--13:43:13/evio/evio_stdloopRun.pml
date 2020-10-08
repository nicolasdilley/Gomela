#define lb_for245_0  -1
#define ub_for245_1  -1
#define lb_for256_2  -1
#define ub_for256_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example131532880/evio_std.go
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
	Chandef tick;
	int i;
	Chandef tock;
	bool state = false;
	run sync_monitor(tick);
	run sync_monitor(tock);
	
	if
	:: true -> 
		run Anonymous1(tick,tock)
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: tick.async_rcv?0 -> 
			

			if
			:: true;
			fi;
			
			if
			:: tock.async_send!0;
			:: tock.sync!0 -> 
				tock.sending?0
			fi;
			break
		:: tick.sync?0 -> 
			

			if
			:: true;
			fi;
			
			if
			:: tock.async_send!0;
			:: tock.sync!0 -> 
				tock.sending?0
			fi;
			break
		od;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for30_exit:	
	if
	:: true -> 
		tock.closing!true;
		run Anonymous0(tick,tock)
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef tick;Chandef tock) {
	bool closed; 
	int i;
	do
	:: tick.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: tick.async_rcv?0;
			:: tick.sync?0;
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef tick;Chandef tock) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: tick.async_send!0;
		:: tick.sync!0 -> 
			tick.sending?0
		fi;
		
		if
		:: tock.async_rcv?0;
		:: tock.sync?0;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for20_exit:stop_process:
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

