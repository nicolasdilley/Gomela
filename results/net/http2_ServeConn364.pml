
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example234383618/http2/server.go
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
	Chandef sc_readFrameCh;
	Chandef sc_bodyReadCh;
	Chandef sc_serveMsgCh;
	int i;
	Chandef sc_wantWriteFrameCh;
	Chandef sc_wroteFrameCh;
	Chandef sc_doneServing;
	bool state = false;
	run sync_monitor(sc_readFrameCh);
	
	if
	:: 8 > 0 -> 
		sc_wantWriteFrameCh.size = 8;
		run AsyncChan(sc_wantWriteFrameCh)
	:: else -> 
		run sync_monitor(sc_wantWriteFrameCh)
	fi;
	
	if
	:: 8 > 0 -> 
		sc_serveMsgCh.size = 8;
		run AsyncChan(sc_serveMsgCh)
	:: else -> 
		run sync_monitor(sc_serveMsgCh)
	fi;
	
	if
	:: 1 > 0 -> 
		sc_wroteFrameCh.size = 1;
		run AsyncChan(sc_wroteFrameCh)
	:: else -> 
		run sync_monitor(sc_wroteFrameCh)
	fi;
	run sync_monitor(sc_bodyReadCh);
	run sync_monitor(sc_doneServing);
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi
stop_process:}

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

