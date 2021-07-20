// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/vault/blob/f8f289712a3d37115090591602a2b92503fb3a13/vault/diagnose/storage_checks.go#L28
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
	chan child_StorageEndToEndLatencyCheck280 = [1] of {int};
	run StorageEndToEndLatencyCheck28(child_StorageEndToEndLatencyCheck280);
	run receiver(child_StorageEndToEndLatencyCheck280)
stop_process:skip
}

proctype StorageEndToEndLatencyCheck28(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousStorageEndToEndLatencyCheck66302 = [1] of {int};
	Chandef c5_ch;
	chan child_AnonymousStorageEndToEndLatencyCheck46301 = [1] of {int};
	Chandef c4_ch;
	Chandef c3_ch;
	chan child_AnonymousStorageEndToEndLatencyCheck31300 = [1] of {int};
	Chandef c2_ch;
	run sync_monitor(c2_ch);
	run AnonymousStorageEndToEndLatencyCheck3130(c2_ch,child_AnonymousStorageEndToEndLatencyCheck31300);
	run receiver(child_AnonymousStorageEndToEndLatencyCheck31300);
	do
	:: c2_ch.deq?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: c2_ch.sync?state -> 
		c2_ch.rcving!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	run sync_monitor(c3_ch);
	run sync_monitor(c4_ch);
	run AnonymousStorageEndToEndLatencyCheck4630(c2_ch,c3_ch,c4_ch,child_AnonymousStorageEndToEndLatencyCheck46301);
	run receiver(child_AnonymousStorageEndToEndLatencyCheck46301);
	do
	:: c4_ch.deq?state,num_msgs -> 
		goto stop_process
	:: c4_ch.sync?state -> 
		c4_ch.rcving!false;
		goto stop_process
	:: c3_ch.deq?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: c3_ch.sync?state -> 
		c3_ch.rcving!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		goto stop_process
	od;
	for20_exit: skip;
	for20_end: skip;
	run sync_monitor(c5_ch);
	run AnonymousStorageEndToEndLatencyCheck6630(c2_ch,c3_ch,c4_ch,c5_ch,child_AnonymousStorageEndToEndLatencyCheck66302);
	run receiver(child_AnonymousStorageEndToEndLatencyCheck66302);
	do
	:: c5_ch.deq?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: c5_ch.sync?state -> 
		c5_ch.rcving!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		break
	:: true -> 
		goto stop_process
	od;
	for30_exit: skip;
	for30_end: skip;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype AnonymousStorageEndToEndLatencyCheck3130(Chandef c2_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c2_ch.enq!0;
	:: c2_ch.sync!false -> 
		c2_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousStorageEndToEndLatencyCheck4630(Chandef c2_ch;Chandef c3_ch;Chandef c4_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: c4_ch.enq!0;
		:: c4_ch.sync!false -> 
			c4_ch.sending!false
		fi
	:: true -> 
		

		if
		:: c3_ch.enq!0;
		:: c3_ch.sync!false -> 
			c3_ch.sending!false
		fi
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousStorageEndToEndLatencyCheck6630(Chandef c2_ch;Chandef c3_ch;Chandef c4_ch;Chandef c5_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: c5_ch.enq!0;
	:: c5_ch.sync!false -> 
		c5_ch.sending!false
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

