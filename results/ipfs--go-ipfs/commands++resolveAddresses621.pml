// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/ipfs/go-ipfs/blob//core/commands/swarm.go#L621
#define def_var_addrs  ?? // mand addrs line 621
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
	chan child_resolveAddresses6210 = [1] of {int};
	run resolveAddresses621(def_var_addrs,child_resolveAddresses6210);
	run receiver(child_resolveAddresses6210)
stop_process:skip
}

proctype resolveAddresses621(int var_addrs;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousresolveAddresses6636272 = [1] of {int};
	chan child_AnonymousresolveAddresses6436430 = [1] of {int};
	Chandef maddrC_ch;
	Chandef resolveErrC_ch;
	Wgdef wg;
	run wgMonitor(wg);
	

	if
	:: var_addrs > 0 -> 
		resolveErrC_ch.size = var_addrs;
		run AsyncChan(resolveErrC_ch)
	:: else -> 
		run sync_monitor(resolveErrC_ch)
	fi;
	run sync_monitor(maddrC_ch);
		for(i : 0.. var_addrs-1) {
		for10: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		wg.update!1;
		run AnonymousresolveAddresses643643(resolveErrC_ch,maddrC_ch,wg,child_AnonymousresolveAddresses6436430);
		run receiver(child_AnonymousresolveAddresses6436430);
		for10_end: skip
	};
	for10_exit: skip;
	run AnonymousresolveAddresses663627(resolveErrC_ch,maddrC_ch,wg,child_AnonymousresolveAddresses6636272);
	run receiver(child_AnonymousresolveAddresses6636272);
	do
	:: true -> 
		num_msgs = 0;
		

		if
		:: maddrC_ch.deq?state,num_msgs;
		:: maddrC_ch.sync?state -> 
			maddrC_ch.rcving!false
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
	do
	:: resolveErrC_ch.deq?state,num_msgs -> 
		goto stop_process
	:: resolveErrC_ch.sync?state -> 
		resolveErrC_ch.rcving!false;
		goto stop_process
	:: true -> 
		break
	od;
	for30_exit: skip;
	for30_end: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousresolveAddresses643643(Chandef resolveErrC_ch;Chandef maddrC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_raddrs = -2; // opt var_raddrs
	

	if
	:: true -> 
		

		if
		:: resolveErrC_ch.enq!0;
		:: resolveErrC_ch.sync!false -> 
			resolveErrC_ch.sending!false
		fi;
		goto defer1
	:: true;
	fi;
	

	if
	:: var_raddrs-1 != -3 -> 
				for(i : 0.. var_raddrs-1) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: maddrC_ch.enq!0;
				:: maddrC_ch.sync!false -> 
					maddrC_ch.sending!false
				fi
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for12: skip;
			

			if
			:: true -> 
				

				if
				:: maddrC_ch.enq!0;
				:: maddrC_ch.sync!false -> 
					maddrC_ch.sending!false
				fi
			:: true;
			fi;
			for12_end: skip
		:: true -> 
			break
		od;
		for12_exit: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: resolveErrC_ch.enq!0;
		:: resolveErrC_ch.sync!false -> 
			resolveErrC_ch.sending!false
		fi
	:: true;
	fi;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousresolveAddresses663627(Chandef resolveErrC_ch;Chandef maddrC_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	maddrC_ch.closing!true;
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

