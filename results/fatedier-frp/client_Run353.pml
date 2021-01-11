#define not_found_42  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example759182461/client/visitor.go
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
	Chandef sv_readCh;
	Chandef sv_sendCh;
	bool state = false;
	int i;
	

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
	:: 1024 > 0 -> 
		sv_sendCh.size = 1024;
		run AsyncChan(sv_sendCh)
	:: else -> 
		run sync_monitor(sv_sendCh)
	fi;
	

	if
	:: 1024 > 0 -> 
		sv_readCh.size = 1024;
		run AsyncChan(sv_readCh)
	:: else -> 
		run sync_monitor(sv_readCh)
	fi;
	run go_ForwardUserConn(sv_readCh,sv_sendCh);
	goto stop_process
stop_process:skip
}

proctype go_ForwardUserConn(Chandef readCh;Chandef sendCh) {
	bool closed; 
	int i;
	bool state;
	run go_Anonymous1(readCh,sendCh,not_found_42);
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: sendCh.async_send!0 -> 
			break
		:: sendCh.sync!0 -> 
			sendCh.sending?0;
			break
		:: true;
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef readCh;Chandef sendCh;int readCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: readCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: readCh.async_rcv?0;
			:: readCh.sync?0;
			fi;
			for10: skip;
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			for10_end: skip
		fi
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

