
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example970701729/cmd/puma-dev/main_darwin.go
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
	Chandef shutdown;
	Chandef purge;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		purge.size = 1;
		run AsyncChan(purge)
	:: else -> 
		run sync_monitor(purge)
	fi;
	do
	:: purge.async_send!0 -> 
		break
	:: purge.sync!0 -> 
		purge.sending?0;
		break
	:: true -> 
		break
	od;
	

	if
	:: 1 > 0 -> 
		shutdown.size = 1;
		run AsyncChan(shutdown)
	:: else -> 
		run sync_monitor(shutdown)
	fi;
	do
	:: shutdown.async_send!0 -> 
		break
	:: shutdown.sync!0 -> 
		shutdown.sending?0;
		break
	:: true -> 
		break
	od;
	run go_Anonymous0(purge,shutdown);
	run go_Anonymous1(purge,shutdown);
	run go_Anonymous2(purge,shutdown)
stop_process:skip
}

proctype go_Anonymous0(Chandef purge;Chandef shutdown) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: shutdown.async_rcv?0;
	:: shutdown.sync?0;
	fi;
	stop_process: skip
}
proctype go_Anonymous1(Chandef purge;Chandef shutdown) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip
}
proctype go_Anonymous2(Chandef purge;Chandef shutdown) {
	bool closed; 
	int i;
	bool state;
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

