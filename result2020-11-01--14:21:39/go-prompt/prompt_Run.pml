#define lb_for271_0  -1
#define ub_for271_1  -1
#define lb_for24_2  -1
#define ub_for24_3  -1
#define lb_for68_4  -1
#define ub_for68_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example285870885/signal_posix.go
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
	Chandef stopReadBufCh;
	int i;
	Chandef winSizeCh;
	Chandef bufCh;
	Chandef exitCh;
	Chandef stopHandleSignalCh;
	bool state = false;
	
	if
	:: 128 > 0 -> 
		bufCh.size = 128;
		run emptyChan(bufCh)
	:: else -> 
		run sync_monitor(bufCh)
	fi;
	run sync_monitor(stopReadBufCh);
	run go_preadBuffer(bufCh,stopReadBufCh);
	run sync_monitor(exitCh);
	run sync_monitor(winSizeCh);
	run sync_monitor(stopHandleSignalCh);
	run go_phandleSignals(exitCh,winSizeCh,stopHandleSignalCh);
		for(i : lb_for68_4.. ub_for68_5) {
for30:		do
		:: bufCh.async_rcv?0 -> 
			
			if
			:: true -> 
				
				if
				:: stopReadBufCh.async_send!0;
				:: stopReadBufCh.sync!0 -> 
					stopReadBufCh.sending?0
				fi;
				
				if
				:: stopHandleSignalCh.async_send!0;
				:: stopHandleSignalCh.sync!0 -> 
					stopHandleSignalCh.sending?0
				fi;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: stopReadBufCh.async_send!0;
					:: stopReadBufCh.sync!0 -> 
						stopReadBufCh.sending?0
					fi;
					
					if
					:: stopHandleSignalCh.async_send!0;
					:: stopHandleSignalCh.sync!0 -> 
						stopHandleSignalCh.sending?0
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					run go_preadBuffer(bufCh,stopReadBufCh);
					run go_phandleSignals(exitCh,winSizeCh,stopHandleSignalCh)
				fi
			fi;
			break
		:: bufCh.sync?0 -> 
			
			if
			:: true -> 
				
				if
				:: stopReadBufCh.async_send!0;
				:: stopReadBufCh.sync!0 -> 
					stopReadBufCh.sending?0
				fi;
				
				if
				:: stopHandleSignalCh.async_send!0;
				:: stopHandleSignalCh.sync!0 -> 
					stopHandleSignalCh.sending?0
				fi;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: stopReadBufCh.async_send!0;
					:: stopReadBufCh.sync!0 -> 
						stopReadBufCh.sending?0
					fi;
					
					if
					:: stopHandleSignalCh.async_send!0;
					:: stopHandleSignalCh.sync!0 -> 
						stopHandleSignalCh.sending?0
					fi;
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi;
					run go_preadBuffer(bufCh,stopReadBufCh);
					run go_phandleSignals(exitCh,winSizeCh,stopHandleSignalCh)
				fi
			fi;
			break
		:: winSizeCh.async_rcv?0 -> 
			break
		:: winSizeCh.sync?0 -> 
			break
		:: exitCh.async_rcv?0 -> 
			break
		:: exitCh.sync?0 -> 
			break
		:: true -> 
			break
		od
	};
for30_exit:
stop_process:}

proctype go_preadBuffer(Chandef bufCh;Chandef stopCh) {
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
			
			if
			:: true -> 
				
				if
				:: bufCh.async_send!0;
				:: bufCh.sync!0 -> 
					bufCh.sending?0
				fi
			:: true;
			fi;
			break
		od
	od;
for10_exit:stop_process:
}
proctype go_phandleSignals(Chandef exitCh;Chandef winSizeCh;Chandef stop) {
	bool closed; 
	int i;
	bool state;
	Chandef sigCh;
	
	if
	:: 1 > 0 -> 
		sigCh.size = 1;
		run emptyChan(sigCh)
	:: else -> 
		run sync_monitor(sigCh)
	fi;
	do
	:: sigCh!0 -> 
		break
	:: true -> 
		break
	od;
	do
	:: true -> 
for20:		do
		:: stop.async_rcv?0 -> 
			goto stop_process
		:: stop.sync?0 -> 
			goto stop_process
		:: sigCh.async_rcv?0 -> 
			

			if
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: winSizeCh.async_send!0;
				:: winSizeCh.sync!0 -> 
					winSizeCh.sending?0
				fi
			fi;
			break
		:: sigCh.sync?0 -> 
			

			if
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: exitCh.async_send!0;
				:: exitCh.sync!0 -> 
					exitCh.sending?0
				fi
			:: true -> 
				
				if
				:: winSizeCh.async_send!0;
				:: winSizeCh.sync!0 -> 
					winSizeCh.sending?0
				fi
			fi;
			break
		od
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

