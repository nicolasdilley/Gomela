#define newWorkManager_wm_collectWkrSize  3
#define newWorkManager_wm_publishWkrSize  1
#define newWorkManager_wm_processWkrSize  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example847869176/scheduler/work_manager.go
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



init { 
	chan child_schedulernewWorker2 = [0] of {int};
	chan child_schedulernewWorker1 = [0] of {int};
	chan child_schedulernewWorker0 = [0] of {int};
	Chandef wm_kill;
	Chandef wm_processchan;
	Chandef wm_publishchan;
	Chandef wm_collectchan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int wm_processWkrSize = newWorkManager_wm_processWkrSize;
	int wm_publishWkrSize = newWorkManager_wm_publishWkrSize;
	int wm_collectWkrSize = newWorkManager_wm_collectWkrSize;
	run sync_monitor(wm_collectchan);
	run sync_monitor(wm_publishchan);
	run sync_monitor(wm_processchan);
	run sync_monitor(wm_kill);
		for(i : 0.. wm_collectWkrSize-1) {
		for20: skip;
		run schedulernewWorker(wm_collectchan,child_schedulernewWorker0);
		child_schedulernewWorker0?0;
		for20_end: skip
	};
	for20_exit: skip;
		for(i : 0.. wm_publishWkrSize-1) {
		for30: skip;
		run schedulernewWorker(wm_publishchan,child_schedulernewWorker1);
		child_schedulernewWorker1?0;
		for30_end: skip
	};
	for30_exit: skip;
		for(i : 0.. wm_processWkrSize-1) {
		for40: skip;
		run schedulernewWorker(wm_processchan,child_schedulernewWorker2);
		child_schedulernewWorker2?0;
		for40_end: skip
	};
	for40_exit: skip;
	goto stop_process
stop_process:skip
}

proctype schedulernewWorker(Chandef rChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
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

