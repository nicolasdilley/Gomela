
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example776515020/pkg/server/sync.go
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
	Chandef errch;
	int i;
	Chandef workch;
	Chandef enumch;
	Chandef intr;
	Chandef resch;
	bool state = false;
	
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
	run Anonymous0(enumch,errch,intr,workch,resch);
	
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
FeedWork:		do
	:: enumch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: enumch.async_rcv?0;
			:: enumch.sync?0;
			fi;
			
			if
			:: true -> 
				run go_copyWorker(resch,workch)
			:: true;
			fi;
			do
			:: workch.async_send!0 -> 
				break
			:: workch.sync!0 -> 
				workch.sending?0;
				break
			:: true -> 
				goto FeedWork;
				break
			od
		fi
	od;
	workch.closing!true;
for20_exit:	goto stop_process;
	intr.closing!true
stop_process:}

proctype Anonymous0(Chandef enumch;Chandef errch;Chandef intr;Chandef workch;Chandef resch) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: errch.async_send!0;
	:: errch.sync!0 -> 
		errch.sending?0
	fi;
stop_process:
}
proctype go_copyWorker(Chandef res;Chandef work) {
	bool closed; 
	int i;
	bool state;
	do
	:: work.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: work.async_rcv?0;
			:: work.sync?0;
			fi;
			
			if
			:: res.async_send!0;
			:: res.sync!0 -> 
				res.sending?0
			fi
		fi
	od;
stop_process:
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

