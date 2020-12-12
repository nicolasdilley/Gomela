
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example649965212/modules/examplepersist/examplepersist.go
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
	Chandef regChan;
	int i;
	Chandef configChan;
	Chandef logChan;
	Chandef handlerErrChan;
	Chandef alertChan;
	bool state = false;
	
	if
	:: 64 > 0 -> 
		logChan.size = 64;
		run AsyncChan(logChan)
	:: else -> 
		run sync_monitor(logChan)
	fi;
	
	if
	:: 64 > 0 -> 
		regChan.size = 64;
		run AsyncChan(regChan)
	:: else -> 
		run sync_monitor(regChan)
	fi;
	
	if
	:: 64 > 0 -> 
		handlerErrChan.size = 64;
		run AsyncChan(handlerErrChan)
	:: else -> 
		run sync_monitor(handlerErrChan)
	fi;
	
	if
	:: 1 > 0 -> 
		configChan.size = 1;
		run AsyncChan(configChan)
	:: else -> 
		run sync_monitor(configChan)
	fi;
	
	if
	:: 64 > 0 -> 
		alertChan.size = 64;
		run AsyncChan(alertChan)
	:: else -> 
		run sync_monitor(alertChan)
	fi;
	
	if
	:: true -> 
		
		if
		:: handlerErrChan.async_send!0;
		:: handlerErrChan.sync!0 -> 
			handlerErrChan.sending?0
		fi
	:: true -> 
		
		if
		:: regChan.async_send!0;
		:: regChan.sync!0 -> 
			regChan.sending?0
		fi
	:: true -> 
		
		if
		:: regChan.async_send!0;
		:: regChan.sync!0 -> 
			regChan.sending?0
		fi
	fi;
	run go_HandlePersistRequest(handlerErrChan)
stop_process:}

proctype go_HandlePersistRequest(Chandef errch) {
	bool closed; 
	int i;
	bool state;
		for(i : lb_for511_0.. ub_for511_1) {
for10:		
		if
		:: true -> 
			
			if
			:: errch.async_send!0;
			:: errch.sync!0 -> 
				errch.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		run Anonymous1(errch)
	};
for10_exit:stop_process:
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

