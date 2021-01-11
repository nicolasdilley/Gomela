
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example222538930/api/apiMessageHandler.go
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
	chan child_apiConnectToRunner0 = [0] of {int};
	Chandef c;
	bool state = false;
	int i;
	run sync_monitor(c);
	run apiConnectToRunner(c,child_apiConnectToRunner0);
	child_apiConnectToRunner0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype apiConnectToRunner(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_Start0 = [0] of {int};
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Start(killChannel,child_Start0);
	child_Start0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Start(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_runnerStartLegacyRunner0 = [0] of {int};
	

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
	run runnerStartLegacyRunner(killChannel,child_runnerStartLegacyRunner0);
	child_runnerStartLegacyRunner0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype runnerStartLegacyRunner(Chandef killChannel;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef errChannel;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run go_Anonymous3(killChannel);
	run sync_monitor(errChannel);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous3(Chandef killChannel) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: killChannel.async_rcv?0;
	:: killChannel.sync?0;
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

