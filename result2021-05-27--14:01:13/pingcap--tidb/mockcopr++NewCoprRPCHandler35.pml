// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/pingcap/tidb/blob/207ce344cbb044ffb1b2681f1ba320a154979f6d/store/mockstore/mockcopr/rpc_copr.go#L35
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
	chan child_NewCoprRPCHandler350 = [1] of {int};
	run NewCoprRPCHandler35(child_NewCoprRPCHandler350);
	run receiver(child_NewCoprRPCHandler350)
stop_process:skip
}

proctype NewCoprRPCHandler35(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_CheckStreamTimeoutLoop10110 = [1] of {int};
	Chandef done;
	Chandef ch;
	

	if
	:: 1024 > 0 -> 
		ch.size = 1024;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run sync_monitor(done);
	run CheckStreamTimeoutLoop1011(ch,done,child_CheckStreamTimeoutLoop10110);
	run receiver(child_CheckStreamTimeoutLoop10110);
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype CheckStreamTimeoutLoop1011(Chandef ch;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: done.deq?state,num_msgs -> 
			do
			:: true -> 
				for12: skip;
				do
				:: ch.deq?state,num_msgs -> 
					break
				:: ch.sync?state -> 
					ch.rcving!false;
					break
				:: true -> 
					goto drainLoop;
					break
				od;
				for13_exit: skip;
				for12_end: skip
			od;
			for12_exit: skip;
			drainLoop: skip;
			goto stop_process
		:: done.sync?state -> 
			done.rcving!false;
			do
			:: true -> 
				for16: skip;
				do
				:: ch.deq?state,num_msgs -> 
					break
				:: ch.sync?state -> 
					ch.rcving!false;
					break
				:: true -> 
					goto drainLoop;
					break
				od;
				for17_exit: skip;
				for16_end: skip
			od;
			for16_exit: skip;
			drainLoop: skip;
			goto stop_process
		:: ch.deq?state,num_msgs -> 
			break
		:: ch.sync?state -> 
			ch.rcving!false;
			break
		:: true -> 
			break
		od;
		for11_exit: skip;
		for10_end: skip
	od;
	for10_exit: skip;
		stop_process: skip;
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

