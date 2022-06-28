// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hyperledger/fabric/blob//gossip/state/state_test.go#L1747
#define ub_for1753_3  -2
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
	chan child_waitUntilTrueOrTimeout17470 = [1] of {int};
	run waitUntilTrueOrTimeout1747(child_waitUntilTrueOrTimeout17470);
	run receiver(child_waitUntilTrueOrTimeout17470)
stop_process:skip
}

proctype waitUntilTrueOrTimeout1747(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouswaitUntilTrueOrTimeout175117480 = [1] of {int};
	Chandef ch_ch;
	run sync_monitor(ch_ch);
	run AnonymouswaitUntilTrueOrTimeout17511748(ch_ch,child_AnonymouswaitUntilTrueOrTimeout175117480);
	run receiver(child_AnonymouswaitUntilTrueOrTimeout175117480);
	do
	:: ch_ch.deq?state,num_msgs -> 
		goto for20_exit
	:: ch_ch.sync?state -> 
		ch_ch.rcving!false;
		goto for20_exit
	:: true -> 
		ch_ch.closing!true;
		goto for20_exit
	od;
	for20_exit: skip;
	for20_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymouswaitUntilTrueOrTimeout17511748(Chandef ch_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for1753_3 != -2 -> 
				for(i : 0.. ub_for1753_3) {
			for12: skip;
			do
			:: ch_ch.deq?state,num_msgs -> 
				goto stop_process
			:: ch_ch.sync?state -> 
				ch_ch.rcving!false;
				goto stop_process
			:: true -> 
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
			:: ch_ch.deq?state,num_msgs -> 
				goto stop_process
			:: ch_ch.sync?state -> 
				ch_ch.rcving!false;
				goto stop_process
			:: true -> 
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
	ch_ch.closing!true;
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
