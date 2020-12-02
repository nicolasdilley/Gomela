#define Create_envfile_environmentFilesSource  3

// /tmp/clone-example760496262/agent/taskresource/envFiles/envfile.go
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
	int envfile_environmentFilesSource = Create_envfile_environmentFilesSource;
	Wgdef wg;
	bool state = false;
	Chandef errorEvents;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	
	if
	:: envfile_environmentFilesSource > 0 -> 
		errorEvents.size = envfile_environmentFilesSource;
		run AsyncChan(errorEvents)
	:: else -> 
		run sync_monitor(errorEvents)
	fi;
		for(i : 0.. envfile_environmentFilesSource-1) {
for10:		wg.Add!1;
		run go_envfiledownloadEnvfileFromS3(wg,errorEvents)
	};
	wg.Wait?0;
	errorEvents.closing!true;
	
	if
	:: true -> 
		do
		:: errorEvents.is_closed?state -> 
			if
			:: state -> 
				break
			:: else -> 
				
				if
				:: errorEvents.async_rcv?0;
				:: errorEvents.sync?0;
				fi
			fi
		od;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype go_envfiledownloadEnvfileFromS3(Wgdef wg;Chandef errorEvents) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errorEvents.async_send!0;
		:: errorEvents.sync!0 -> 
			errorEvents.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorEvents.async_send!0;
		:: errorEvents.sync!0 -> 
			errorEvents.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorEvents.async_send!0;
		:: errorEvents.sync!0 -> 
			errorEvents.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorEvents.async_send!0;
		:: errorEvents.sync!0 -> 
			errorEvents.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
stop_process:	wg.Add!-1
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

