#define runAnalyzers_all  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example150611024/lintcmd/runner/runner.go
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
	Chandef queue;
	int i;
	int all = runAnalyzers_all;
	bool state = false;
	
	if
	:: all > 0 -> 
		queue.size = all;
		run AsyncChan(queue)
	:: else -> 
		run sync_monitor(queue)
	fi;
		for(i : 0.. all-1) {
for30:		
		if
		:: true -> 
			
			if
			:: queue.async_send!0;
			:: queue.sync!0 -> 
				queue.sending?0
			fi
		:: true;
		fi
	};
	
	if
	:: true -> 
		queue.closing!true
	:: true;
	fi;
	do
	:: queue.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: queue.async_rcv?0;
			:: queue.sync?0;
			fi;
			
			if
			:: true -> 
				run go_runnergenericHandle(queue)
			:: true -> 
				chan child_runnergenericHandle0 = [0] of {int};
				run runnergenericHandle(queue,child_runnergenericHandle0);
				child_runnergenericHandle0?0
			:: true -> 
				chan child_runnergenericHandle0 = [0] of {int};
				run runnergenericHandle(queue,child_runnergenericHandle0);
				child_runnergenericHandle0?0
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype go_runnergenericHandle(Chandef queue) {
	bool closed; 
	int i;
	bool state;
	int a_Triggers76620 = -2;
	int a_Deps74423 = -2;
	
	if
	:: true -> 
		queue.closing!true;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. a_Deps74423-1) {
for41:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: true;
	fi;
		for(i : 0.. a_Triggers76620-1) {
for42:		
		if
		:: true -> 
			
			if
			:: queue.async_send!0;
			:: queue.sync!0 -> 
				queue.sending?0
			fi
		:: true;
		fi
	};
stop_process:
}
proctype runnergenericHandle(Chandef queue;chan child) {
	bool closed; 
	int i;
	bool state;
	int a_Deps74423 = -2;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. a_Deps74423-1) {
for43:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: true;
	fi;
stop_process:	child!0
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

