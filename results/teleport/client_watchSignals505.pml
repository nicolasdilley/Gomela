
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example809394708/lib/client/session.go
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
	Chandef ctrlCSignal;
	Chandef exitSignals;
	Chandef ctrlZSignal;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		exitSignals.size = 1;
		run AsyncChan(exitSignals)
	:: else -> 
		run sync_monitor(exitSignals)
	fi;
	do
	:: exitSignals!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous0(exitSignals,ctrlCSignal,ctrlZSignal);
	
	if
	:: 1 > 0 -> 
		ctrlCSignal.size = 1;
		run AsyncChan(ctrlCSignal)
	:: else -> 
		run sync_monitor(ctrlCSignal)
	fi;
	do
	:: ctrlCSignal!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous1(exitSignals,ctrlCSignal,ctrlZSignal);
	
	if
	:: 1 > 0 -> 
		ctrlZSignal.size = 1;
		run AsyncChan(ctrlZSignal)
	:: else -> 
		run sync_monitor(ctrlZSignal)
	fi;
	do
	:: ctrlZSignal!0 -> 
		break
	:: true -> 
		break
	od;
	run Anonymous2(exitSignals,ctrlCSignal,ctrlZSignal)
stop_process:}

proctype Anonymous0(Chandef exitSignals;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: exitSignals.async_rcv?0;
	:: exitSignals.sync?0;
	fi;
stop_process:
}
proctype Anonymous1(Chandef exitSignals;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: ctrlCSignal.async_rcv?0;
		:: ctrlCSignal.sync?0;
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef exitSignals;Chandef ctrlCSignal;Chandef ctrlZSignal) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: ctrlZSignal.async_rcv?0;
		:: ctrlZSignal.sync?0;
		fi
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

