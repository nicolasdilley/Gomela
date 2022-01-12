// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/go-redis/redis/blob//main_test.go#L196
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
	chan child_eventually1960 = [1] of {int};
	run eventually196(child_eventually1960);
	run receiver(child_eventually1960)
stop_process:skip
}

proctype eventually196(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymouseventually2011970 = [1] of {int};
	Chandef exit_ch;
	Chandef done_ch;
	Chandef errCh_ch;
	

	if
	:: 1 > 0 -> 
		errCh_ch.size = 1;
		run AsyncChan(errCh_ch)
	:: else -> 
		run sync_monitor(errCh_ch)
	fi;
	run sync_monitor(done_ch);
	run sync_monitor(exit_ch);
	run Anonymouseventually201197(errCh_ch,done_ch,exit_ch,child_Anonymouseventually2011970);
	run receiver(child_Anonymouseventually2011970);
	do
	:: done_ch.deq?state,num_msgs -> 
		goto stop_process
	:: done_ch.sync?state -> 
		done_ch.rcving!false;
		goto stop_process
	:: true -> 
		exit_ch.closing!true;
		do
		:: errCh_ch.deq?state,num_msgs -> 
			goto stop_process
		:: errCh_ch.sync?state -> 
			errCh_ch.rcving!false;
			goto stop_process
		:: true -> 
			goto stop_process
		od;
		for30_exit: skip;
		for30_end: skip;
		break
	od;
	for20_exit: skip;
	for20_end: skip;
	stop_process: skip;
	child!0
}
proctype Anonymouseventually201197(Chandef errCh_ch;Chandef done_ch;Chandef exit_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			done_ch.closing!true;
			goto stop_process
		:: true;
		fi;
		do
		:: errCh_ch.enq!0 -> 
			break
		:: errCh_ch.sync!false -> 
			errCh_ch.sending!false;
			break
		:: true -> 
			break
		od;
		for11_exit: skip;
		for11_end: skip;
		do
		:: exit_ch.deq?state,num_msgs -> 
			goto stop_process
		:: exit_ch.sync?state -> 
			exit_ch.rcving!false;
			goto stop_process
		:: true -> 
			break
		od;
		for12_exit: skip;
		for12_end: skip;
		for10_end: skip
	od;
	for10_exit: skip;
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

