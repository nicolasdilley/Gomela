#define ub_for40_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example226065188/pkg/providers/common/get_instance_listener_ip.go
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
	Chandef resultc;
	Chandef errc;
	bool state = false;
	int i;
	run sync_monitor(errc);
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	run sync_monitor(resultc);
	run go_Anonymous0(errc,resultc);
	do
	:: resultc.async_rcv?0 -> 
		goto stop_process
	:: resultc.sync?0 -> 
		goto stop_process
	:: errc.async_rcv?0 -> 
		goto stop_process
	:: errc.sync?0 -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_Anonymous0(Chandef errc;Chandef resultc) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for40_0 != -2 -> 
				for(i : 0.. ub_for40_0) {
			for101568: skip;
			

			if
			:: true -> 
				

				if
				:: errc.async_send!0;
				:: errc.sync!0 -> 
					errc.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: resultc.async_send!0;
				:: resultc.sync!0 -> 
					resultc.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end1568: skip
		};
		for10_exit1568: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: errc.async_send!0;
				:: errc.sync!0 -> 
					errc.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: resultc.async_send!0;
				:: resultc.sync!0 -> 
					resultc.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
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

