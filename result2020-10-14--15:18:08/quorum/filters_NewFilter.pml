#define lb_for303_0  -1
#define ub_for303_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example991245137/eth/filters/api.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef logs;
	int i;
	chan child_api_eventsSubscribeLogs5 = [0] of {int};
	bool state = false;
	run sync_monitor(logs);
	run api_eventsSubscribeLogs(logs,child_api_eventsSubscribeLogs0);
	child_api_eventsSubscribeLogs5?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run Anonymous4(logs);
	goto stop_process
stop_process:}

proctype api_eventsSubscribeLogs(Chandef logs;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		chan child_essubscribePendingLogs0 = [0] of {int};
		run essubscribePendingLogs(logs,child_essubscribePendingLogs0);
		child_essubscribePendingLogs0?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_essubscribeLogs1 = [0] of {int};
		run essubscribeLogs(logs,child_essubscribeLogs1);
		child_essubscribeLogs1?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_essubscribeLogs2 = [0] of {int};
		run essubscribeLogs(logs,child_essubscribeLogs2);
		child_essubscribeLogs2?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_essubscribeMinedPendingLogs3 = [0] of {int};
		run essubscribeMinedPendingLogs(logs,child_essubscribeMinedPendingLogs3);
		child_essubscribeMinedPendingLogs3?0;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		chan child_essubscribeLogs4 = [0] of {int};
		run essubscribeLogs(logs,child_essubscribeLogs4);
		child_essubscribeLogs4?0;
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	child!0;
stop_process:
}
proctype essubscribePendingLogs(Chandef logs;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef sub_hashes;
	Chandef sub_installed;
	Chandef sub_headers;
	Chandef sub_err;
	run sync_monitor(sub_hashes);
	run sync_monitor(sub_headers);
	run sync_monitor(sub_installed);
	run sync_monitor(sub_err);
	goto stop_process;
	child!0;
stop_process:
}
proctype essubscribeLogs(Chandef logs;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef sub_hashes;
	Chandef sub_installed;
	Chandef sub_headers;
	Chandef sub_err;
	run sync_monitor(sub_hashes);
	run sync_monitor(sub_headers);
	run sync_monitor(sub_installed);
	run sync_monitor(sub_err);
	goto stop_process;
	child!0;
stop_process:
}
proctype essubscribeMinedPendingLogs(Chandef logs;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef sub_hashes;
	Chandef sub_installed;
	Chandef sub_headers;
	Chandef sub_err;
	run sync_monitor(sub_hashes);
	run sync_monitor(sub_headers);
	run sync_monitor(sub_installed);
	run sync_monitor(sub_err);
	goto stop_process;
	child!0;
stop_process:
}
proctype Anonymous4(Chandef logs) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: logs.async_rcv?0 -> 
			break
		:: logs.sync?0 -> 
			break
		od
	od;
for10_exit:stop_process:
}
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

