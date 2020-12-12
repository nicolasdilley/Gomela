#define minimize_nTasks  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example306907566/optimize/minimize.go
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
	Chandef operations;
	Chandef done;
	Chandef workerChan;
	int i;
	Chandef results;
	Chandef statsChan;
	int nTasks = minimize_nTasks;
	bool state = false;
	
	if
	:: nTasks > 0 -> 
		operations.size = nTasks;
		run AsyncChan(operations)
	:: else -> 
		run sync_monitor(operations)
	fi;
	
	if
	:: nTasks > 0 -> 
		results.size = nTasks;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run Anonymous0(operations,results,workerChan,statsChan,done);
	run sync_monitor(workerChan);
	run sync_monitor(statsChan);
	run sync_monitor(done);
for20_exit:	do
	:: statsChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: statsChan.async_rcv?0;
			:: statsChan.sync?0;
			fi;
			
			if
			:: true -> 
				do
				:: done.async_rcv?0 -> 
					break
				:: done.sync?0 -> 
					break
				:: true -> 
					
					if
					:: results.async_send!0;
					:: results.sync!0 -> 
						results.sending?0
					fi;
					done.closing!true;
					break
				od
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef operations;Chandef results;Chandef workerChan;Chandef statsChan;Chandef done) {
	bool closed; 
	int i;
	bool state;
	chan child_Run0 = [0] of {int};
for10_exit:	run Run(operations,results,child_Run0);
	child_Run0?0;
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

