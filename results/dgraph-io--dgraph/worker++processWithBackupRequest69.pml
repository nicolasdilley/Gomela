#define processWithBackupRequest_addrs  3

// https://github.com/dgraph-io/dgraph/blob/master/worker/task.go#L69
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
	run processWithBackupRequest69(child_processWithBackupRequest690)
stop_process:skip
}

proctype processWithBackupRequest69(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_AnonymousprocessWithBackupRequest102861 = [1] of {int};
	chan child_AnonymousprocessWithBackupRequest90860 = [1] of {int};
	Chandef chResults;
	int addrs = processWithBackupRequest_addrs;
	

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
	:: addrs > 0 -> 
		chResults.size = addrs;
		run AsyncChan(chResults)
	:: else -> 
		run sync_monitor(chResults)
	fi;
	run AnonymousprocessWithBackupRequest9086(chResults,child_AnonymousprocessWithBackupRequest90860);
	do
	:: true -> 
		goto stop_process
	:: true -> 
		run AnonymousprocessWithBackupRequest10286(chResults,child_AnonymousprocessWithBackupRequest102861);
		do
		:: true -> 
			goto stop_process
		:: chResults.deq?state,num_msgs -> 
			

			if
			:: true -> 
				do
				:: true -> 
					goto stop_process
				:: chResults.deq?state,num_msgs -> 
					goto stop_process
				:: chResults.sync?state -> 
					chResults.rcving!false;
					goto stop_process
				od
			:: true -> 
				goto stop_process
			fi;
			break
		:: chResults.sync?state -> 
			chResults.rcving!false;
			

			if
			:: true -> 
				do
				:: true -> 
					goto stop_process
				:: chResults.deq?state,num_msgs -> 
					goto stop_process
				:: chResults.sync?state -> 
					chResults.rcving!false;
					goto stop_process
				od
			:: true -> 
				goto stop_process
			fi;
			break
		od;
		break
	:: chResults.deq?state,num_msgs -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: chResults.sync?state -> 
		chResults.rcving!false;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	od;
	stop_process: skip;
	child!0
}
proctype AnonymousprocessWithBackupRequest9086(Chandef chResults;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chResults.enq!0;
	:: chResults.sync!false -> 
		chResults.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousprocessWithBackupRequest10286(Chandef chResults;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: chResults.enq!0;
	:: chResults.sync!false -> 
		chResults.sending!false
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

