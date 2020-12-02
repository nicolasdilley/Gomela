#define lb_for62_0  -1
#define ub_for62_1  -1

// /tmp/clone-example040373892/pkg/retry/retry.go
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
	Chandef finish;
	int i;
	int r_retries = -2;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		finish.size = 1;
		run AsyncChan(finish)
	:: else -> 
		run sync_monitor(finish)
	fi;
	run Anonymous0(finish);
	
	if
	:: 0 != -2 && r_retries-1 != -3 -> 
				for(i : 0.. r_retries-1) {
for20:			
			if
			:: finish.async_send!0;
			:: finish.sync!0 -> 
				finish.sending?0
			fi;
			goto stop_process
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: finish.async_send!0;
			:: finish.sync!0 -> 
				finish.sending?0
			fi;
			goto stop_process
		:: true -> 
			break
		od
	fi;
for20_exit:	
	if
	:: finish.async_send!0;
	:: finish.sync!0 -> 
		finish.sending?0
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef finish) {
	bool closed; 
	int i;
	bool state;
	do
	:: finish.async_rcv?0 -> 
		goto stop_process
	:: finish.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	:: true -> 
		do
		:: true -> 
for10:
		od;
for10_exit:		break
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

