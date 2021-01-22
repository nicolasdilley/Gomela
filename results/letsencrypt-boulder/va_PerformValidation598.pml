#define PerformValidation_remoteVACount  3
#define PerformValidation_rand_Perm38620  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example862129879/va/va.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_processRemoteResults0 = [0] of {int};
	Chandef remoteResults;
	int num_msgs = 0;
	bool state = false;
	int i;
	int remoteVACount = PerformValidation_remoteVACount;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: remoteVACount > 0 -> 
			remoteResults.size = remoteVACount;
			run AsyncChan(remoteResults)
		:: else -> 
			run sync_monitor(remoteResults)
		fi;
		run go_performRemoteValidation(remoteResults)
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				run go_Anonymous2(remoteResults)
			:: true -> 
				

				if
				:: true -> 
					run processRemoteResults(remoteResults,child_processRemoteResults0);
					child_processRemoteResults0?0
				:: true;
				fi
			fi
		fi
	fi;
	goto stop_process
stop_process:skip
}

proctype go_performRemoteValidation(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int rand_Perm38620 = PerformValidation_rand_Perm38620;
		for(i : 0.. rand_Perm38620-1) {
		for10: skip;
		run go_Anonymous1(results);
		for10_end: skip
	};
	for10_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: results.async_send!0;
	:: results.sync!false,0 -> 
		results.sending?state
	fi;
	stop_process: skip
}
proctype go_Anonymous2(Chandef remoteResults) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_processRemoteResults0 = [0] of {int};
	run processRemoteResults(remoteResults,child_processRemoteResults0);
	child_processRemoteResults0?0;
	stop_process: skip
}
proctype processRemoteResults(Chandef remoteResultsChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: remoteResultsChan.async_rcv?state,num_msgs;
		:: remoteResultsChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				

				if
				:: true -> 
					goto stop_process
				:: true -> 
					

					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				fi
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	

	if
	:: true -> 
		goto stop_process
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;  // sending channel is open
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
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

