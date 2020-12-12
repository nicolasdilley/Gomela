
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example128213725/executor/executor.go
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
	int toStop = -2;
	bool state = false;
	int p_workers = -2;
	int p_requests = -2;
	int params_NumWorkers = -2;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. p_requests-1) {
for10:
		}
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			Chandef p_stopChan;
			run sync_monitor(p_stopChan);
			run go_truncateLoop(p_stopChan)
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. toStop-1) {
for30:
		}
	:: true -> 
		
		if
		:: true -> 
						for(i : p_workers.. params_NumWorkers-1) {
for40:
			};
for40_exit:
		:: true;
		fi
	fi;
	goto stop_process
stop_process:}

proctype go_truncateLoop(Chandef stopChan) {
	bool closed; 
	int i;
	bool state;
	Chandef nextCheckTimer;
	run sync_monitor(nextCheckTimer);
	do
	:: true -> 
for20:		do
		:: nextCheckTimer.async_rcv?0 -> 
			break
		:: nextCheckTimer.sync?0 -> 
			break
		:: stopChan.async_rcv?0 -> 
			goto stop_process
		:: stopChan.sync?0 -> 
			goto stop_process
		od
	od;
for20_exit:stop_process:
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

