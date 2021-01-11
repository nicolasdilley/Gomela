#define Start_services  0
#define Start_syncs  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example287807526/pkg/manifest1/run.go
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
	chan child_manifest1RunAsync0 = [0] of {int};
	Chandef r_done;
	bool state = false;
	int i;
	int syncs = Start_syncs;
	int services = Start_services;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(r_done);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
		for(i : 0.. services-1) {
		for60: skip;
		run manifest1RunAsync(r_done,child_manifest1RunAsync0);
		child_manifest1RunAsync0?0;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
						for(i : 0.. syncs-1) {
				for63: skip;
				run go_Anonymous1(r_done);
				for63_end: skip
			};
			for63_exit: skip
		:: true;
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		for60_end: skip
	};
	for60_exit: skip;
	goto stop_process
stop_process:skip
}

proctype manifest1RunAsync(Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_manifest1RunAsync0 = [0] of {int};
	run manifest1RunAsync(done,child_manifest1RunAsync0);
	child_manifest1RunAsync0?0;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef r_done) {
	bool closed; 
	int i;
	bool state;
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

