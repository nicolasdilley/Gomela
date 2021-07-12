// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob/138d2c9b88d9e3d5adcebf9cb7c356b43d6a9782/net/dial_test.go#L778
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
	chan child_TestDialCancel7780 = [1] of {int};
	run TestDialCancel778(child_TestDialCancel7780);
	run receiver(child_TestDialCancel7780)
stop_process:skip
}

proctype TestDialCancel778(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestDialCancel7977930 = [1] of {int};
	Chandef connc_ch;
	Chandef errc_ch;
	Chandef cancel_ch;
	run sync_monitor(cancel_ch);
	

	if
	:: 1 > 0 -> 
		errc_ch.size = 1;
		run AsyncChan(errc_ch)
	:: else -> 
		run sync_monitor(errc_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		connc_ch.size = 1;
		run AsyncChan(connc_ch)
	:: else -> 
		run sync_monitor(connc_ch)
	fi;
	run AnonymousTestDialCancel797793(cancel_ch,errc_ch,connc_ch,child_AnonymousTestDialCancel7977930);
	run receiver(child_AnonymousTestDialCancel7977930);
	do
	:: true -> 
		for10: skip;
		do
		:: true -> 
			

			if
			:: true -> 
				cancel.closing!true
			:: true;
			fi;
			break
		:: connc_ch.deq?state,num_msgs -> 
			break
		:: connc_ch.sync?state -> 
			connc_ch.rcving!false;
			break
		:: errc_ch.deq?state,num_msgs -> 
			goto stop_process
		:: errc_ch.sync?state -> 
			errc_ch.rcving!false;
			goto stop_process
		od;
		for11_exit: skip;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousTestDialCancel797793(Chandef cancel_ch;Chandef errc_ch;Chandef connc_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errc_ch.enq!0;
		:: errc_ch.sync!false -> 
			errc_ch.sending!false
		fi
	:: true -> 
		

		if
		:: connc_ch.enq!0;
		:: connc_ch.sync!false -> 
			connc_ch.sending!false
		fi
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

