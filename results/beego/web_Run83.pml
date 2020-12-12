
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example022962104/server/web/server.go
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
	int i;
	Chandef endRunning;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		endRunning.size = 1;
		run AsyncChan(endRunning)
	:: else -> 
		run sync_monitor(endRunning)
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: true -> 
			run Anonymous0(endRunning)
		:: true;
		fi;
		
		if
		:: true -> 
			run Anonymous1(endRunning)
		:: true;
		fi;
		
		if
		:: endRunning.async_rcv?0;
		:: endRunning.sync?0;
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous2(endRunning)
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous3(endRunning)
	:: true;
	fi;
	
	if
	:: endRunning.async_rcv?0;
	:: endRunning.sync?0;
	fi
stop_process:}

proctype Anonymous0(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: endRunning.async_send!0;
	:: endRunning.sync!0 -> 
		endRunning.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: endRunning.async_send!0;
	:: endRunning.sync!0 -> 
		endRunning.sending?0
	fi;
stop_process:
}
proctype Anonymous2(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: endRunning.async_send!0;
		:: endRunning.sync!0 -> 
			endRunning.sending?0
		fi
	:: true;
	fi;
stop_process:
}
proctype Anonymous3(Chandef endRunning) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: endRunning.async_send!0;
			:: endRunning.sync!0 -> 
				endRunning.sending?0
			fi
		:: true;
		fi
	fi;
stop_process:
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

