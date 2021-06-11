// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/builder/digitalocean/wait.go#L63
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
	chan child_waitForDropletState630 = [1] of {int};
	run waitForDropletState63(child_waitForDropletState630);
	run receiver(child_waitForDropletState630)
stop_process:skip
}

proctype waitForDropletState63(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymouswaitForDropletState70660 = [1] of {int};
	Chandef result;
	Chandef done;
	run sync_monitor(done);
	

	if
	:: 1 > 0 -> 
		result.size = 1;
		run AsyncChan(result)
	:: else -> 
		run sync_monitor(result)
	fi;
	run AnonymouswaitForDropletState7066(done,result,child_AnonymouswaitForDropletState70660);
	run receiver(child_AnonymouswaitForDropletState70660);
	do
	:: result.deq?state,num_msgs -> 
		goto defer1
	:: result.sync?state -> 
		result.rcving!false;
		goto defer1
	:: true -> 
		goto defer1
	od;
	for20_exit: skip;
		defer1: skip;
	done.closing!true;
	stop_process: skip;
	child!0
}
proctype AnonymouswaitForDropletState7066(Chandef done;Chandef result;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			

			if
			:: result.enq!0;
			:: result.sync!false -> 
				result.sending!false
			fi;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: result.enq!0;
			:: result.sync!false -> 
				result.sending!false
			fi;
			goto stop_process
		:: true;
		fi;
		do
		:: done.deq?state,num_msgs -> 
			goto stop_process
		:: done.sync?state -> 
			done.rcving!false;
			goto stop_process
		:: true -> 
			break
		od;
		for11_exit: skip;
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

