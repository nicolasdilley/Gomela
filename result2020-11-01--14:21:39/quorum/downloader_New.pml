
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example127052982/eth/downloader/statesync.go
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
	Chandef dl_receiptCh;
	int i;
	Chandef dl_quitCh;
	Chandef dl_headerCh;
	Chandef dl_receiptWakeCh;
	Chandef dl_stateSyncStart;
	Wgdef dl_cancelWg;
	Chandef dl_bodyCh;
	Chandef dl_bodyWakeCh;
	Chandef dl_headerProcCh;
	Chandef dl_stateCh;
	Chandef dl_trackStateReq;
	bool state = false;
	run wgMonitor(dl_cancelWg);
	
	if
	:: 1 > 0 -> 
		dl_headerCh.size = 1;
		run emptyChan(dl_headerCh)
	:: else -> 
		run sync_monitor(dl_headerCh)
	fi;
	
	if
	:: 1 > 0 -> 
		dl_bodyCh.size = 1;
		run emptyChan(dl_bodyCh)
	:: else -> 
		run sync_monitor(dl_bodyCh)
	fi;
	
	if
	:: 1 > 0 -> 
		dl_receiptCh.size = 1;
		run emptyChan(dl_receiptCh)
	:: else -> 
		run sync_monitor(dl_receiptCh)
	fi;
	
	if
	:: 1 > 0 -> 
		dl_bodyWakeCh.size = 1;
		run emptyChan(dl_bodyWakeCh)
	:: else -> 
		run sync_monitor(dl_bodyWakeCh)
	fi;
	
	if
	:: 1 > 0 -> 
		dl_receiptWakeCh.size = 1;
		run emptyChan(dl_receiptWakeCh)
	:: else -> 
		run sync_monitor(dl_receiptWakeCh)
	fi;
	
	if
	:: 1 > 0 -> 
		dl_headerProcCh.size = 1;
		run emptyChan(dl_headerProcCh)
	:: else -> 
		run sync_monitor(dl_headerProcCh)
	fi;
	run sync_monitor(dl_quitCh);
	run sync_monitor(dl_stateCh);
	run sync_monitor(dl_stateSyncStart);
	run sync_monitor(dl_trackStateReq);
	goto stop_process
stop_process:}

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

