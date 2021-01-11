
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example245190199/go/vt/vtadmin/grpcserver/server.go
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
	Chandef signals;
	Chandef shutdown;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 16 > 0 -> 
		shutdown.size = 16;
		run AsyncChan(shutdown)
	:: else -> 
		run sync_monitor(shutdown)
	fi;
	

	if
	:: 8 > 0 -> 
		signals.size = 8;
		run AsyncChan(signals)
	:: else -> 
		run sync_monitor(signals)
	fi;
	do
	:: signals.async_send!0 -> 
		break
	:: signals.sync!0 -> 
		signals.sending?0;
		break
	:: true -> 
		break
	od;
	run go_Anonymous0(shutdown,signals);
	run go_Anonymous1(shutdown,signals);
	run go_Anonymous2(shutdown,signals);
	run go_Anonymous3(shutdown,signals);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef shutdown;Chandef signals) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: signals.async_rcv?0;
	:: signals.sync?0;
	fi;
	

	if
	:: shutdown.async_send!0;
	:: shutdown.sync!0 -> 
		shutdown.sending?0
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef shutdown;Chandef signals) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: shutdown.async_send!0;
	:: shutdown.sync!0 -> 
		shutdown.sending?0
	fi;
	stop_process: skip
}
proctype go_Anonymous2(Chandef shutdown;Chandef signals) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: shutdown.async_send!0;
	:: shutdown.sync!0 -> 
		shutdown.sending?0
	fi;
	stop_process: skip
}
proctype go_Anonymous3(Chandef shutdown;Chandef signals) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: shutdown.async_send!0;
	:: shutdown.sync!0 -> 
		shutdown.sending?0
	fi;
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

