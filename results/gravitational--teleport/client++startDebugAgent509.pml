// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/client/keyagent_test.go#L509
#define ub_for531_3  ??
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
	chan child_startDebugAgent5090 = [1] of {int};
	run startDebugAgent509(child_startDebugAgent5090);
	run receiver(child_startDebugAgent5090)
stop_process:skip
}

proctype startDebugAgent509(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousstartDebugAgent5525221 = [1] of {int};
	chan child_AnonymousstartDebugAgent5265230 = [1] of {int};
	Wgdef wg;
	Chandef doneC_ch;
	Chandef startedC_ch;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(startedC_ch);
	run sync_monitor(doneC_ch);
	run wgMonitor(wg);
	wg.update!2;
	run AnonymousstartDebugAgent526523(doneC_ch,startedC_ch,wg,child_AnonymousstartDebugAgent5265230);
	run receiver(child_AnonymousstartDebugAgent5265230);
	run AnonymousstartDebugAgent552522(startedC_ch,doneC_ch,wg,child_AnonymousstartDebugAgent5525221);
	run receiver(child_AnonymousstartDebugAgent5525221);
	

	if
	:: startedC_ch.deq?state,num_msgs;
	:: startedC_ch.sync?state -> 
		startedC_ch.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousstartDebugAgent526523(Chandef doneC_ch;Chandef startedC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousAnonymousstartDebugAgent5265445231 = [1] of {int};
	chan child_AnonymousAnonymousstartDebugAgent5265405230 = [1] of {int};
	startedC_ch.closing!true;
		for(i : 0.. ub_for531_3) {
		for10: skip;
		

		if
		:: true -> 
			goto defer1
		:: true;
		fi;
		wg.update!2;
		run AnonymousAnonymousstartDebugAgent526540523(doneC_ch,startedC_ch,wg,child_AnonymousAnonymousstartDebugAgent5265405230);
		run receiver(child_AnonymousAnonymousstartDebugAgent5265405230);
		run AnonymousAnonymousstartDebugAgent526544523(doneC_ch,startedC_ch,wg,child_AnonymousAnonymousstartDebugAgent5265445231);
		run receiver(child_AnonymousAnonymousstartDebugAgent5265445231);
		for10_end: skip
	};
	for10_exit: skip;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousstartDebugAgent526540523(Chandef doneC_ch;Chandef startedC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousAnonymousstartDebugAgent526544523(Chandef doneC_ch;Chandef startedC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: doneC_ch.deq?state,num_msgs;
	:: doneC_ch.sync?state -> 
		doneC_ch.rcving!false
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousstartDebugAgent552522(Chandef startedC_ch;Chandef doneC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: doneC_ch.deq?state,num_msgs;
	:: doneC_ch.sync?state -> 
		doneC_ch.rcving!false
	fi;
	wg.update!-1;
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
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
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

proctype receiver(chan c) {
c?0
}

