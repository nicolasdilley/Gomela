
// https://github.com/istio/istio/blob/master/pkg/bootstrap/platform/discovery.go#L35
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
	chan child_DiscoverWithTimeout350 = [1] of {int};
	run DiscoverWithTimeout35(child_DiscoverWithTimeout350)
stop_process:skip
}

proctype DiscoverWithTimeout35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDiscoverWithTimeout63363 = [1] of {int};
	chan child_AnonymousDiscoverWithTimeout56362 = [1] of {int};
	chan child_AnonymousDiscoverWithTimeout49361 = [1] of {int};
	chan child_AnonymousDiscoverWithTimeout42360 = [1] of {int};
	Wgdef wg;
	Chandef done;
	Chandef plat;
	

	if
	:: 3 > 0 -> 
		plat.size = 3;
		run AsyncChan(plat)
	:: else -> 
		run sync_monitor(plat)
	fi;
	run sync_monitor(done);
	run wgMonitor(wg);
	wg.update!3;
	run AnonymousDiscoverWithTimeout4236(plat,done,wg,child_AnonymousDiscoverWithTimeout42360);
	run AnonymousDiscoverWithTimeout4936(plat,done,wg,child_AnonymousDiscoverWithTimeout49361);
	run AnonymousDiscoverWithTimeout5636(plat,done,wg,child_AnonymousDiscoverWithTimeout56362);
	run AnonymousDiscoverWithTimeout6336(plat,done,wg,child_AnonymousDiscoverWithTimeout63363);
	do
	:: plat.deq?state,num_msgs -> 
		goto stop_process
	:: plat.sync?state -> 
		plat.rcving!false;
		goto stop_process
	:: done.deq?state,num_msgs -> 
		do
		:: plat.deq?state,num_msgs -> 
			goto stop_process
		:: plat.sync?state -> 
			plat.rcving!false;
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		break
	:: done.sync?state -> 
		done.rcving!false;
		do
		:: plat.deq?state,num_msgs -> 
			goto stop_process
		:: plat.sync?state -> 
			plat.rcving!false;
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		break
	:: true -> 
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout4236(Chandef plat;Chandef done;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: plat.enq!0;
		:: plat.sync!false -> 
			plat.sending!false
		fi
	:: true;
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout4936(Chandef plat;Chandef done;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: plat.enq!0;
		:: plat.sync!false -> 
			plat.sending!false
		fi
	:: true;
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout5636(Chandef plat;Chandef done;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: plat.enq!0;
		:: plat.sync!false -> 
			plat.sending!false
		fi
	:: true;
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout6336(Chandef plat;Chandef done;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	done.closing!true;
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

