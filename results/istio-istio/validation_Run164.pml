#define Run_s_Config_ServerListenAddress  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example335976481/tools/istio-iptables/pkg/validation/validator.go
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
	Chandef c;
	bool state = false;
	int i;
	int s_Config_ServerListenAddress = Run_s_Config_ServerListenAddress;
	

	if
	:: 2 > 0 -> 
		c.size = 2;
		run AsyncChan(c)
	:: else -> 
		run sync_monitor(c)
	fi;
		for(i : 0.. s_Config_ServerListenAddress-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		run go_restoreOriginalAddress(c);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: true -> 
		

		if
		:: c.async_rcv?0;
		:: c.sync?0;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_restoreOriginalAddress(Chandef c) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		

		if
		:: true -> 
			goto for11_end
		:: true;
		fi;
		

		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi;
		goto stop_process;
		for11_end: skip
	od;
	for11_exit: skip;
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

