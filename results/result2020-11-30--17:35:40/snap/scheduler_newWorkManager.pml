#define newWorkManager_wm_collectWkrSize  3
#define newWorkManager_wm_publishWkrSize  1
#define newWorkManager_wm_processWkrSize  1

// /tmp/clone-example436708666/scheduler/work_manager.go
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
	Chandef wm_kill;
	Chandef wm_publishchan;
	int wm_publishWkrSize = newWorkManager_wm_publishWkrSize;
	Chandef wm_collectchan;
	Chandef wm_processchan;
	int wm_collectWkrSize = newWorkManager_wm_collectWkrSize;
	int wm_processWkrSize = newWorkManager_wm_processWkrSize;
	bool state = false;
	run sync_monitor(wm_collectchan);
	run sync_monitor(wm_publishchan);
	run sync_monitor(wm_processchan);
	run sync_monitor(wm_kill);
		for(i : 0.. wm_collectWkrSize-1) {
for20:		chan child_schedulernewWorker0 = [0] of {int};
		run schedulernewWorker(wm_collectchan,child_schedulernewWorker0);
		child_schedulernewWorker0?0
	};
for20_exit:		for(i : 0.. wm_publishWkrSize-1) {
for30:		chan child_schedulernewWorker1 = [0] of {int};
		run schedulernewWorker(wm_publishchan,child_schedulernewWorker1);
		child_schedulernewWorker1?0
	};
for30_exit:		for(i : 0.. wm_processWkrSize-1) {
for40:		chan child_schedulernewWorker2 = [0] of {int};
		run schedulernewWorker(wm_processchan,child_schedulernewWorker2);
		child_schedulernewWorker2?0
	};
for40_exit:	goto stop_process
stop_process:}

proctype schedulernewWorker(Chandef rChan;chan child) {
	bool closed; 
	int i;
	bool state;
	goto stop_process;
stop_process:	child!0
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

