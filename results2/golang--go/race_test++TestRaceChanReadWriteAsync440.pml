// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/chan_test.go#L440
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
	chan child_TestRaceChanReadWriteAsync4400 = [1] of {int};
	run TestRaceChanReadWriteAsync440(child_TestRaceChanReadWriteAsync4400);
	run receiver(child_TestRaceChanReadWriteAsync4400)
stop_process:skip
}

proctype TestRaceChanReadWriteAsync440(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaceChanReadWriteAsync4464420 = [1] of {int};
	Chandef c2;
	Chandef c1;
	Chandef done;
	run sync_monitor(done);
	

	if
	:: 10 > 0 -> 
		c1.size = 10;
		run AsyncChan(c1)
	:: else -> 
		run sync_monitor(c1)
	fi;
	

	if
	:: 10 > 0 -> 
		c2.size = 10;
		run AsyncChan(c2)
	:: else -> 
		run sync_monitor(c2)
	fi;
	

	if
	:: c2.enq!0;
	:: c2.sync!false -> 
		c2.sending!false
	fi;
	run AnonymousTestRaceChanReadWriteAsync446442(c1,c2,done,child_AnonymousTestRaceChanReadWriteAsync4464420);
	run receiver(child_AnonymousTestRaceChanReadWriteAsync4464420);
	

	if
	:: c2.deq?state,num_msgs;
	:: c2.sync?state -> 
		c2.rcving!false
	fi;
	

	if
	:: done.deq?state,num_msgs;
	:: done.sync?state -> 
		done.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceChanReadWriteAsync446442(Chandef c1;Chandef c2;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c1.enq!0;
	:: c1.sync!false -> 
		c1.sending!false
	fi;
	

	if
	:: done.enq!0;
	:: done.sync!false -> 
		done.sending!false
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

