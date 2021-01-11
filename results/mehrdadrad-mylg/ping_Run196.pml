
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example773212782/http/ping/ping.go
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
	Chandef sigCh;
	bool state = false;
	int i;
	int p_count = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		sigCh.size = 1;
		run AsyncChan(sigCh)
	:: else -> 
		run sync_monitor(sigCh)
	fi;
	do
	:: sigCh.async_send!0 -> 
		break
	:: sigCh.sync!0 -> 
		sigCh.sending?0;
		break
	:: true -> 
		break
	od;
	LOOP: skip;
		

	if
	:: 0 != -2 && p_count-1 != -3 -> 
				for(i : 0.. p_count-1) {
			for101384: skip;
			do
			:: sigCh.async_rcv?0 -> 
				goto LOOP1384;
				break
			:: sigCh.sync?0 -> 
				goto LOOP1384;
				break
			:: true;
			od;
			for10_end1384: skip
		};
		for10_exit1384: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: sigCh.async_rcv?0 -> 
				goto LOOP;
				break
			:: sigCh.sync?0 -> 
				goto LOOP;
				break
			:: true;
			od;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi
stop_process:skip
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

