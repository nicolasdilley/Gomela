// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/grpc/grpc-go/blob//xds/internal/client/requests_counter_test.go#L58
#define def_var_test_numRequests61  ?? // mand test.numRequests line 61
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
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_testCounter580 = [1] of {int};
	run testCounter58(child_testCounter580);
	run receiver(child_testCounter580)
stop_process:skip
}

proctype testCounter58(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymoustestCounter67590 = [1] of {int};
	Wgdef requestsDone;
	Wgdef requestsSent;
	Chandef requestsStarted_ch;
	int var_test_numRequests = def_var_test_numRequests61; // mand var_test_numRequests
	run sync_monitor(requestsStarted_ch);
	run wgMonitor(requestsSent);
	requestsSent.update!var_test_numRequests;
	run wgMonitor(requestsDone);
	requestsDone.update!var_test_numRequests;
		for(i : 0.. var_test_numRequests-1) {
		for10: skip;
		run AnonymoustestCounter6759(requestsStarted_ch,requestsSent,requestsDone,child_AnonymoustestCounter67590);
		run receiver(child_AnonymoustestCounter67590);
		for10_end: skip
	};
	for10_exit: skip;
	requestsSent.wait?0;
	requestsStarted_ch.closing!true;
	requestsDone.wait?0;
	stop_process: skip;
	child!0
}
proctype AnonymoustestCounter6759(Chandef requestsStarted_ch;Wgdef requestsSent;Wgdef requestsDone;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	requestsSent.update!-1;
	

	if
	:: true -> 
		

		if
		:: requestsStarted_ch.deq?state,num_msgs;
		:: requestsStarted_ch.sync?state -> 
			requestsStarted_ch.rcving!false
		fi
	:: true;
	fi;
		defer1: skip;
	requestsDone.update!-1;
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

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

