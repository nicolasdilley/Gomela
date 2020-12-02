
// /tmp/clone-example545132187/go/kbfs/libkbfs/folder_branch_ops.go
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
	Chandef fbo_editChannels;
	Wgdef fbo_doneWg;
	bool state = false;
	Chandef fbo_updatePauseChan;
	int config_RootNodeWrappers41521 = -2;
	Chandef forceSyncChan;
	Chandef fbo_shutdownChan;
	Chandef fbo_syncNeededChan;
	Chandef fbo_refreshEditHistoryChannel;
	int i;
	
	if
	:: true -> 
				for(i : 0.. config_RootNodeWrappers41521-1) {
for10:
		}
	:: true;
	fi;
	run sync_monitor(forceSyncChan);
	run wgMonitor(fbo_doneWg);
	run sync_monitor(fbo_shutdownChan);
	run sync_monitor(fbo_updatePauseChan);
	
	if
	:: 1 > 0 -> 
		fbo_syncNeededChan.size = 1;
		run AsyncChan(fbo_syncNeededChan)
	:: else -> 
		run sync_monitor(fbo_syncNeededChan)
	fi;
	
	if
	:: 100 > 0 -> 
		fbo_editChannels.size = 100;
		run AsyncChan(fbo_editChannels)
	:: else -> 
		run sync_monitor(fbo_editChannels)
	fi;
	
	if
	:: 1 > 0 -> 
		fbo_refreshEditHistoryChannel.size = 1;
		run AsyncChan(fbo_refreshEditHistoryChannel)
	:: else -> 
		run sync_monitor(fbo_refreshEditHistoryChannel)
	fi;
	goto stop_process
stop_process:}

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

