
// https://github.com/c-bata/go-prompt/blob/8e6eb48b4aa09bfc6701ad171e6c855d873724a3/prompt.go#L233
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef stopReadBufCh;
	Chandef bufCh;
	int num_msgs = 0;
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
		:: bufCh.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				

				if
				:: stopReadBufCh.async_send!0;
				:: stopReadBufCh.sync!false,0 -> 
					stopReadBufCh.sending?state
				fi;
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: stopReadBufCh.async_send!0;
					:: stopReadBufCh.sync!false,0 -> 
						stopReadBufCh.sending?state
					fi;
					goto stop_process
				fi
			fi;
			break
		:: bufCh.sync?state,num_msgs -> 
			

			if
			:: true -> 
				

				if
				:: stopReadBufCh.async_send!0;
				:: stopReadBufCh.sync!false,0 -> 
					stopReadBufCh.sending?state
				fi;
				goto stop_process
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: stopReadBufCh.async_send!0;
					:: stopReadBufCh.sync!false,0 -> 
						stopReadBufCh.sending?state
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
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: stopCh.async_rcv?state,num_msgs -> 
			goto stop_process
		:: stopCh.sync?state,num_msgs -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: bufCh.async_send!0;
				:: bufCh.sync!false,0 -> 
					bufCh.sending?state
				fi
			:: true;
			fi
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

