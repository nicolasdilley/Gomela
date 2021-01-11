#define ub_for189_0  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example273423399/conn_pool.go
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
	Chandef ch;
	chan child_mainputConnToChan0 = [0] of {int};
	bool state = false;
	int i;
	

	if
	:: true -> 
		

		if
		:: 5 > 0 -> 
			ch.size = 5;
			run AsyncChan(ch)
		:: else -> 
			run sync_monitor(ch)
		fi;
		

		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		run go_closeStaleServerConn(ch)
	:: true -> 
		run mainputConnToChan(ch,child_mainputConnToChan0);
		child_mainputConnToChan0?0
	:: true -> 
		run mainputConnToChan(ch,child_mainputConnToChan0);
		child_mainputConnToChan0?0
	fi
stop_process:skip
}

proctype go_closeStaleServerConn(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	chan child_maincloseServerConn0 = [0] of {int};
		for(i : 0.. ub_for189_0) {
		for10: skip;
		run maincloseServerConn(ch,child_maincloseServerConn0);
		child_maincloseServerConn0?0;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		for10_end: skip
	};
	for10_exit: skip;
	do
	:: true -> 
		for20: skip;
		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		:: true -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype maincloseServerConn(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int lcnt = -2;
	

	if
	:: 0 != -2 && lcnt-1 != -3 -> 
				for(i : 0.. lcnt-1) {
			for11398: skip;
			do
			:: ch.async_rcv?0 -> 
				

				if
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: ch.sync?0 -> 
				

				if
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for11_end398: skip
		};
		for11_exit398: skip
	:: else -> 
		do
		:: true -> 
			for11: skip;
			do
			:: ch.async_rcv?0 -> 
				

				if
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: ch.sync?0 -> 
				

				if
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				:: true -> 
					

					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for11_end: skip
		:: true -> 
			break
		od;
		for11_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype mainputConnToChan(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: ch.async_send!0 -> 
		goto stop_process
	:: ch.sync!0 -> 
		ch.sending?0;
		goto stop_process
	:: true;
	od;
	stop_process: skip;
	child!0
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

