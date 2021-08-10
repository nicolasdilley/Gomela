// num_comm_params=0
// num_mand_comm_params=0
// num_opt_comm_params=0

// git_link=https://github.com/hashicorp/packer/blob/a9c2283ee589b203c0ce16174a5747b7d2053d61/builder/digitalocean/step_shutdown.go#L16
#define ub_for52_3  -2
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
	chan child_Run160 = [1] of {int};
	run Run16(child_Run160);
	run receiver(child_Run160)
stop_process:skip
}

proctype Run16(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousRun49370 = [1] of {int};
	Chandef shutdownRetryDone_ch;
	Chandef done_ch;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(done_ch);
	run sync_monitor(shutdownRetryDone_ch);
	run AnonymousRun4937(done_ch,shutdownRetryDone_ch,child_AnonymousRun49370);
	run receiver(child_AnonymousRun49370);
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	

	if
	:: true -> 
		goto defer1
	:: true;
	fi;
	goto defer1;
		defer1: skip;
	done_ch.closing!true;
	

	if
	:: shutdownRetryDone_ch.deq?state,num_msgs;
	:: shutdownRetryDone_ch.sync?state -> 
		shutdownRetryDone_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousRun4937(Chandef done_ch;Chandef shutdownRetryDone_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: 0 != -2 && ub_for52_3 != -2 -> 
				for(i : 0.. ub_for52_3) {
			for12: skip;
			do
			:: done_ch.deq?state,num_msgs -> 
				goto defer1
			:: done_ch.sync?state -> 
				done_ch.rcving!false;
				goto defer1
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
			:: done_ch.deq?state,num_msgs -> 
				goto defer1
			:: done_ch.sync?state -> 
				done_ch.rcving!false;
				goto defer1
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
		defer1: skip;
	shutdownRetryDone_ch.closing!true;
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

