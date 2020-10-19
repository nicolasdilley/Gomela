#define Watch_backendBuffer  5
#define lb_for64_1  -1
#define ub_for64_2  -1
#define lb_for68_3  -1
#define ub_for68_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example023267234/lib/fs/basicfs_watch.go
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
	Chandef backendChan;
	bool state = false;
	int backendBuffer = Watch_backendBuffer;
	Chandef outChan;
	Chandef errChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(outChan);
	
	if
	:: backendBuffer > 0 -> 
		backendChan.size = backendBuffer;
		run emptyChan(backendChan)
	:: else -> 
		run sync_monitor(backendChan)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errChan);
	run go_fwatchLoop(backendChan,outChan,errChan);
	goto stop_process
stop_process:}

proctype go_fwatchLoop(Chandef backendChan;Chandef outChan;Chandef errChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
outer:						do
			:: true -> 
for11:				do
				:: backendChan.async_rcv?0 -> 
					break
				:: backendChan.sync?0 -> 
					break
				:: true -> 
					goto outer;
					break
				od
			od;
for11_exit:;
			
			if
			:: outChan.async_send!0;
			:: outChan.sync!0 -> 
				outChan.sending?0
			fi
		:: true;
		fi;
		do
		:: backendChan.async_rcv?0 -> 
			
			if
			:: true -> 
				do
				:: errChan.async_send!0 -> 
					break
				:: errChan.sync!0 -> 
					errChan.sending?0;
					break
				od;
				goto stop_process
			:: true;
			fi;
			do
			:: outChan.async_send!0 -> 
				break
			:: outChan.sync!0 -> 
				outChan.sending?0;
				break
			od;
			break
		:: backendChan.sync?0 -> 
			
			if
			:: true -> 
				do
				:: errChan.async_send!0 -> 
					break
				:: errChan.sync!0 -> 
					errChan.sending?0;
					break
				od;
				goto stop_process
			:: true;
			fi;
			do
			:: outChan.async_send!0 -> 
				break
			:: outChan.sync!0 -> 
				outChan.sending?0;
				break
			od;
			break
		od
	od;
for10_exit:stop_process:
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

