// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//os/pipe_test.go#L282
#define ub_for320_2  -2
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
	chan child_testCloseWithBlockingRead2820 = [1] of {int};
	run testCloseWithBlockingRead282(child_testCloseWithBlockingRead2820);
	run receiver(child_testCloseWithBlockingRead2820)
stop_process:skip
}

proctype testCloseWithBlockingRead282(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestCloseWithBlockingRead3043041 = [1] of {int};
	chan child_AnonymoustestCloseWithBlockingRead2902900 = [1] of {int};
	Wgdef wg;
	Chandef c2_ch;
	Chandef c1_ch;
	run sync_monitor(c1_ch);
	run sync_monitor(c2_ch);
	run wgMonitor(wg);
	wg.update!1;
	run AnonymoustestCloseWithBlockingRead290290(c1_ch,c2_ch,wg,child_AnonymoustestCloseWithBlockingRead2902900);
	run receiver(child_AnonymoustestCloseWithBlockingRead2902900);
	wg.update!1;
	run AnonymoustestCloseWithBlockingRead304304(c2_ch,c1_ch,wg,child_AnonymoustestCloseWithBlockingRead3043041);
	run receiver(child_AnonymoustestCloseWithBlockingRead3043041);
	

	if
	:: 0 != -2 && ub_for320_2 != -2 -> 
				for(i : 0.. ub_for320_2) {
			for12: skip;
			do
			:: c1_ch.deq?state,num_msgs -> 
				break
			:: c1_ch.sync?state -> 
				c1_ch.rcving!false;
				break
			:: c2_ch.deq?state,num_msgs -> 
				break
			:: c2_ch.sync?state -> 
				c2_ch.rcving!false;
				break
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				break
			od;
			for13_exit: skip;
			for13_end: skip;
			for12_end: skip
		};
		for12_exit: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: c1_ch.deq?state,num_msgs -> 
				break
			:: c1_ch.sync?state -> 
				c1_ch.rcving!false;
				break
			:: c2_ch.deq?state,num_msgs -> 
				break
			:: c2_ch.sync?state -> 
				c2_ch.rcving!false;
				break
			:: true -> 
				

				if
				:: true;
				:: true;
				:: true;
				:: true;
				fi;
				break
			od;
			for11_exit: skip;
			for11_end: skip;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	wg.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestCloseWithBlockingRead290290(Chandef c_ch;Chandef c2_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_ch.closing!true;
		defer1: skip;
	wg.update!-1;
	stop_process: skip;
	child!0
}
proctype AnonymoustestCloseWithBlockingRead304304(Chandef c_ch;Chandef c1_ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_ch.closing!true;
		defer1: skip;
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

