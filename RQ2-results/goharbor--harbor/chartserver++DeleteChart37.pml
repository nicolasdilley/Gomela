#define DeleteChart_qSize  3
#define DeleteChart_allVersions  1

// https://github.com/goharbor/harbor/blob/master/src/chartserver/handler_utility.go#L37
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_DeleteChart370 = [1] of {int};
	run DeleteChart37(child_DeleteChart370)
stop_process:skip
}

proctype DeleteChart37(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDeleteChart98981 = [1] of {int};
	chan child_AnonymousDeleteChart77640 = [1] of {int};
	Chandef errWrapper;
	Wgdef waitGroup;
	Chandef errChan;
	Chandef tokenQueue;
	int qSize = DeleteChart_qSize;
	int allVersions = DeleteChart_allVersions;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: qSize > 0 -> 
		tokenQueue.size = qSize;
		run AsyncChan(tokenQueue)
	:: else -> 
		run sync_monitor(tokenQueue)
	fi;
	

	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	run wgMonitor(waitGroup);
	waitGroup.update!allVersions;
	

	if
	:: 0 != -2 && qSize-1 != -3 -> 
				for(i : 0.. qSize-1) {
			for11: skip;
			

			if
			:: tokenQueue.enq!0;
			:: tokenQueue.sync!false -> 
				tokenQueue.sending!false
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			

			if
			:: tokenQueue.enq!0;
			:: tokenQueue.sync!false -> 
				tokenQueue.sending!false
			fi;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	

	if
	:: 1 > 0 -> 
		errWrapper.size = 1;
		run AsyncChan(errWrapper)
	:: else -> 
		run sync_monitor(errWrapper)
	fi;
	run AnonymousDeleteChart7764(tokenQueue,errChan,errWrapper,waitGroup,child_AnonymousDeleteChart77640);
		for(i : 0.. allVersions-1) {
		for30: skip;
		

		if
		:: tokenQueue.deq?state,num_msgs;
		:: tokenQueue.sync?state -> 
			tokenQueue.rcving!false
		fi;
		run AnonymousDeleteChart9898(tokenQueue,errChan,errWrapper,waitGroup,child_AnonymousDeleteChart98981);
		for30_end: skip
	};
	for30_exit: skip;
	waitGroup.wait?0;
	errChan.closing!true;
	

	if
	:: errWrapper.deq?state,num_msgs;
	:: errWrapper.sync?state -> 
		errWrapper.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousDeleteChart7764(Chandef tokenQueue;Chandef errChan;Chandef errWrapper;Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: errChan.deq?state,num_msgs;
		:: errChan.sync?state -> 
			errChan.rcving!false
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	stop_process: skip;
		

	if
	:: true -> 
		

		if
		:: errWrapper.enq!0;
		:: errWrapper.sync!false -> 
			errWrapper.sending!false
		fi
	:: true;
	fi;
	errWrapper.closing!true;
	child!0
}
proctype AnonymousDeleteChart9898(Chandef tokenQueue;Chandef errChan;Chandef errWrapper;Wgdef waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errChan.enq!0;
		:: errChan.sync!false -> 
			errChan.sending!false
		fi
	:: true;
	fi;
	stop_process: skip;
		

	if
	:: tokenQueue.enq!0;
	:: tokenQueue.sync!false -> 
		tokenQueue.sending!false
	fi;
	waitGroup.update!-1;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

