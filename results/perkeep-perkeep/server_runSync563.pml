
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example500871849/pkg/server/sync.go
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
	Chandef resch;
	Chandef workch;
	Chandef intr;
	Chandef errch;
	Chandef enumch;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 8 > 0 -> 
		enumch.size = 8;
		run AsyncChan(enumch)
	:: else -> 
		run sync_monitor(enumch)
	fi;
	

	if
	:: 1 > 0 -> 
		errch.size = 1;
		run AsyncChan(errch)
	:: else -> 
		run sync_monitor(errch)
	fi;
	run sync_monitor(intr);
	

	if
	:: 1000 > 0 -> 
		workch.size = 1000;
		run AsyncChan(workch)
	:: else -> 
		run sync_monitor(workch)
	fi;
	

	if
	:: 8 > 0 -> 
		resch.size = 8;
		run AsyncChan(resch)
	:: else -> 
		run sync_monitor(resch)
	fi;
	FeedWork: skip;
		do
	:: true -> 
		

		if
		:: enumch.async_rcv?state,num_msgs;
		:: enumch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true -> 
				run go_copyWorker(resch,workch)
			:: true;
			fi;
			do
			:: workch.async_send!0 -> 
				break
			:: workch.sync!0 -> 
				workch.sending?state;
				break
			:: true -> 
				goto FeedWork
			od;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
	workch.closing!true;
	goto stop_process;
	intr.closing!true
stop_process:skip
}

proctype go_copyWorker(Chandef res;Chandef work) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: work.async_rcv?state,num_msgs;
		:: work.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: res.async_send!0;
			:: res.sync!false,0 -> 
				res.sending?state
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
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

