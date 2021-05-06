#define discoverAll_providers  3

// https://github.com/syncthing/syncthing/blob/master/lib/nat/registry.go#L23
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
	chan child_discoverAll230 = [1] of {int};
	run discoverAll23(child_discoverAll230)
stop_process:skip
}

proctype discoverAll23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdiscoverAll45272 = [1] of {int};
	chan child_AnonymousdiscoverAll31310 = [1] of {int};
	Chandef done;
	Chandef c;
	Wgdef wg;
	int providers = discoverAll_providers;
	run wgMonitor(wg);
	wg.update!providers;
	run sync_monitor(c);
	run sync_monitor(done);
		for(i : 0.. providers-1) {
		for10: skip;
		run AnonymousdiscoverAll3131(c,done,wg,child_AnonymousdiscoverAll31310);
		for10_end: skip
	};
	for10_exit: skip;
	run AnonymousdiscoverAll4527(c,done,wg,child_AnonymousdiscoverAll45272);
	wg.wait?0;
	c.closing!true;
	

	if
	:: done.deq?state,num_msgs;
	:: done.sync?state -> 
		done.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdiscoverAll3131(Chandef c;Chandef done;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int f_ctx_renewal_timeout_=3;
	

	if
	:: f_ctx_renewal_timeout_-1 != -3 -> 
				for(i : 0.. f_ctx_renewal_timeout_-1) {
			for11: skip;
			do
			:: c.enq!0 -> 
				break
			:: c.sync!false,0 -> 
				c.sending!false;
				break
			:: true -> 
				goto stop_process
			od;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
			do
			:: c.enq!0 -> 
				break
			:: c.sync!false,0 -> 
				c.sending!false;
				break
			:: true -> 
				goto stop_process
			od;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
	fi;
	stop_process: skip;
		wg.update!-1;
	child!0
}
proctype AnonymousdiscoverAll4527(Chandef c;Chandef done;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		do
		:: c.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: c.sync?state -> 
			c.rcving!false;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
		done.closing!true;
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


