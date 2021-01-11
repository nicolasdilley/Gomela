#define ub_for63_0  -2
#define ub_for86_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example400022664/go/configuration/configuration.go
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
	Chandef req;
	Chandef updates;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		updates.size = 1;
		run AsyncChan(updates)
	:: else -> 
		run sync_monitor(updates)
	fi;
	run sync_monitor(req);
	run go_Anonymous0(updates,req);
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef updates;Chandef req) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for63_0 != -2 -> 
				for(i : 0.. ub_for63_0) {
			for101938: skip;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi;
				goto for10_end1938
			:: true;
			fi;
			break;
			for10_end1938: skip
		};
		for10_exit1938: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi;
				goto for10_end
			:: true;
			fi;
			break;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: updates.async_send!0;
		:: updates.sync!0 -> 
			updates.sending?0
		fi
	:: true -> 
		

		if
		:: updates.async_send!0;
		:: updates.sync!0 -> 
			updates.sending?0
		fi
	:: true -> 
		

		if
		:: updates.async_send!0;
		:: updates.sync!0 -> 
			updates.sending?0
		fi
	fi;
	

	if
	:: 0 != -2 && ub_for86_1 != -2 -> 
				for(i : 0.. ub_for86_1) {
			for201939: skip;
			

			if
			:: req.async_rcv?0;
			:: req.sync?0;
			fi;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi;
				goto for20_end1939
			:: true;
			fi;
			

			if
			:: updates.async_send!0;
			:: updates.sync!0 -> 
				updates.sending?0
			fi;
			for20_end1939: skip
		};
		for20_exit1939: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: req.async_rcv?0;
			:: req.sync?0;
			fi;
			

			if
			:: true -> 
				

				if
				:: updates.async_send!0;
				:: updates.sync!0 -> 
					updates.sending?0
				fi;
				goto for20_end
			:: true;
			fi;
			

			if
			:: updates.async_send!0;
			:: updates.sync!0 -> 
				updates.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
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

