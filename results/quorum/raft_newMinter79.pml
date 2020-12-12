#define newMinter_core_GetChainHeadChannleSize9159  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example440247525/raft/minter.go
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
	Chandef minter_txPreChan;
	Chandef minter_invalidRaftOrderingChan;
	int i;
	Chandef minter_chainHeadChan;
	int core_GetChainHeadChannleSize9159 = newMinter_core_GetChainHeadChannleSize9159;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		minter_invalidRaftOrderingChan.size = 1;
		run AsyncChan(minter_invalidRaftOrderingChan)
	:: else -> 
		run sync_monitor(minter_invalidRaftOrderingChan)
	fi;
	
	if
	:: core_GetChainHeadChannleSize9159 > 0 -> 
		minter_chainHeadChan.size = core_GetChainHeadChannleSize9159;
		run AsyncChan(minter_chainHeadChan)
	:: else -> 
		run sync_monitor(minter_chainHeadChan)
	fi;
	
	if
	:: 4096 > 0 -> 
		minter_txPreChan.size = 4096;
		run AsyncChan(minter_txPreChan)
	:: else -> 
		run sync_monitor(minter_txPreChan)
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

