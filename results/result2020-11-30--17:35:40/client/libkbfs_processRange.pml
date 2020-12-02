#define processRange_rmdses  3

// /tmp/clone-example545132187/go/kbfs/libkbfs/md_ops.go
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
	Chandef irmdChan;
	bool state = false;
	int numWorkers = -2;
	Chandef rmdsChan;
	int rmdses = processRange_rmdses;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: rmdses > 0 -> 
		rmdsChan.size = rmdses;
		run AsyncChan(rmdsChan)
	:: else -> 
		run sync_monitor(rmdsChan)
	fi;
	
	if
	:: rmdses > 0 -> 
		irmdChan.size = rmdses;
		run AsyncChan(irmdChan)
	:: else -> 
		run sync_monitor(irmdChan)
	fi;
	
	if
	:: 0 != -2 && numWorkers-1 != -3 -> 
				for(i : 0.. numWorkers-1) {
for10:
		}
	:: else -> 
		do
		:: true -> 
for10:
		:: true -> 
			break
		od
	fi;
for10_exit:		for(i : 0.. rmdses-1) {
for20:		
		if
		:: rmdsChan.async_send!0;
		:: rmdsChan.sync!0 -> 
			rmdsChan.sending?0
		fi
	};
	rmdsChan.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	irmdChan.closing!true;
	do
	:: irmdChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: irmdChan.async_rcv?0;
			:: irmdChan.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
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

