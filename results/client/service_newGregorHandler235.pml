
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example678508291/go/service/gregor.go
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
	Chandef gh_connectHappened;
	int i;
	Chandef gh_pushStateCh;
	Chandef gh_broadcastCh;
	Chandef gh_replayCh;
	Chandef gh_forcePingCh;
	bool state = false;
	
	if
	:: 10000 > 0 -> 
		gh_broadcastCh.size = 10000;
		run AsyncChan(gh_broadcastCh)
	:: else -> 
		run sync_monitor(gh_broadcastCh)
	fi;
	run sync_monitor(gh_connectHappened);
	
	if
	:: 10 > 0 -> 
		gh_replayCh.size = 10;
		run AsyncChan(gh_replayCh)
	:: else -> 
		run sync_monitor(gh_replayCh)
	fi;
	
	if
	:: 100 > 0 -> 
		gh_pushStateCh.size = 100;
		run AsyncChan(gh_pushStateCh)
	:: else -> 
		run sync_monitor(gh_pushStateCh)
	fi;
	
	if
	:: 5 > 0 -> 
		gh_forcePingCh.size = 5;
		run AsyncChan(gh_forcePingCh)
	:: else -> 
		run sync_monitor(gh_forcePingCh)
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

