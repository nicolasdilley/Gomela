
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example982303966/autopilot/agent.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef a_heuristicUpdates;
	Chandef a_stateUpdates;
	Wgdef a_wg;
	Chandef a_nodeUpdates;
	int i;
	Chandef a_quit;
	Chandef a_balanceUpdates;
	Chandef a_chanOpenFailures;
	Chandef a_pendingOpenUpdates;
	bool state = false;
	run wgMonitor(a_wg);
	run sync_monitor(a_quit);
	run sync_monitor(a_stateUpdates);
	
	if
	:: 1 > 0 -> 
		a_balanceUpdates.size = 1;
		run AsyncChan(a_balanceUpdates)
	:: else -> 
		run sync_monitor(a_balanceUpdates)
	fi;
	
	if
	:: 1 > 0 -> 
		a_nodeUpdates.size = 1;
		run AsyncChan(a_nodeUpdates)
	:: else -> 
		run sync_monitor(a_nodeUpdates)
	fi;
	
	if
	:: 1 > 0 -> 
		a_chanOpenFailures.size = 1;
		run AsyncChan(a_chanOpenFailures)
	:: else -> 
		run sync_monitor(a_chanOpenFailures)
	fi;
	
	if
	:: 1 > 0 -> 
		a_heuristicUpdates.size = 1;
		run AsyncChan(a_heuristicUpdates)
	:: else -> 
		run sync_monitor(a_heuristicUpdates)
	fi;
	
	if
	:: 1 > 0 -> 
		a_pendingOpenUpdates.size = 1;
		run AsyncChan(a_pendingOpenUpdates)
	:: else -> 
		run sync_monitor(a_pendingOpenUpdates)
	fi;
	goto stop_process
stop_process:}

proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

