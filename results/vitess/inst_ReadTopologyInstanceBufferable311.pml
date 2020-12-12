
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example476275474/go/vt/orchestrator/inst/instance_dao.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef errorChan;
	Wgdef waitGroup;
	int i;
	Wgdef serverUuidWaitGroup;
	int strings_Split89825 = -2;
	bool state = false;
	run wgMonitor(waitGroup);
	run wgMonitor(serverUuidWaitGroup);
	
	if
	:: 32 > 0 -> 
		errorChan.size = 32;
		run AsyncChan(errorChan)
	:: else -> 
		run sync_monitor(errorChan)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto Cleanup
	:: true;
	fi;
	
	if
	:: true -> 
		goto Cleanup
	:: true;
	fi;
	
	if
	:: true -> 
		goto Cleanup
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto Cleanup
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				goto Cleanup
			:: true;
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto Cleanup
		:: true;
		fi;
		
		if
		:: true -> 
			waitGroup.Add!1;
			run Anonymous0(errorChan,waitGroup,serverUuidWaitGroup)
		:: true;
		fi;
		
		if
		:: true -> 
			waitGroup.Add!1;
			serverUuidWaitGroup.Add!1;
			run Anonymous1(errorChan,waitGroup,serverUuidWaitGroup)
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			goto Cleanup
		:: true;
		fi;
		
		if
		:: true -> 
			waitGroup.Add!1;
			run Anonymous0(errorChan,waitGroup,serverUuidWaitGroup)
		:: true;
		fi;
		
		if
		:: true -> 
			waitGroup.Add!1;
			serverUuidWaitGroup.Add!1;
			run Anonymous1(errorChan,waitGroup,serverUuidWaitGroup)
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		goto Cleanup
	:: true;
	fi;
	
	if
	:: true -> 
		goto Cleanup
	:: true;
	fi;
	serverUuidWaitGroup.Wait?0;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto Cleanup
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto Cleanup
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous2(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous3(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous4(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous5(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous6(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous7(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous8(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	
	if
	:: true -> 
		waitGroup.Add!1;
		run Anonymous9(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
Cleanup:		waitGroup.Wait?0;
	errorChan.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: errorChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errorChan.async_rcv?0;
			:: errorChan.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		fi
	od;
	goto stop_process;
	
	if
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. strings_Split89825-1) {
for20:
			}
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errorChan.async_send!0;
	:: errorChan.sync!0 -> 
		errorChan.sending?0
	fi;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous1(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1;
	serverUuidWaitGroup.Add!-1
}
proctype Anonymous2(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous3(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous4(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous5(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous6(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous7(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous8(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype Anonymous9(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitGroup.Add!-1
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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

