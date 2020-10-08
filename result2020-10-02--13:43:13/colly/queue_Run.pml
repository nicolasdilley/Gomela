#define lb_for154_0  -1
#define ub_for154_1  -1
#define lb_for180_2  -1
#define ub_for180_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example028661211/queue/queue.go
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
	Chandef requestc;
	int i;
	Chandef complete;
	Chandef q_wake;
	Chandef errc;
	int q_Threads = 5;
	bool state = false;
	run sync_monitor(q_wake);
	run sync_monitor(requestc);
	
	if
	:: 1 > 0 -> 
		errc.size = 1;
		run emptyChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	run sync_monitor(complete);
		for(i : 0.. q_Threads-1) {
for10:		run go_queueindependentRunner(requestc,complete)
	};
for10_exit:	run go_qloop(requestc,complete,errc);
	
	if
	:: errc.async_rcv?0;
	:: errc.sync?0;
	fi;
	goto stop_process;
	requestc.closing!true
stop_process:}

proctype go_queueindependentRunner(Chandef requestc;Chandef complete) {
	bool closed; 
	int i;
	do
	:: requestc.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: requestc.async_rcv?0;
			:: requestc.sync?0;
			fi;
			
			if
			:: complete.async_send!0;
			:: complete.sync!0 -> 
				complete.sending?0
			fi
		fi
	od;
stop_process:
}
proctype go_qloop(Chandef requestc;Chandef complete;Chandef errc) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi;
			break
		:: true;
		fi;
Sent:				do
		:: true -> 
for21:			do
			:: true -> 
				goto Sent
			:: true -> 
				
				if
				:: true -> 
					goto Sent
				:: true;
				fi
			:: complete.async_rcv?0 -> 
				
				if
				:: true -> 
					goto Sent
				:: true;
				fi;
				break
			:: complete.sync?0 -> 
				
				if
				:: true -> 
					goto Sent
				:: true;
				fi;
				break
			od
		od;
for21_exit:
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

