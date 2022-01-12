// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/gravitational/teleport/blob//lib/client/client.go#L1383
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
	chan child_acceptWithContext13830 = [1] of {int};
	run acceptWithContext1383(child_acceptWithContext13830);
	run receiver(child_acceptWithContext13830)
stop_process:skip
}

proctype acceptWithContext1383(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousacceptWithContext138713840 = [1] of {int};
	Chandef errorCh_ch;
	Chandef acceptCh_ch;
	

	if
	:: 1 > 0 -> 
		acceptCh_ch.size = 1;
		run AsyncChan(acceptCh_ch)
	:: else -> 
		run sync_monitor(acceptCh_ch)
	fi;
	

	if
	:: 1 > 0 -> 
		errorCh_ch.size = 1;
		run AsyncChan(errorCh_ch)
	:: else -> 
		run sync_monitor(errorCh_ch)
	fi;
	run AnonymousacceptWithContext13871384(acceptCh_ch,errorCh_ch,child_AnonymousacceptWithContext138713840);
	run receiver(child_AnonymousacceptWithContext138713840);
	do
	:: acceptCh_ch.deq?state,num_msgs -> 
		goto stop_process
	:: acceptCh_ch.sync?state -> 
		acceptCh_ch.rcving!false;
		goto stop_process
	:: errorCh_ch.deq?state,num_msgs -> 
		goto stop_process
	:: errorCh_ch.sync?state -> 
		errorCh_ch.rcving!false;
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousacceptWithContext13871384(Chandef acceptCh_ch;Chandef errorCh_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: errorCh_ch.enq!0;
		:: errorCh_ch.sync!false -> 
			errorCh_ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: acceptCh_ch.enq!0;
	:: acceptCh_ch.sync!false -> 
		acceptCh_ch.sending!false
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

