
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example561586977/go/teams/proofs.go
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
	bool state = false;
	int i;
	int p_proofs=1;
	run sync_monitor(queue);
	run go_Anonymous0(queue,p_proofs);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef queue;int p_proofs) {
	bool closed; 
	int i;
	bool state;
	int v=1;
	

	if
	:: p_proofs-1 != -3 -> 
				for(i : 0.. p_proofs-1) {
			for20: skip;
			

			if
			:: v-1 != -3 -> 
								for(i : 0.. v-1) {
					for21: skip;
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for21800: skip;
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					for21_end800: skip
				:: true -> 
					break
				od;
				for21_exit800: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20801: skip;
			

			if
			:: v-1 != -3 -> 
								for(i : 0.. v-1) {
					for21801: skip;
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					for21_end801: skip
				};
				for21_exit801: skip
			:: else -> 
				do
				:: true -> 
					for21800801: skip;
					

					if
					:: queue.async_send!0;
					:: queue.sync!0 -> 
						queue.sending?0
					fi;
					for21_end800801: skip
				:: true -> 
					break
				od;
				for21_exit800801: skip
			fi;
			for20_end801: skip
		:: true -> 
			break
		od;
		for20_exit801: skip
	fi;
	queue.closing!true;
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


