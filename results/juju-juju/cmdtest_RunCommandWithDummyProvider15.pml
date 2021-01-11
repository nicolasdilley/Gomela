
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example616394530/cmd/cmdtest/testing.go
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
	chan child_Listen0 = [0] of {int};
	Chandef opc;
	Chandef errc;
	bool state = false;
	int i;
	

	if
	:: 1 > 0 -> 
		errc.size = 1;
		run AsyncChan(errc)
	:: else -> 
		run sync_monitor(errc)
	fi;
	

	if
	:: 200 > 0 -> 
		opc.size = 200;
		run AsyncChan(opc)
	:: else -> 
		run sync_monitor(opc)
	fi;
	run Listen(opc,child_Listen0);
	child_Listen0?0;
	run go_Anonymous1(errc,opc);
	goto stop_process
stop_process:skip
}

proctype Listen(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef errc;Chandef opc) {
	bool closed; 
	int i;
	bool state;
	

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
	:: errc.async_send!0;
	:: errc.sync!0 -> 
		errc.sending?0
	fi;
	stop_process: skip;
	opc.closing!true
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

