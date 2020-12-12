#define prune_refs  ??
#define prune_allWorktreeRefs  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/commands/command_prune.go
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
	Wgdef verifywait;
	Wgdef errorwait;
	Wgdef taskwait;
	Wgdef retainwait;
	int i;
	Chandef errorChan;
	Chandef retainChan;
	Wgdef progresswait;
	int verboseOutput = -2;
	bool state = false;
	run wgMonitor(taskwait);
	taskwait.Add!5;
	
	if
	:: true -> 
		taskwait.Add!1
	:: true;
	fi;
	
	if
	:: 10 > 0 -> 
		errorChan.size = 10;
		run AsyncChan(errorChan)
	:: else -> 
		run sync_monitor(errorChan)
	fi;
	run wgMonitor(errorwait);
	errorwait.Add!1;
	run go_commandspruneTaskCollectErrors(errorChan,errorwait);
	run go_commandspruneTaskGetLocalObjects(taskwait);
	
	if
	:: 100 > 0 -> 
		retainChan.size = 100;
		run AsyncChan(retainChan)
	:: else -> 
		run sync_monitor(retainChan)
	fi;
	run go_commandspruneTaskGetRetainedCurrentAndRecentRefs(retainChan,errorChan,taskwait);
	run go_commandspruneTaskGetRetainedUnpushed(retainChan,errorChan,taskwait);
	run go_commandspruneTaskGetRetainedWorktree(retainChan,errorChan,taskwait);
	run go_commandspruneTaskGetRetainedStashed(retainChan,errorChan,taskwait);
	
	if
	:: true -> 
		run go_commandspruneTaskGetReachableObjects(errorChan,taskwait)
	:: true;
	fi;
	run wgMonitor(retainwait);
	retainwait.Add!1;
	run go_commandspruneTaskCollectRetained(retainChan,retainwait);
	run wgMonitor(progresswait);
	progresswait.Add!1;
	run go_commandspruneTaskDisplayProgress(progresswait,progressChan);
	taskwait.Wait?0;
	retainChan.closing!true;
	retainwait.Wait?0;
	errorChan.closing!true;
	errorwait.Wait?0;
	run wgMonitor(verifywait);
	
	if
	:: true -> 
		Wgdef verifyQueue_collectorWait;
		run wgMonitor(verifyQueue_collectorWait);
		Wgdef verifyQueue_errorwait;
		run wgMonitor(verifyQueue_errorwait);
		verifywait.Add!1;
		run Anonymous9(errorChan,retainChan,taskwait,errorwait,retainwait,progresswait,verifywait)
	:: true;
	fi;
	
	if
	:: true -> 
		verifywait.Wait?0;
		progresswait.Wait?0
	:: true -> 
		progresswait.Wait?0
	:: true -> 
		progresswait.Wait?0
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. verboseOutput-1) {
for90:
		}
	:: true -> 
				for(i : 0.. verboseOutput-1) {
for100:
		}
	:: true -> 
				for(i : 0.. verboseOutput-1) {
for100:
		}
	fi
stop_process:}

proctype go_commandspruneTaskCollectErrors(Chandef errorChan;Wgdef errorwait) {
	bool closed; 
	int i;
	bool state;
	do
	:: errorChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: errorChan.async_rcv?0;
			:: errorChan.sync?0;
			fi
		fi
	od;
stop_process:	errorwait.Add!-1
}
proctype go_commandspruneTaskGetLocalObjects(Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitg.Add!-1
}
proctype go_commandspruneTaskGetRetainedCurrentAndRecentRefs(Chandef retainChan;Chandef errorChan;Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	int refs = prune_refs;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	waitg.Add!1;
	run go_commandspruneTaskGetRetainedAtRef(retainChan,errorChan,waitg);
	
	if
	:: true -> 
				for(i : 0.. refs-1) {
for20:			
			if
			:: true -> 
				waitg.Add!1;
				run go_commandspruneTaskGetRetainedAtRef(retainChan,errorChan,waitg)
			:: true;
			fi
		}
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. commits_Iter41623-1) {
for30:			
			if
			:: true -> 
				
				if
				:: errorChan.async_send!0;
				:: errorChan.sync!0 -> 
					errorChan.sending?0
				fi
			:: true;
			fi;
			waitg.Add!1;
			run go_commandspruneTaskGetPreviousVersionsOfRef(retainChan,errorChan,waitg)
		}
	:: true;
	fi;
stop_process:	waitg.Add!-1
}
proctype go_commandspruneTaskGetRetainedUnpushed(Chandef retainChan;Chandef errorChan;Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
stop_process:	waitg.Add!-1
}
proctype go_commandspruneTaskGetRetainedWorktree(Chandef retainChan;Chandef errorChan;Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	int allWorktreeRefs = prune_allWorktreeRefs;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : 0.. allWorktreeRefs-1) {
for40:		
		if
		:: true -> 
			waitg.Add!1;
			run go_commandspruneTaskGetRetainedAtRef(retainChan,errorChan,waitg)
		:: true;
		fi
	};
stop_process:	waitg.Add!-1
}
proctype go_commandspruneTaskGetRetainedStashed(Chandef retainChan;Chandef errorChan;Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
stop_process:	waitg.Add!-1
}
proctype go_commandspruneTaskGetReachableObjects(Chandef errorChan;Wgdef waitg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errorChan.async_send!0;
		:: errorChan.sync!0 -> 
			errorChan.sending?0
		fi
	:: true;
	fi;
stop_process:	waitg.Add!-1
}
proctype go_commandspruneTaskCollectRetained(Chandef retainChan;Wgdef retainwait) {
	bool closed; 
	int i;
	bool state;
	do
	:: retainChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: retainChan.async_rcv?0;
			:: retainChan.sync?0;
			fi
		fi
	od;
stop_process:	retainwait.Add!-1
}
proctype go_commandspruneTaskDisplayProgress(Wgdef waitg;int progressChan) {
	bool closed; 
	int i;
	bool state;
stop_process:	waitg.Add!-1
}
proctype Anonymous9(Chandef errorChan;Chandef retainChan;Wgdef taskwait;Wgdef errorwait;Wgdef retainwait;Wgdef progresswait;Wgdef verifywait) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for70:
	:: true -> 
		break
	od;
	verifywait.Add!-1;
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

