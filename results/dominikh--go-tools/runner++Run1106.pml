
// https://github.com/dominikh/go-tools/blob/c5ce990a4e39053fda5229d7ac0877c5d78dd84d/lintcmd/runner/runner.go#L1106
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
	Chandef queue;
	int num_msgs = 0;
	bool state = false;
	int i;
	int all=0;
	

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
	run sync_monitor(queue);
	run go_Anonymous0(queue,all);
	do
	:: true -> 
		

		if
		:: queue.async_rcv?state,num_msgs;
		:: queue.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for50: skip;
			run go_genericHandle(queue);
			for50_end: skip
		fi
	od;
	for50_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef queue;int all) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: all-1 != -3 -> 
				for(i : 0.. all-1) {
			for40: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!false,0 -> 
					queue.sending?state
				fi
			:: true;
			fi;
			for40_end: skip
		};
		for40_exit: skip
	:: else -> 
		do
		:: true -> 
			for40478: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!false,0 -> 
					queue.sending?state
				fi
			:: true;
			fi;
			for40_end478: skip
		:: true -> 
			break
		od;
		for40_exit478: skip
	fi;
	stop_process: skip
}
proctype go_genericHandle(Chandef queue) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int a_Triggers77220=0;
	

	if
	:: true -> 
		queue.closing!true;
		goto stop_process
	:: true;
	fi;
	

	if
	:: a_Triggers77220-1 != -3 -> 
				for(i : 0.. a_Triggers77220-1) {
			for51: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!false,0 -> 
					queue.sending?state
				fi
			:: true;
			fi;
			for51_end: skip
		};
		for51_exit: skip
	:: else -> 
		do
		:: true -> 
			for51479: skip;
			

			if
			:: true -> 
				

				if
				:: queue.async_send!0;
				:: queue.sync!false,0 -> 
					queue.sending?state
				fi
			:: true;
			fi;
			for51_end479: skip
		:: true -> 
			break
		od;
		for51_exit479: skip
	fi;
	stop_process: skip
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


