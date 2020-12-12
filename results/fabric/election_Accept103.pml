
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example424524390/gossip/election/adapter.go
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
	int i;
	Chandef msgCh;
	bool state = false;
	run sync_monitor(msgCh);
	run Anonymous0(adapterCh,msgCh,ai_doneCh);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef inCh;Chandef outCh;Chandef stopCh) {
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
		:: inCh.async_rcv?0 -> 
			
			if
			:: true -> 
				
				if
				:: outCh.async_send!0;
				:: outCh.sync!0 -> 
					outCh.sending?0
				fi
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi;
			break
		:: inCh.sync?0 -> 
			
			if
			:: true -> 
				
				if
				:: outCh.async_send!0;
				:: outCh.sync!0 -> 
					outCh.sending?0
				fi
			:: true -> 
				goto stop_process
			:: true -> 
				goto stop_process
			fi;
			break
		od
	od;
for10_exit:stop_process:
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

