// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/runtime/chan_test.go#L682
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
	chan child_TestSelectDuplicateChannel6820 = [1] of {int};
	run TestSelectDuplicateChannel682(child_TestSelectDuplicateChannel6820);
	run receiver(child_TestSelectDuplicateChannel6820)
stop_process:skip
}

proctype TestSelectDuplicateChannel682(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestSelectDuplicateChannel7016851 = [1] of {int};
	chan child_AnonymousTestSelectDuplicateChannel6906850 = [1] of {int};
	Chandef e;
	Chandef d;
	Chandef c;
	run sync_monitor(c);
	run sync_monitor(d);
	run sync_monitor(e);
	run AnonymousTestSelectDuplicateChannel690685(c,d,e,child_AnonymousTestSelectDuplicateChannel6906850);
	run receiver(child_AnonymousTestSelectDuplicateChannel6906850);
	run AnonymousTestSelectDuplicateChannel701685(c,d,e,child_AnonymousTestSelectDuplicateChannel7016851);
	run receiver(child_AnonymousTestSelectDuplicateChannel7016851);
	

	if
	:: d.enq!0;
	:: d.sync!false -> 
		d.sending!false
	fi;
	

	if
	:: e.deq?state,num_msgs;
	:: e.sync?state -> 
		e.rcving!false
	fi;
	

	if
	:: c.enq!0;
	:: c.sync!false -> 
		c.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSelectDuplicateChannel690685(Chandef c;Chandef d;Chandef e;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: c.deq?state,num_msgs -> 
		break
	:: c.sync?state -> 
		c.rcving!false;
		break
	:: c.deq?state,num_msgs -> 
		break
	:: c.sync?state -> 
		c.rcving!false;
		break
	:: d.deq?state,num_msgs -> 
		break
	:: d.sync?state -> 
		d.rcving!false;
		break
	od;
	for10_exit: skip;
	

	if
	:: e.enq!0;
	:: e.sync!false -> 
		e.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSelectDuplicateChannel701685(Chandef c;Chandef d;Chandef e;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c.deq?state,num_msgs;
	:: c.sync?state -> 
		c.rcving!false
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

