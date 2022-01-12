// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/drone/drone/blob//livelog/sub_test.go#L59
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
	chan child_TestSubscription_stop590 = [1] of {int};
	run TestSubscription_stop59(child_TestSubscription_stop590);
	run receiver(child_TestSubscription_stop590)
stop_process:skip
}

proctype TestSubscription_stop59(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_publish315 = [1] of {int};
	chan child_publish314 = [1] of {int};
	chan child_publish313 = [1] of {int};
	chan child_publish312 = [1] of {int};
	chan child_publish311 = [1] of {int};
	chan child_close430 = [1] of {int};
	Chandef s_closec_ch;
	Chandef s_handler_ch;
	

	if
	:: 1 > 0 -> 
		s_handler_ch.size = 1;
		run AsyncChan(s_handler_ch)
	:: else -> 
		run sync_monitor(s_handler_ch)
	fi;
	run sync_monitor(s_closec_ch);
	run close43(s_closec_ch,s_handler_ch,child_close430);
	child_close430?0;
	run publish31(s_closec_ch,s_handler_ch,child_publish311);
	child_publish311?0;
	run publish31(s_closec_ch,s_handler_ch,child_publish312);
	child_publish312?0;
	run publish31(s_closec_ch,s_handler_ch,child_publish313);
	child_publish313?0;
	run publish31(s_closec_ch,s_handler_ch,child_publish314);
	child_publish314?0;
	run publish31(s_closec_ch,s_handler_ch,child_publish315);
	child_publish315?0;
	stop_process: skip;
	child!0
}
proctype close43(Chandef s_closec_ch;Chandef s_handler_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		s_closec_ch.closing!true
	:: true;
	fi;
	stop_process: skip;
	child!0
}
proctype publish31(Chandef s_closec_ch;Chandef s_handler_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: s_closec_ch.deq?state,num_msgs -> 
		break
	:: s_closec_ch.sync?state -> 
		s_closec_ch.rcving!false;
		break
	:: s_handler_ch.enq!0 -> 
		break
	:: s_handler_ch.sync!false -> 
		s_handler_ch.sending!false;
		break
	:: true -> 
		break
	od;
	for10_exit: skip;
	for10_end: skip;
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

