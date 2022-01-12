// num_comm_params=2
// num_mand_comm_params=1
// num_opt_comm_params=1

// git_link=https://github.com/syncthing/syncthing/blob//lib/nat/registry.go#L23
#define def_var_providers25  ?? // mand providers line 25
#define def_var_discoverFunc  -2 // opt f line 31
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
	run discoverAll23(child_discoverAll230);
	run receiver(child_discoverAll230)
stop_process:skip
}

proctype discoverAll23(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousdiscoverAll45272 = [1] of {int};
	chan child_AnonymousdiscoverAll31310 = [1] of {int};
	int var_discoverFunc = def_var_discoverFunc;
	Chandef done_ch;
	Chandef c_ch;
	Wgdef wg;
	int var_providers = def_var_providers25; // mand var_providers
	run wgMonitor(wg);
	wg.update!var_providers;
	run sync_monitor(c_ch);
	run sync_monitor(done_ch);
		for(i : 0.. var_providers-1) {
		for10: skip;
		run AnonymousdiscoverAll3131(c_ch,done_ch,wg,var_discoverFunc,child_AnonymousdiscoverAll31310);
		run receiver(child_AnonymousdiscoverAll31310);
		for10_end: skip
	};
	for10_exit: skip;
	run AnonymousdiscoverAll4527(c_ch,done_ch,wg,child_AnonymousdiscoverAll45272);
	run receiver(child_AnonymousdiscoverAll45272);
	wg.wait?0;
	c_ch.closing!true;
	

	if
	:: done_ch.deq?state,num_msgs;
	:: done_ch.sync?state -> 
		done_ch.rcving!false
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousdiscoverAll3131(Chandef c_ch;Chandef done_ch;Wgdef wg;int var_f;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: var_f-1 != -3 -> 
				for(i : 0.. var_f-1) {
			for11: skip;
			do
			:: c_ch.enq!0 -> 
				break
			:: c_ch.sync!false -> 
				c_ch.sending!false;
				break
			:: true -> 
				goto defer1
			od;
			for12_exit: skip;
			for12_end: skip;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for13: skip;
			do
			:: c_ch.enq!0 -> 
				break
			:: c_ch.sync!false -> 
				c_ch.sending!false;
				break
			:: true -> 
				goto defer1
			od;
			for14_exit: skip;
			for14_end: skip;
			for13_end: skip
		:: true -> 
			break
		od;
		for13_exit: skip
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousdiscoverAll4527(Chandef c_ch;Chandef done_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for20: skip;
		do
		:: c_ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			break
		:: c_ch.sync?state -> 
			c_ch.rcving!false;
			

			if
			:: true -> 
				goto defer1
			:: true;
			fi;
			break
		:: true -> 
			goto defer1
		od;
		for21_exit: skip;
		for21_end: skip;
		for20_end: skip
	od;
	for20_exit: skip;
		defer1: skip;
	done_ch.closing!true;
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

