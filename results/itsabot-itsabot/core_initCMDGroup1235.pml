
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example643355398/core/handlers.go
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
	Chandef delconnch;
	Chandef addconnch;
	Chandef cmdch;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 10 > 0 -> 
		cmdch.size = 10;
		run AsyncChan(cmdch)
	:: else -> 
		run sync_monitor(cmdch)
	fi;
	

	if
	:: 10 > 0 -> 
		addconnch.size = 10;
		run AsyncChan(addconnch)
	:: else -> 
		run sync_monitor(addconnch)
	fi;
	

	if
	:: 10 > 0 -> 
		delconnch.size = 10;
		run AsyncChan(delconnch)
	:: else -> 
		run sync_monitor(delconnch)
	fi;
	run go_cmder(cmdch,addconnch,delconnch)
stop_process:skip
}

proctype go_cmder(Chandef cmdch;Chandef addconnch;Chandef delconnch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: addconnch.async_rcv?state,num_msgs -> 
			break
		:: addconnch.sync?state,num_msgs -> 
			break
		:: delconnch.async_rcv?state,num_msgs -> 
			break
		:: delconnch.sync?state,num_msgs -> 
			break
		:: cmdch.async_rcv?state,num_msgs -> 
			break
		:: cmdch.sync?state,num_msgs -> 
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
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

