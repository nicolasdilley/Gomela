#define GetCleanEncodedBlocksSizeSum_ptrs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example678508291/go/kbfs/libkbfs/folder_block_ops.go
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
	Chandef sumCh;
	Chandef ptrCh;
	int ptrs = GetCleanEncodedBlocksSizeSum_ptrs;
	bool state = false;
	
	if
	:: ptrs > 0 -> 
		ptrCh.size = ptrs;
		run AsyncChan(ptrCh)
	:: else -> 
		run sync_monitor(ptrCh)
	fi;
	
	if
	:: ptrs > 0 -> 
		sumCh.size = ptrs;
		run AsyncChan(sumCh)
	:: else -> 
		run sync_monitor(sumCh)
	fi;
		for(i : 0.. ptrs-1) {
for10:		
		if
		:: true -> 
			
			if
			:: ptrCh.async_send!0;
			:: ptrCh.sync!0 -> 
				ptrCh.sending?0
			fi
		:: true;
		fi
	};
	
	if
	:: true -> 
		
		if
		:: ptrCh.async_send!0;
		:: ptrCh.sync!0 -> 
			ptrCh.sending?0
		fi
	:: true;
	fi;
for20_exit:	ptrCh.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	sumCh.closing!true;
	do
	:: sumCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: sumCh.async_rcv?0;
			:: sumCh.sync?0;
			fi
		fi
	od;
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

