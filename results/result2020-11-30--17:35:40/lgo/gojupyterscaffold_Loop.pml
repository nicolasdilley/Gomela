
// /tmp/clone-example629415940/jupyter/gojupyterscaffold/gojupyterscaffold.go
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
	bool state = false;
	Chandef sockDone;
	Chandef execDone;
	int i;
	run Anonymous0(execDone,sockDone);
	run sync_monitor(execDone);
	run sync_monitor(sockDone);
	run Anonymous1(execDone,sockDone);
	run Anonymous2(execDone,sockDone);
	run Anonymous3(execDone,sockDone);
	
	if
	:: execDone.async_rcv?0;
	:: execDone.sync?0;
	fi;
	
	if
	:: sockDone.async_rcv?0;
	:: sockDone.sync?0;
	fi;
	
	if
	:: sockDone.async_rcv?0;
	:: sockDone.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef execDone;Chandef sockDone) {
	bool closed; 
	int i;
	bool state;
stop_process:
}
proctype Anonymous1(Chandef execDone;Chandef sockDone) {
	bool closed; 
	int i;
	bool state;
	execDone.closing!true;
stop_process:
}
proctype Anonymous2(Chandef execDone;Chandef sockDone) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: sockDone.async_send!0;
	:: sockDone.sync!0 -> 
		sockDone.sending?0
	fi;
stop_process:
}
proctype Anonymous3(Chandef execDone;Chandef sockDone) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: sockDone.async_send!0;
	:: sockDone.sync!0 -> 
		sockDone.sending?0
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

