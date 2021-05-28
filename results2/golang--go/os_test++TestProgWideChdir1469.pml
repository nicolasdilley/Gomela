// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/os/os_test.go#L1469
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



init { 
	chan child_TestProgWideChdir14690 = [1] of {int};
	run TestProgWideChdir1469(child_TestProgWideChdir14690);
	run receiver(child_TestProgWideChdir14690)
stop_process:skip
}

proctype TestProgWideChdir1469(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestProgWideChdir147514750 = [1] of {int};
	Chandef cpwd;
	Chandef c;
	run sync_monitor(c);
	

	if
	:: 10 > 0 -> 
		cpwd.size = 10;
		run AsyncChan(cpwd)
	:: else -> 
		run sync_monitor(cpwd)
	fi;
		for(i : 0.. 10-1) {
		for10: skip;
		run AnonymousTestProgWideChdir14751475(c,cpwd,child_AnonymousTestProgWideChdir147514750);
		run receiver(child_AnonymousTestProgWideChdir147514750);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: true -> 
		

		if
		:: c.enq!0;
		:: c.sync!false -> 
			c.sending!false
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: c.enq!0;
		:: c.sync!false -> 
			c.sending!false
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: c.enq!0;
		:: c.sync!false -> 
			c.sending!false
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: c.enq!0;
		:: c.sync!false -> 
			c.sending!false
		fi
	:: true;
	fi;
	c.closing!true;
	

	if
	:: 0 != -2 && 10-1 != -3 -> 
				for(i : 0.. 10-1) {
			for21: skip;
			

			if
			:: cpwd.deq?state,num_msgs;
			:: cpwd.sync?state -> 
				cpwd.rcving!false
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: cpwd.deq?state,num_msgs;
			:: cpwd.sync?state -> 
				cpwd.rcving!false
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
		stop_process: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestProgWideChdir14751475(Chandef c;Chandef cpwd;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c.deq?state,num_msgs;
	:: c.sync?state -> 
		c.rcving!false
	fi;
	

	if
	:: true -> 
		

		if
		:: cpwd.enq!0;
		:: cpwd.sync!false -> 
			cpwd.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: cpwd.enq!0;
		:: cpwd.sync!false -> 
			cpwd.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: cpwd.enq!0;
	:: cpwd.sync!false -> 
		cpwd.sending!false
	fi;
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

proctype receiver(chan c) {
c?0
}

