
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example102276982/pkg/api/http/events/handlers.go
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
	chan child_Subscribe1 = [0] of {int};
	Chandef es;
	chan child_NewSocket0 = [0] of {int};
	Chandef event;
	Chandef leave;
	Chandef done;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run sync_monitor(leave);
	run sync_monitor(event);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run NewSocket(leave,event,child_NewSocket0);
	child_NewSocket0?0;
	run sync_monitor(es);
	run go_Anonymous1(done,leave,event,es);
	run Subscribe(es,done,child_Subscribe1);
	child_Subscribe1?0
stop_process:skip
}

proctype NewSocket(Chandef leave;Chandef event;chan child) {
	bool closed; 
	int i;
	bool state;
	Chandef s_close;
	Chandef s_pong;
	Chandef s_ping;
	Chandef s_write;
	run sync_monitor(s_write);
	run sync_monitor(s_ping);
	run sync_monitor(s_pong);
	run sync_monitor(s_close);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef done;Chandef leave;Chandef event;Chandef es) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		do
		:: leave.async_rcv?0 -> 
			

			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi;
			goto stop_process
		:: leave.sync?0 -> 
			

			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi;
			goto stop_process
		:: es.async_rcv?0 -> 
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			break
		:: es.sync?0 -> 
			

			if
			:: true -> 
				goto for10_end
			:: true;
			fi;
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype Subscribe(Chandef subscriber;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
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

