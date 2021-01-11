#define rollingUpdateInstanceGroup_maxConcurrency  3
#define rollingUpdateInstanceGroup_update  1
#define ub_for260_2  -2
#define ub_for209_3  -2
#define ub_for223_4  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example412040895/pkg/instancegroups/instancegroups.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	chan child_instancegroupswaitForPendingBeforeReturningError3 = [0] of {int};
	chan child_instancegroupswaitForPendingBeforeReturningError3 = [0] of {int};
	chan child_instancegroupswaitForPendingBeforeReturningError1 = [0] of {int};
	chan child_instancegroupswaitForPendingBeforeReturningError0 = [0] of {int};
	Chandef terminateChan;
	bool state = false;
	int i;
	int update = rollingUpdateInstanceGroup_update;
	int maxConcurrency = rollingUpdateInstanceGroup_maxConcurrency;
	

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
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: maxConcurrency > 0 -> 
		terminateChan.size = maxConcurrency;
		run AsyncChan(terminateChan)
	:: else -> 
		run sync_monitor(terminateChan)
	fi;
		for(i : 0.. update-1) {
		for20: skip;
		run go_Anonymous0(terminateChan);
		

		if
		:: true -> 
			goto for20_end
		:: true;
		fi;
		

		if
		:: true -> 
			run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError0);
			child_instancegroupswaitForPendingBeforeReturningError0?0;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError1);
			child_instancegroupswaitForPendingBeforeReturningError1?0;
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		sweep: skip;
				

		if
		:: 0 != -2 && ub_for209_3 != -2 -> 
						for(i : 0.. ub_for209_3) {
				for22543: skip;
				do
				:: terminateChan.async_rcv?0 -> 
					

					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: terminateChan.sync?0 -> 
					

					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: true -> 
					goto sweep543
				od;
				for22_end543: skip
			};
			for22_exit543: skip
		:: else -> 
			do
			:: true -> 
				for22: skip;
				do
				:: terminateChan.async_rcv?0 -> 
					

					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: terminateChan.sync?0 -> 
					

					if
					:: true -> 
						chan child_instancegroupswaitForPendingBeforeReturningError2 = [0] of {int};
						run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError2);
						child_instancegroupswaitForPendingBeforeReturningError2?0;
						goto stop_process
					:: true;
					fi;
					break
				:: true -> 
					goto sweep
				od;
				for22_end: skip
			:: true -> 
				break
			od;
			for22_exit: skip
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	

	if
	:: true -> 
		

		if
		:: 0 != -2 && ub_for223_4 != -2 -> 
						for(i : 0.. ub_for223_4) {
				for30544: skip;
				

				if
				:: true -> 
					run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError3);
					child_instancegroupswaitForPendingBeforeReturningError3?0;
					goto stop_process
				:: true;
				fi;
				for30_end544: skip
			};
			for30_exit544: skip
		:: else -> 
			do
			:: true -> 
				for30: skip;
				

				if
				:: true -> 
					run instancegroupswaitForPendingBeforeReturningError(terminateChan,child_instancegroupswaitForPendingBeforeReturningError3);
					child_instancegroupswaitForPendingBeforeReturningError3?0;
					goto stop_process
				:: true;
				fi;
				for30_end: skip
			:: true -> 
				break
			od;
			for30_exit: skip
		fi;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef terminateChan) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: terminateChan.async_send!0;
	:: terminateChan.sync!0 -> 
		terminateChan.sending?0
	fi;
	stop_process: skip
}
proctype instancegroupswaitForPendingBeforeReturningError(Chandef terminateChan;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: 0 != -2 && ub_for260_2 != -2 -> 
				for(i : 0.. ub_for260_2) {
			for21541: skip;
			

			if
			:: terminateChan.async_rcv?0;
			:: terminateChan.sync?0;
			fi;
			for21_end541: skip
		};
		for21_exit541: skip
	:: else -> 
		do
		:: true -> 
			for21: skip;
			

			if
			:: terminateChan.async_rcv?0;
			:: terminateChan.sync?0;
			fi;
			for21_end: skip
		:: true -> 
			break
		od;
		for21_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

