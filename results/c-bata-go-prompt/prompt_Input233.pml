
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example180281438/prompt.go
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
	Chandef bufCh;
	bool state = false;
	int i;
	

	if
	:: 128 > 0 -> 
		bufCh.size = 128;
		run AsyncChan(bufCh)
	:: else -> 
		run sync_monitor(bufCh)
	fi;
	run sync_monitor(stopReadBufCh);
	run go_readBuffer(bufCh,stopReadBufCh);
	do
	:: true -> 
		for20: skip;
		do
		:: bufCh.async_rcv?0 -> 
			

			if
			:: true -> 
				

				if
				:: stopReadBufCh.async_send!0;
				:: stopReadBufCh.sync!0 -> 
					stopReadBufCh.sending?0
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
					goto stop_process
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
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: stopReadBufCh.async_send!0;
					:: stopReadBufCh.sync!0 -> 
						stopReadBufCh.sending?0
					fi;
					goto stop_process
				fi
			fi;
			break
		:: true;
		od;
		for20_end: skip
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_readBuffer(Chandef bufCh;Chandef stopCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		do
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
			fi
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
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

