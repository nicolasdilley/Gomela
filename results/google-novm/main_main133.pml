#define main_vcpus  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example724683020/src/novmm/main.go
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
	Chandef vcpu_err;
	Chandef signals;
	bool state = false;
	int i;
	int vcpus = main_vcpus;
	

	if
	:: 1 > 0 -> 
		signals.size = 1;
		run AsyncChan(signals)
	:: else -> 
		run sync_monitor(signals)
	fi;
	do
	:: signals.async_send!0 -> 
		break
	:: signals.sync!0 -> 
		signals.sending?0;
		break
	:: true -> 
		break
	od;
	run sync_monitor(vcpu_err);
		for(i : 0.. vcpus-1) {
		for20: skip;
		run go_Anonymous0(signals,vcpu_err);
		for20_end: skip
	};
	for20_exit: skip;
	do
	:: true -> 
		for30: skip;
		do
		:: vcpu_err.async_rcv?0 -> 
			break
		:: vcpu_err.sync?0 -> 
			break
		:: signals.async_rcv?0 -> 
			break
		:: signals.sync?0 -> 
			break
		od;
		for30_end: skip
	od;
	for30_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef signals;Chandef vcpu_err) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: vcpu_err.async_send!0;
	:: vcpu_err.sync!0 -> 
		vcpu_err.sending?0
	fi;
	stop_process: skip
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

