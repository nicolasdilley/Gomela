#define runModules_parallelism  1
#define runModules_modules  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example883888966/configstack/running_module.go
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
	Chandef semaphore;
	Wgdef waitGroup;
	int num_msgs = 0;
	bool state = false;
	int i;
	int modules = runModules_modules;
	int parallelism = runModules_parallelism;
	run wgMonitor(waitGroup);
	

	if
	:: parallelism > 0 -> 
		semaphore.size = parallelism;
		run AsyncChan(semaphore)
	:: else -> 
		run sync_monitor(semaphore)
	fi;
		for(i : 0.. modules-1) {
		for10: skip;
		waitGroup.Add!1;
		run go_Anonymous0(semaphore,waitGroup);
		for10_end: skip
	};
	for10_exit: skip;
	waitGroup.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef semaphore;Wgdef waitGroup) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_runModuleWhenReady0 = [0] of {int};
	run runModuleWhenReady(semaphore,child_runModuleWhenReady0);
	child_runModuleWhenReady0?0;
	stop_process: skip;
	waitGroup.Add!-1
}
proctype runModuleWhenReady(Chandef semaphore;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: semaphore.async_send!0;
	:: semaphore.sync!false,0 -> 
		semaphore.sending?state
	fi;
	stop_process: skip;
	

	if
	:: semaphore.async_rcv?state,num_msgs;
	:: semaphore.sync?state,num_msgs;
	fi;
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

