#define lb_for25_0  -1
#define ub_for25_1  -1

// /tmp/clone-example842310962/src/build/client_tty.go
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
	bool state = false;
	int i;
	
	if
	:: true -> 
		run Anonymous0(sigchan)
	:: true -> 
		Chandef sigchan;
		
		if
		:: 1 > 0 -> 
			sigchan.size = 1;
			run AsyncChan(sigchan)
		:: else -> 
			run sync_monitor(sigchan)
		fi;
		run Anonymous1(sigchan)
	:: true -> 
		Chandef sigchan;
		
		if
		:: 1 > 0 -> 
			sigchan.size = 1;
			run AsyncChan(sigchan)
		:: else -> 
			run sync_monitor(sigchan)
		fi;
		run Anonymous1(sigchan)
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef sigchan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef sigchan) {
	bool closed; 
	int i;
	bool state;
	do
	:: sigchan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: sigchan.async_rcv?0;
			:: sigchan.sync?0;
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
