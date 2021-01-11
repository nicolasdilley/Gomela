
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example757678981/iaas/digitalocean/iaas.go
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
	Chandef droplets;
	Chandef errs;
	Chandef quit;
	bool state = false;
	int i;
	run sync_monitor(quit);
	

	if
	:: 1 > 0 -> 
		errs.size = 1;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	

	if
	:: 1 > 0 -> 
		droplets.size = 1;
		run AsyncChan(droplets)
	:: else -> 
		run sync_monitor(droplets)
	fi;
	run go_Anonymous0(quit,errs,droplets);
	do
	:: droplets.async_rcv?0 -> 
		goto stop_process
	:: droplets.sync?0 -> 
		goto stop_process
	:: errs.async_rcv?0 -> 
		goto stop_process
	:: errs.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef quit;Chandef errs;Chandef droplets) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		do
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: errs.async_send!0;
				:: errs.sync!0 -> 
					errs.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: droplets.async_send!0;
				:: droplets.sync!0 -> 
					droplets.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		od;
		for10_end: skip
	od;
	for10_exit: skip;
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

