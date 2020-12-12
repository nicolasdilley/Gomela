
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example132403188/resolvers/resolver_state.go
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
	Chandef stateChs_AllStats;
	Chandef stateChs_UpdateRTT;
	Chandef stateChs_Done;
	Chandef stateChs_GetStat;
	int i;
	Chandef stateChs_StopResolver;
	Chandef stateChs_AddToStat;
	Chandef stateChs_SetStat;
	Chandef stateChs_ClearStats;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		stateChs_Done.size = 2;
		run AsyncChan(stateChs_Done)
	:: else -> 
		run sync_monitor(stateChs_Done)
	fi;
	
	if
	:: 2 > 0 -> 
		stateChs_StopResolver.size = 2;
		run AsyncChan(stateChs_StopResolver)
	:: else -> 
		run sync_monitor(stateChs_StopResolver)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_UpdateRTT.size = 10;
		run AsyncChan(stateChs_UpdateRTT)
	:: else -> 
		run sync_monitor(stateChs_UpdateRTT)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_AddToStat.size = 10;
		run AsyncChan(stateChs_AddToStat)
	:: else -> 
		run sync_monitor(stateChs_AddToStat)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_GetStat.size = 10;
		run AsyncChan(stateChs_GetStat)
	:: else -> 
		run sync_monitor(stateChs_GetStat)
	fi;
	run sync_monitor(stateChs_SetStat);
	
	if
	:: 10 > 0 -> 
		stateChs_AllStats.size = 10;
		run AsyncChan(stateChs_AllStats)
	:: else -> 
		run sync_monitor(stateChs_AllStats)
	fi;
	
	if
	:: 10 > 0 -> 
		stateChs_ClearStats.size = 10;
		run AsyncChan(stateChs_ClearStats)
	:: else -> 
		run sync_monitor(stateChs_ClearStats)
	fi;
	goto stop_process
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

