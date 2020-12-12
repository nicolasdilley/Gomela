
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example137240377/cmd/serf/command/agent/command.go
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
	bool state = false;
	chan child_handleSignals0 = [0] of {int};
	Chandef retryJoinCh;
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
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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
	run sync_monitor(retryJoinCh);
	run go_retryJoin(retryJoinCh);
	run handleSignals(retryJoinCh,child_handleSignals0);
	child_handleSignals0?0;
	goto stop_process
stop_process:}

proctype go_retryJoin(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			errCh.closing!true;
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:
}
proctype handleSignals(Chandef retryJoin;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef signalCh;
	Chandef gracefulCh;
	
	if
	:: 4 > 0 -> 
		signalCh.size = 4;
		run AsyncChan(signalCh)
	:: else -> 
		run sync_monitor(signalCh)
	fi;
	do
	:: signalCh!0 -> 
		break
	:: true -> 
		break
	od;
WAIT:	;
	do
	:: signalCh.async_rcv?0 -> 
		break
	:: signalCh.sync?0 -> 
		break
	od;
	
	if
	:: true -> 
		goto WAIT
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(gracefulCh);
	run Anonymous1(signalCh,gracefulCh,retryJoin);
	do
	:: signalCh.async_rcv?0 -> 
		goto stop_process
	:: signalCh.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: gracefulCh.async_rcv?0 -> 
		goto stop_process
	:: gracefulCh.sync?0 -> 
		goto stop_process
	od;
stop_process:	child!0
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

