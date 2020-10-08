#define lb_for218_0  -1
#define ub_for218_1  -1
#define lb_for244_2  -1
#define ub_for244_3  -1
#define lb_for257_4  -1
#define ub_for257_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example162824890/src/cmd/linuxkit/scaleway.go
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
	Chandef promise;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(promise);
	run Anonymous0(promise);
	do
	:: true -> 
for30:		do
		:: true;
		od
	od;
for30_exit:
stop_process:}

proctype Anonymous0(Chandef promise) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: promise.async_send!0;
			:: promise.sync!0 -> 
				promise.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: promise.async_send!0;
			:: promise.sync!0 -> 
				promise.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:	do
	:: true -> 
for20:		
		if
		:: true -> 
			break
		fi
	od;
for20_exit:	
	if
	:: promise.async_send!0;
	:: promise.sync!0 -> 
		promise.sending?0
	fi;
	promise.closing!true;
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

