
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example120563132/agent/consul/server.go
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
	chan child_setupSerf1 = [0] of {int};
	Chandef s_eventChWAN;
	Chandef shutdownCh;
	Chandef s_reconcileCh;
	bool state = false;
	Chandef s_eventChLAN;
	Chandef s_leaveCh;
	Chandef s_reassertLeaderCh;
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
	run sync_monitor(shutdownCh);
	
	if
	:: 2048 > 0 -> 
		s_eventChLAN.size = 2048;
		run AsyncChan(s_eventChLAN)
	:: else -> 
		run sync_monitor(s_eventChLAN)
	fi;
	
	if
	:: 2048 > 0 -> 
		s_eventChWAN.size = 2048;
		run AsyncChan(s_eventChWAN)
	:: else -> 
		run sync_monitor(s_eventChWAN)
	fi;
	run sync_monitor(s_leaveCh);
	
	if
	:: 256 > 0 -> 
		s_reconcileCh.size = 256;
		run AsyncChan(s_reconcileCh)
	:: else -> 
		run sync_monitor(s_reconcileCh)
	fi;
	run sync_monitor(s_reassertLeaderCh);
	
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
		chan child_setupSerf0 = [0] of {int};
		run setupSerf(s_eventChWAN,child_setupSerf0);
		child_setupSerf0?0;
		
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
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run setupSerf(s_eventChLAN,child_setupSerf1);
	child_setupSerf1?0;
	
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
		fi;
		run go_HandleSerfEvents(s_eventChWAN)
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
	run Anonymous2(shutdownCh);
	goto stop_process
stop_process:}

proctype setupSerf(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		Wgdef nt_wg;
		run wgMonitor(nt_wg);
		
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
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype go_HandleSerfEvents(Chandef eventCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: eventCh.async_rcv?0 -> 
			break
		:: eventCh.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
}
proctype Anonymous2(Chandef shutdownCh) {
	bool closed; 
	int i;
	bool state;
stop_process:
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

