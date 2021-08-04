// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/syncthing/syncthing/blob/87a0eecc31a0a5eeef1d0da510f4d5832e022e1f/lib/upnp/upnp.go#L88
#define def_var_interfaces101  ?? // mand interfaces line 101
#define not_found_10730  ??
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
	chan child_Discover880 = [1] of {int};
	run Discover88(child_Discover880);
	run receiver(child_Discover880)
stop_process:skip
}

proctype Discover88(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousDiscover116974 = [1] of {int};
	chan child_AnonymousDiscover1091090 = [1] of {int};
	Wgdef wg;
	Chandef resultChan_ch;
	int var_interfaces = def_var_interfaces101; // mand var_interfaces
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(resultChan_ch);
	run wgMonitor(wg);
		for(i : 0.. var_interfaces-1) {
		for10: skip;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
				for(i : 0.. not_found_10730-1) {
			for11: skip;
			wg.update!1;
			run AnonymousDiscover109109(resultChan_ch,wg,child_AnonymousDiscover1091090);
			run receiver(child_AnonymousDiscover1091090);
			for11_end: skip
		};
		for11_exit: skip;
		for10_end: skip
	};
	for10_exit: skip;
	run AnonymousDiscover11697(resultChan_ch,wg,child_AnonymousDiscover116974);
	run receiver(child_AnonymousDiscover116974);
	do
	:: true -> 
		for20: skip;
		do
		:: resultChan_ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			break
		:: resultChan_ch.sync?state -> 
			resultChan_ch.rcving!false;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			break
		:: true -> 
			goto stop_process
		od;
		for21_exit: skip;
		for21_end: skip;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscover109109(Chandef resultChan_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_discover1460 = [1] of {int};
	run discover146(resultChan_ch,child_discover1460);
	child_discover1460?0;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype discover146(Chandef results_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int var_igds = -2; // opt var_igds
	

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
	do
	:: true -> 
		for12: skip;
		

		if
		:: true -> 
			break
		:: true;
		fi;
		

		if
		:: true -> 
			do
			:: true -> 
				goto loop;
				break
			:: true -> 
				break
			od;
			for13_exit: skip;
			for13_end: skip;
			

			if
			:: true -> 
				goto for13_end
			:: true;
			fi;
			break
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true;
			:: true;
			fi;
			goto for13_end
		:: true;
		fi;
		

		if
		:: var_igds-1 != -3 -> 
						for(i : 0.. var_igds-1) {
				for14: skip;
				do
				:: results_ch.enq!0 -> 
					break
				:: results_ch.sync!false -> 
					results_ch.sending!false;
					break
				:: true -> 
					goto stop_process
				od;
				for15_exit: skip;
				for15_end: skip;
				for14_end: skip
			};
			for14_exit: skip
		:: else -> 
			do
			:: true -> 
				for16: skip;
				do
				:: results_ch.enq!0 -> 
					break
				:: results_ch.sync!false -> 
					results_ch.sending!false;
					break
				:: true -> 
					goto stop_process
				od;
				for17_exit: skip;
				for17_end: skip;
				for16_end: skip
			:: true -> 
				break
			od;
			for16_exit: skip
		fi;
		for12_end: skip
	od;
	for12_exit: skip;
	loop: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousDiscover11697(Chandef resultChan_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.wait?0;
	resultChan_ch.closing!true;
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

