#define readSpread_peers_Replication  3
#define not_found_peers_Peers12120  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example727353936/distributor/storage.go
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
	Chandef errch;
	Chandef resch;
	bool state = false;
	int i;
	int peers_Replication = readSpread_peers_Replication;
	run sync_monitor(resch);
	

	if
	:: peers_Replication > 0 -> 
		errch.size = peers_Replication;
		run AsyncChan(errch)
	:: else -> 
		run sync_monitor(errch)
	fi;
		for(i : 0.. not_found_peers_Peers12120-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		run go_Anonymous0(resch,errch);
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		do
		:: resch.async_rcv?0 -> 
			goto stop_process
		:: resch.sync?0 -> 
			goto stop_process
		:: errch.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errch.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od;
		for20_end: skip
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef resch;Chandef errch) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: errch.async_send!0;
	:: errch.sync!0 -> 
		errch.sending?0
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

