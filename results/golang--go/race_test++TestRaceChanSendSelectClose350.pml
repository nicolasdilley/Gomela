// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/golang/go/blob//runtime/race/testdata/chan_test.go#L350
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
	chan child_TestRaceChanSendSelectClose3500 = [1] of {int};
	run TestRaceChanSendSelectClose350(child_TestRaceChanSendSelectClose3500);
	run receiver(child_TestRaceChanSendSelectClose3500)
stop_process:skip
}

proctype TestRaceChanSendSelectClose350(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTestRaceChanSendSelectClose3653511 = [1] of {int};
	chan child_AnonymousTestRaceChanSendSelectClose3543520 = [1] of {int};
	Chandef c1_ch;
	Chandef c_ch;
	Chandef compl_ch;
	

	if
	:: 2 > 0 -> 
		compl_ch.size = 2;
		run AsyncChan(compl_ch)
	:: else -> 
		run sync_monitor(compl_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		c_ch.size = 1;
		run AsyncChan(c_ch)
	:: else -> 
		run sync_monitor(c_ch)
	fi;
	run sync_monitor(c1_ch);
	run AnonymousTestRaceChanSendSelectClose354352(c_ch,c1_ch,compl_ch,child_AnonymousTestRaceChanSendSelectClose3543520);
	run receiver(child_AnonymousTestRaceChanSendSelectClose3543520);
	run AnonymousTestRaceChanSendSelectClose365351(compl_ch,c_ch,c1_ch,child_AnonymousTestRaceChanSendSelectClose3653511);
	run receiver(child_AnonymousTestRaceChanSendSelectClose3653511);
	

	if
	:: compl_ch.deq?state,num_msgs;
	:: compl_ch.sync?state -> 
		compl_ch.rcving!false
	fi;
	

	if
	:: compl_ch.deq?state,num_msgs;
	:: compl_ch.sync?state -> 
		compl_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceChanSendSelectClose354352(Chandef c_ch;Chandef c1_ch;Chandef compl_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: c_ch.enq!0 -> 
		break
	:: c_ch.sync!false -> 
		c_ch.sending!false;
		break
	:: c1_ch.deq?state,num_msgs -> 
		break
	:: c1_ch.sync?state -> 
		c1_ch.rcving!false;
		break
	od;
	for10_exit: skip;
	for10_end: skip;
		defer1: skip;
	

	if
	:: compl_ch.enq!0;
	:: compl_ch.sync!false -> 
		compl_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestRaceChanSendSelectClose365351(Chandef compl_ch;Chandef c_ch;Chandef c1_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	c_ch.closing!true;
	

	if
	:: compl_ch.enq!0;
	:: compl_ch.sync!false -> 
		compl_ch.sending!false
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
