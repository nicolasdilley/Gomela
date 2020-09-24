
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example144493935/scheduler/work_manager.go
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
	int i;
	Chandef wm_kill;
	Chandef wm_publishchan;
	int wm_publishWkrSize = 5;
	Chandef wm_collectchan;
	Chandef wm_processchan;
	int wm_collectWkrSize = 5;
	int wm_processWkrSize = 5;
	bool state = false;
	run sync_monitor(wm_collectchan);
	run sync_monitor(wm_publishchan);
	run sync_monitor(wm_processchan);
	run sync_monitor(wm_kill);
	do
	:: true -> 
for10:
	:: true -> 
		break
	od;
		for(i : 0.. wm_collectWkrSize-1) {
for20:		chan child_schedulernewWorker0 = [0] of {int};
		run schedulernewWorker(wm_collectchan,child_schedulernewWorker0);
		child_schedulernewWorker0?0
	};
for20_exit:		for(i : 0.. wm_publishWkrSize-1) {
for30:		chan child_schedulernewWorker1 = [0] of {int};
		run schedulernewWorker(wm_publishchan,child_schedulernewWorker1);
		child_schedulernewWorker1?0
	};
for30_exit:		for(i : 0.. wm_processWkrSize-1) {
for40:		chan child_schedulernewWorker2 = [0] of {int};
		run schedulernewWorker(wm_processchan,child_schedulernewWorker2);
		child_schedulernewWorker2?0
	};
for40_exit:	goto stop_process
stop_process:}

proctype schedulernewWorker(Chandef rChan;chan child) {
	bool closed; 
	int i;
	goto stop_process;
	child!0;
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

