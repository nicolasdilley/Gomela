// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/istio/istio/blob/9a5df21188426a6a7dd7d7503e01330a79db8a48/pkg/bootstrap/platform/discovery.go#L35
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
	run DiscoverWithTimeout35(child_DiscoverWithTimeout350);
	run receiver(child_DiscoverWithTimeout350)
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
	Chandef done_ch;
	Chandef plat_ch;
	

	if
	:: 3 > 0 -> 
		plat_ch.size = 3;
		run AsyncChan(plat_ch)
	:: else -> 
		run sync_monitor(plat_ch)
	fi;
	run sync_monitor(done_ch);
	run wgMonitor(wg);
	wg.update!3;
	run AnonymousDiscoverWithTimeout4236(plat_ch,done_ch,wg,child_AnonymousDiscoverWithTimeout42360);
	run receiver(child_AnonymousDiscoverWithTimeout42360);
	run AnonymousDiscoverWithTimeout4936(plat_ch,done_ch,wg,child_AnonymousDiscoverWithTimeout49361);
	run receiver(child_AnonymousDiscoverWithTimeout49361);
	run AnonymousDiscoverWithTimeout5636(plat_ch,done_ch,wg,child_AnonymousDiscoverWithTimeout56362);
	run receiver(child_AnonymousDiscoverWithTimeout56362);
	run AnonymousDiscoverWithTimeout6336(plat_ch,done_ch,wg,child_AnonymousDiscoverWithTimeout63363);
	run receiver(child_AnonymousDiscoverWithTimeout63363);
	do
	:: plat_ch.deq?state,num_msgs -> 
		goto stop_process
	:: plat_ch.sync?state -> 
		plat_ch.rcving!false;
		goto stop_process
	:: done_ch.deq?state,num_msgs -> 
		do
		:: plat_ch.deq?state,num_msgs -> 
			goto stop_process
		:: plat_ch.sync?state -> 
			plat_ch.rcving!false;
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		for20_exit: skip;
		break
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		do
		:: plat_ch.deq?state,num_msgs -> 
			goto stop_process
		:: plat_ch.sync?state -> 
			plat_ch.rcving!false;
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		for30_exit: skip;
		break
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout4236(Chandef plat_ch;Chandef done_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: plat_ch.enq!0;
		:: plat_ch.sync!false -> 
			plat_ch.sending!false
		fi
	:: true;
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout4936(Chandef plat_ch;Chandef done_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: plat_ch.enq!0;
		:: plat_ch.sync!false -> 
			plat_ch.sending!false
		fi
	:: true;
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout5636(Chandef plat_ch;Chandef done_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: plat_ch.enq!0;
		:: plat_ch.sync!false -> 
			plat_ch.sending!false
		fi
	:: true;
	fi;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscoverWithTimeout6336(Chandef plat_ch;Chandef done_ch;Wgdef wg;chan child) {
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

