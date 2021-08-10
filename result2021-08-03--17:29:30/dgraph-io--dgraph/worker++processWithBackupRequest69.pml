// num_comm_params=1
// num_mand_comm_params=1
// num_opt_comm_params=0

// git_link=https://github.com/dgraph-io/dgraph/blob/6b188f254202f9c38b16c4769b672dd0e9d596ac/worker/task.go#L69
#define def_var_addrs86  ?? // mand addrs line 86
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
	chan child_processWithBackupRequest690 = [1] of {int};
	run processWithBackupRequest69(child_processWithBackupRequest690);
	run receiver(child_processWithBackupRequest690)
stop_process:skip
}

proctype processWithBackupRequest69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousprocessWithBackupRequest102861 = [1] of {int};
	chan child_AnonymousprocessWithBackupRequest90860 = [1] of {int};
	Chandef chResults_ch;
	int var_addrs = def_var_addrs86; // mand var_addrs
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: var_addrs > 0 -> 
		chResults_ch.size = var_addrs;
		run AsyncChan(chResults_ch)
	:: else -> 
		run sync_monitor(chResults_ch)
	fi;
	run AnonymousprocessWithBackupRequest9086(chResults_ch,child_AnonymousprocessWithBackupRequest90860);
	run receiver(child_AnonymousprocessWithBackupRequest90860);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		run AnonymousprocessWithBackupRequest10286(chResults_ch,child_AnonymousprocessWithBackupRequest102861);
		run receiver(child_AnonymousprocessWithBackupRequest102861);
		do
		:: true -> 
			goto stop_process
		:: chResults_ch.deq?state,num_msgs -> 
			

			if
			:: true -> 
				do
				:: true -> 
					goto stop_process
				:: chResults_ch.deq?state,num_msgs -> 
					goto stop_process
				:: chResults_ch.sync?state -> 
					chResults_ch.rcving!false;
					goto stop_process
				od;
				for30_exit: skip;
				for30_end: skip
			:: true -> 
				goto stop_process
			fi;
			break
		:: chResults_ch.sync?state -> 
			chResults_ch.rcving!false;
			

			if
			:: true -> 
				do
				:: true -> 
					goto stop_process
				:: chResults_ch.deq?state,num_msgs -> 
					goto stop_process
				:: chResults_ch.sync?state -> 
					chResults_ch.rcving!false;
					goto stop_process
				od;
				for40_exit: skip;
				for40_end: skip
			:: true -> 
				goto stop_process
			fi;
			break
		od;
		for20_exit: skip;
		for20_end: skip;
		break
	:: chResults_ch.deq?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: chResults_ch.sync?state -> 
		chResults_ch.rcving!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	od;
	for10_exit: skip;
	for10_end: skip;
	stop_process: skip;
	child!0
}
proctype AnonymousprocessWithBackupRequest9086(Chandef chResults_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chResults_ch.enq!0;
	:: chResults_ch.sync!false -> 
		chResults_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousprocessWithBackupRequest10286(Chandef chResults_ch;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chResults_ch.enq!0;
	:: chResults_ch.sync!false -> 
		chResults_ch.sending!false
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

