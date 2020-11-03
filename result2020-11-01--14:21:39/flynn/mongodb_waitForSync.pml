#define waitForSyncInner_status_Members 3
#define lb_for798_1  -1
#define ub_for798_2  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example125994093/appliance/mongodb/process.go
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
	Chandef stopCh;
	int i;
	Chandef doneCh;
	bool state = false;
	run sync_monitor(stopCh);
	run sync_monitor(doneCh);
	run go_pwaitForSyncInner(stopCh,doneCh)
stop_process:}

proctype go_pwaitForSyncInner(Chandef stopCh;Chandef doneCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: stopCh.async_rcv?0 -> 
			goto stop_process
		:: stopCh.sync?0 -> 
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			do
			:: stopCh.async_rcv?0 -> 
				goto stop_process
			:: stopCh.sync?0 -> 
				goto stop_process
			:: true;
			od
		:: true;
		fi;
				for(i : 0.. status_Members-1) {
for11:
		};
		
		if
		:: true -> 
			break
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: stopCh.async_rcv?0 -> 
			goto stop_process
		:: stopCh.sync?0 -> 
			goto stop_process
		:: true;
		od
	od;
for10_exit:stop_process:	doneCh.closing!true
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


