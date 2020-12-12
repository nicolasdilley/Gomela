#define lb_for68_0  -1
#define ub_for68_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example644527848/prompt.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
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
		run AsyncChan(bufCh)
	:: else -> 
		run sync_monitor(bufCh)
	fi;
	run sync_monitor(stopReadBufCh);
	run go_readBuffer(bufCh,stopReadBufCh);
	run sync_monitor(exitCh);
	run sync_monitor(winSizeCh);
	run sync_monitor(stopHandleSignalCh);
	run go_handleSignals(exitCh,winSizeCh,stopHandleSignalCh);
		for(i : lb_for68_0.. ub_for68_1) {
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
					run go_readBuffer(bufCh,stopReadBufCh);
					run go_handleSignals(exitCh,winSizeCh,stopHandleSignalCh)
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
					run go_readBuffer(bufCh,stopReadBufCh);
					run go_handleSignals(exitCh,winSizeCh,stopHandleSignalCh)
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

proctype go_readBuffer(Chandef bufCh;Chandef stopCh) {
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
proctype go_handleSignals(Chandef exitCh;Chandef winSizeCh;Chandef stop) {
	bool closed; 
	int i;
	bool state;
	Chandef sigCh;
	
	if
	:: 1 > 0 -> 
		sigCh.size = 1;
		run AsyncChan(sigCh)
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
			break
		:: sigCh.sync?0 -> 
			break
		od
	od;
for20_exit:stop_process:
}
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

