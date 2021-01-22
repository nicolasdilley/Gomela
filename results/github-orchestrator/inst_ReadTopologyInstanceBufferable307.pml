
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example123082596/go/inst/instance_dao.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
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
	Wgdef serverUuidWaitGroup;
	Wgdef waitGroup;
	int num_msgs = 0;
	bool state = false;
	int i;
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
			run go_Anonymous0(errorChan,waitGroup,serverUuidWaitGroup)
		:: true;
		fi;
		

		if
		:: true -> 
			waitGroup.Add!1;
			serverUuidWaitGroup.Add!1;
			run go_Anonymous1(errorChan,waitGroup,serverUuidWaitGroup)
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
		run go_Anonymous2(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous3(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous4(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous5(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous6(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous7(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous8(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous9(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	

	if
	:: true -> 
		waitGroup.Add!1;
		run go_Anonymous10(errorChan,waitGroup,serverUuidWaitGroup)
	:: true;
	fi;
	Cleanup: skip;
		waitGroup.Wait?0;
	errorChan.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
		

		if
		:: errorChan.async_rcv?state,num_msgs;
		:: errorChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	goto stop_process;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: errorChan.async_send!0;
	:: errorChan.sync!false,0 -> 
		errorChan.sending?state
	fi;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous1(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	serverUuidWaitGroup.Add!-1;
	waitGroup.Add!-1
}
proctype go_Anonymous2(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous3(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous4(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous5(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous6(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous7(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous8(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous9(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype go_Anonymous10(Chandef errorChan;Wgdef waitGroup;Wgdef serverUuidWaitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	waitGroup.Add!-1
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
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
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}

