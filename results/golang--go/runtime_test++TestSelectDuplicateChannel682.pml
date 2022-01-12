// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/chan_test.go#L682
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
	chan child_AnonymousTestSelectDuplicateChannel7016871 = [1] of {int};
	chan child_AnonymousTestSelectDuplicateChannel6906860 = [1] of {int};
	Chandef e_ch;
	Chandef d_ch;
	Chandef c_ch;
	run sync_monitor(c_ch);
	run sync_monitor(d_ch);
	run sync_monitor(e_ch);
	run AnonymousTestSelectDuplicateChannel690686(d_ch,e_ch,c_ch,child_AnonymousTestSelectDuplicateChannel6906860);
	run receiver(child_AnonymousTestSelectDuplicateChannel6906860);
	run AnonymousTestSelectDuplicateChannel701687(e_ch,c_ch,d_ch,child_AnonymousTestSelectDuplicateChannel7016871);
	run receiver(child_AnonymousTestSelectDuplicateChannel7016871);
	

	if
	:: d_ch.enq!0;
	:: d_ch.sync!false -> 
		d_ch.sending!false
	fi;
	

	if
	:: e_ch.deq?state,num_msgs;
	:: e_ch.sync?state -> 
		e_ch.rcving!false
	fi;
	

	if
	:: c_ch.enq!0;
	:: c_ch.sync!false -> 
		c_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSelectDuplicateChannel690686(Chandef d_ch;Chandef e_ch;Chandef c_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: c_ch.deq?state,num_msgs -> 
		break
	:: c_ch.sync?state -> 
		c_ch.rcving!false;
		break
	:: c_ch.deq?state,num_msgs -> 
		break
	:: c_ch.sync?state -> 
		c_ch.rcving!false;
		break
	:: d_ch.deq?state,num_msgs -> 
		break
	:: d_ch.sync?state -> 
		d_ch.rcving!false;
		break
	od;
	for10_exit: skip;
	for10_end: skip;
	

	if
	:: e_ch.enq!0;
	:: e_ch.sync!false -> 
		e_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestSelectDuplicateChannel701687(Chandef e_ch;Chandef c_ch;Chandef d_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c_ch.deq?state,num_msgs;
	:: c_ch.sync?state -> 
		c_ch.rcving!false
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

