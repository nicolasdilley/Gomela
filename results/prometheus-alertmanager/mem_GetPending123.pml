
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example546968684/provider/mem/mem.go
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
	chan child_NewAlertIterator0 = [0] of {int};
	Chandef done;
	Chandef ch;
	bool state = false;
	int i;
	

	if
	:: 200 > 0 -> 
		ch.size = 200;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run sync_monitor(done);
	run go_Anonymous0(ch,done);
	run NewAlertIterator(ch,done,child_NewAlertIterator0);
	child_NewAlertIterator0?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch;Chandef done) {
	bool closed; 
	int i;
	bool state;
	int a_alerts_List13221=0;
	

	if
	:: a_alerts_List13221-1 != -3 -> 
				for(i : 0.. a_alerts_List13221-1) {
			for10: skip;
			do
			:: ch.async_send!0 -> 
				break
			:: ch.sync!0 -> 
				ch.sending?0;
				break
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			od;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for101747: skip;
			do
			:: ch.async_send!0 -> 
				break
			:: ch.sync!0 -> 
				ch.sending?0;
				break
			:: done.async_rcv?0 -> 
				goto stop_process
			:: done.sync?0 -> 
				goto stop_process
			od;
			for10_end1747: skip
		:: true -> 
			break
		od;
		for10_exit1747: skip
	fi;
	stop_process: skip;
	ch.closing!true
}
proctype NewAlertIterator(Chandef ch;Chandef done;chan child) {
	bool closed; 
	int i;
	bool state;
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


