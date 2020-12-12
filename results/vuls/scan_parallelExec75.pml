#define parallelExec_servers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example789322024/scan/executil.go
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
	int servers = parallelExec_servers;
	Chandef resChan;
	int successes = -2;
	bool state = false;
	
	if
	:: servers > 0 -> 
		resChan.size = servers;
		run AsyncChan(resChan)
	:: else -> 
		run sync_monitor(resChan)
	fi;
	
	if
	:: 0 != -2 && servers-1 != -3 -> 
				for(i : 0.. servers-1) {
for20:			do
			:: resChan.async_rcv?0 -> 
				break
			:: resChan.sync?0 -> 
				break
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: resChan.async_rcv?0 -> 
				break
			:: resChan.sync?0 -> 
				break
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: true -> 
				for(i : 0.. servers-1) {
for30:						for(i : 0.. successes-1) {
for31:				
				if
				:: true -> 
					break
				:: true;
				fi
			}
		}
	:: true;
	fi;
	goto stop_process;
	resChan.closing!true
stop_process:}

proctype Anonymous0(Chandef resChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: resChan.async_send!0;
		:: resChan.sync!0 -> 
			resChan.sending?0
		fi
	:: true -> 
		
		if
		:: resChan.async_send!0;
		:: resChan.sync!0 -> 
			resChan.sending?0
		fi
	:: true -> 
		
		if
		:: resChan.async_send!0;
		:: resChan.sync!0 -> 
			resChan.sending?0
		fi
	fi;
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

