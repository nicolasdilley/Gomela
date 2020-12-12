
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714872247/supervisor/supervisor.go
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
	Chandef s_watcherCancelC;
	Chandef changesC;
	bool state = false;
	Chandef s_watcherErrorC;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 2000 > 0 -> 
		changesC.size = 2000;
		run AsyncChan(changesC)
	:: else -> 
		run sync_monitor(changesC)
	fi;
	
	if
	:: 1 > 0 -> 
		s_watcherErrorC.size = 1;
		run AsyncChan(s_watcherErrorC)
	:: else -> 
		run sync_monitor(s_watcherErrorC)
	fi;
	run sync_monitor(s_watcherCancelC);
	run Anonymous0(changesC,s_watcherErrorC,s_watcherCancelC);
	
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
		fi;
		
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
		run Anonymous1(changesC,s_watcherErrorC,s_watcherCancelC)
	:: true;
	fi;
	run Anonymous2(changesC,s_watcherErrorC,s_watcherCancelC);
	goto stop_process;
	
	if
	:: true -> 
		s_watcherCancelC.closing!true
	:: true;
	fi
stop_process:}

proctype Anonymous0(Chandef changesC;Chandef s_watcherErrorC;Chandef s_watcherCancelC) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
stop_process:	changesC.closing!true
}
proctype Anonymous1(Chandef changesC;Chandef s_watcherErrorC;Chandef s_watcherCancelC) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous2(Chandef changesC;Chandef s_watcherErrorC;Chandef s_watcherCancelC) {
	bool closed; 
	int i;
	bool state;
	do
	:: changesC.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: changesC.async_rcv?0;
			:: changesC.sync?0;
			fi
		fi
	od;
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

