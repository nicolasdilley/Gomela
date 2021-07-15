
// https://github.com/stretchr/testify/blob/master/mock/mock_test.go#L1411
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
	chan child_Test_WaitUntil_Parallel14110 = [1] of {int};
	run Test_WaitUntil_Parallel1411(child_Test_WaitUntil_Parallel14110)
stop_process:skip
}

proctype Test_WaitUntil_Parallel1411(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousTest_WaitUntil_Parallel142914162 = [1] of {int};
	chan child_AnonymousTest_WaitUntil_Parallel142614171 = [1] of {int};
	chan child_WaitUntil1500 = [1] of {int};
	Chandef ch2;
	Chandef ch1;
	run sync_monitor(ch1);
	run sync_monitor(ch2);
	run WaitUntil150(ch1,child_WaitUntil1500);
	child_WaitUntil1500?0;
	run AnonymousTest_WaitUntil_Parallel14261417(ch2,ch1,child_AnonymousTest_WaitUntil_Parallel142614171);
	run AnonymousTest_WaitUntil_Parallel14291416(ch1,ch2,child_AnonymousTest_WaitUntil_Parallel142914162);
	

	if
	:: ch2.enq!0;
	:: ch2.sync!false -> 
		ch2.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype WaitUntil150(Chandef w;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousTest_WaitUntil_Parallel14261417(Chandef ch2;Chandef ch1;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	child!0
}
proctype AnonymousTest_WaitUntil_Parallel14291416(Chandef ch1;Chandef ch2;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
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

