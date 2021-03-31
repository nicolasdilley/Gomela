
// https://github.com/hello.go/blob//#L35
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
	run go_TestCockroach24808()
stop_process:skip
}

proctype go_TestCockroach24808() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Start0 = [0] of {int};
	Chandef compactor_ch;
	Wgdef stopper_stop;
	Chandef stopper_stopper;
	run sync_monitor(stopper_stopper);
	run wgMonitor(stopper_stop);
	

	if
	:: 1 > 0 -> 
		compactor_ch.size = 1;
		run AsyncChan(compactor_ch)
	:: else -> 
		run sync_monitor(compactor_ch)
	fi;
	

	if
	:: compactor_ch.enq!0;
	:: compactor_ch.sync!false -> 
		compactor_ch.sending!false
	fi;
	run Start(compactor_ch,stopper_stopper,stopper_stop,child_Start0);
	child_Start0?0;
	stop_process: skip;
		stopper_stopper.closing!true
}
proctype Start(Chandef c_ch;Chandef stopper_stopper;Wgdef stopper_stop;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c_ch.enq!0;
	:: c_ch.sync!false -> 
		c_ch.sending!false
	fi;
	stopper_stop.update!1;
	run go_AnonymousStart21(c_ch,stopper_stopper,stopper_stop);
	stop_process: skip;
	child!0
}
proctype go_AnonymousStart21(Chandef c_ch;Chandef stopper_stopper;Wgdef stopper_stop) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: stopper_stopper.deq?state,num_msgs -> 
			goto stop_process
		:: stopper_stopper.sync?state -> 
			stopper_stopper.rcving!false;
			goto stop_process
		:: c_ch.deq?state,num_msgs -> 
			break
		:: c_ch.sync?state -> 
			c_ch.rcving!false;
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
		stopper_stop.update!-1
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

