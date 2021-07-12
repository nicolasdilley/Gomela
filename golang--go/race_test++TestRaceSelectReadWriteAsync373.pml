// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/race/testdata/chan_test.go#L373
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
	chan child_TestRaceSelectReadWriteAsync3730 = [1] of {int};
	run TestRaceSelectReadWriteAsync373(child_TestRaceSelectReadWriteAsync3730);
	run receiver(child_TestRaceSelectReadWriteAsync3730)
stop_process:skip
}

proctype TestRaceSelectReadWriteAsync373(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaceSelectReadWriteAsync3803740 = [1] of {int};
	Chandef c3_ch;
	Chandef c2_ch;
	Chandef c1_ch;
	Chandef done_ch;
	run sync_monitor(done_ch);
	

	if
	:: 10 > 0 -> 
		c1_ch.size = 10;
		run AsyncChan(c1_ch)
	:: else -> 
		run sync_monitor(c1_ch)
	fi;
	

	if
	:: 10 > 0 -> 
		c2_ch.size = 10;
		run AsyncChan(c2_ch)
	:: else -> 
		run sync_monitor(c2_ch)
	fi;
	run sync_monitor(c3_ch);
	

	if
	:: c2_ch.enq!0;
	:: c2_ch.sync!false -> 
		c2_ch.sending!false
	fi;
	run AnonymousTestRaceSelectReadWriteAsync380374(done_ch,c1_ch,c2_ch,c3_ch,child_AnonymousTestRaceSelectReadWriteAsync3803740);
	run receiver(child_AnonymousTestRaceSelectReadWriteAsync3803740);
	do
	:: c2_ch.deq?state,num_msgs -> 
		break
	:: c2_ch.sync?state -> 
		c2_ch.rcving!false;
		break
	:: c3_ch.enq!0 -> 
		break
	:: c3_ch.sync!false -> 
		c3_ch.sending!false;
		break
	od;
	for20_exit: skip;
	

	if
	:: done_ch.deq?state,num_msgs;
	:: done_ch.sync?state -> 
		done_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceSelectReadWriteAsync380374(Chandef done_ch;Chandef c1_ch;Chandef c2_ch;Chandef c3_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: c1_ch.enq!0 -> 
		break
	:: c1_ch.sync!false -> 
		c1_ch.sending!false;
		break
	:: c3_ch.enq!0 -> 
		break
	:: c3_ch.sync!false -> 
		c3_ch.sending!false;
		break
	od;
	for10_exit: skip;
	

	if
	:: done_ch.enq!0;
	:: done_ch.sync!false -> 
		done_ch.sending!false
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

