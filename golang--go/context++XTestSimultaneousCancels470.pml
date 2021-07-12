// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/context/context_test.go#L470
#define XTestSimultaneousCancels_m  ??
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
	chan child_XTestSimultaneousCancels4700 = [1] of {int};
	run XTestSimultaneousCancels470(child_XTestSimultaneousCancels4700);
	run receiver(child_XTestSimultaneousCancels4700)
stop_process:skip
}

proctype XTestSimultaneousCancels470(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousXTestSimultaneousCancels5114952 = [1] of {int};
	Chandef done_ch;
	Chandef stuck_ch;
	chan child_AnonymousXTestSimultaneousCancels4884880 = [1] of {int};
	Wgdef wg;
	int var_m = XTestSimultaneousCancels_m; // mand var_m
	run wgMonitor(wg);
	wg.update!var_m;
		for(i : 0.. var_m-1) {
		for20: skip;
		run AnonymousXTestSimultaneousCancels488488(wg,child_AnonymousXTestSimultaneousCancels4884880);
		run receiver(child_AnonymousXTestSimultaneousCancels4884880);
		for20_end: skip
	};
	for20_exit: skip;
	run sync_monitor(stuck_ch);
	

	if
	:: var_m-1 != -3 -> 
				for(i : 0.. var_m-1) {
			for30: skip;
			do
			:: true -> 
				break
			:: stuck_ch.deq?state,num_msgs -> 
				break
			:: stuck_ch.sync?state -> 
				stuck_ch.rcving!false;
				break
			od;
			for31_exit: skip;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for32: skip;
			do
			:: true -> 
				break
			:: stuck_ch.deq?state,num_msgs -> 
				break
			:: stuck_ch.sync?state -> 
				stuck_ch.rcving!false;
				break
			od;
			for33_exit: skip;
			for32_end: skip
		:: true -> 
			break
		od;
		for32_exit: skip
	fi;
	run sync_monitor(done_ch);
	run AnonymousXTestSimultaneousCancels511495(stuck_ch,done_ch,wg,child_AnonymousXTestSimultaneousCancels5114952);
	run receiver(child_AnonymousXTestSimultaneousCancels5114952);
	do
	:: done_ch.deq?state,num_msgs -> 
		break
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		break
	:: stuck_ch.deq?state,num_msgs -> 
		break
	:: stuck_ch.sync?state -> 
		stuck_ch.rcving!false;
		break
	od;
	for40_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousXTestSimultaneousCancels488488(Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymousXTestSimultaneousCancels511495(Chandef stuck_ch;Chandef done_ch;Wgdef wg;chan child) {
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

