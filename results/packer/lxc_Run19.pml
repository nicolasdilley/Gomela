#define lb_for35_0  -1
#define ub_for35_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example970072738/builder/lxc/step_wait_init.go
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
	Chandef cancel;
	int i;
	Chandef waitDone;
	bool state = false;
	run sync_monitor(cancel);
	
	if
	:: 1 > 0 -> 
		waitDone.size = 1;
		run AsyncChan(waitDone)
	:: else -> 
		run sync_monitor(waitDone)
	fi;
	run Anonymous0(cancel,waitDone);
WaitLoop:		do
	:: true -> 
for20:		do
		:: waitDone.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto WaitLoop;
			break
		:: waitDone.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			goto WaitLoop;
			break
		:: true -> 
			
			if
			:: true -> 
				cancel.closing!true;
				goto stop_process
			:: true;
			fi;
			break
		od
	od;
for20_exit:;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef cancel;Chandef waitDone) {
	bool closed; 
	int i;
	bool state;
	chan child_waitForInit0 = [0] of {int};
	run waitForInit(cancel,child_waitForInit0);
	child_waitForInit0?0;
	
	if
	:: waitDone.async_send!0;
	:: waitDone.sync!0 -> 
		waitDone.sending?0
	fi;
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

