
// /tmp/clone-example053054904/kit/pubsub/pubsub.go
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
	Chandef ch1;
	int i;
	Chandef ch2;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		ch1.size = 1;
		run AsyncChan(ch1)
	:: else -> 
		run sync_monitor(ch1)
	fi;
	
	if
	:: 1 > 0 -> 
		ch2.size = 1;
		run AsyncChan(ch2)
	:: else -> 
		run sync_monitor(ch2)
	fi;
	run go_qloop(ch1,ch2);
	goto stop_process
stop_process:}

proctype go_qloop(Chandef ch1;Chandef ch2) {
	bool closed; 
	int i;
	bool state;
__preclose:		do
	:: true -> 
for10:		
		if
		:: true -> 
			do
			:: ch1.async_rcv?0 -> 
				
				if
				:: true -> 
					goto __preclose
				:: true;
				fi;
				break
			:: ch1.sync?0 -> 
				
				if
				:: true -> 
					goto __preclose
				:: true;
				fi;
				break
			:: ch2.async_send!0 -> 
				break
			:: ch2.sync!0 -> 
				ch2.sending?0;
				break
			od
		:: true -> 
			
			if
			:: ch1.async_rcv?0;
			:: ch1.sync?0;
			fi;
			
			if
			:: true -> 
				goto __preclose
			:: true;
			fi
		:: true -> 
			
			if
			:: ch1.async_rcv?0;
			:: ch1.sync?0;
			fi;
			
			if
			:: true -> 
				goto __preclose
			:: true;
			fi
		fi
	od;
for10_exit:;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			ch2.closing!true;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ch2.async_send!0;
		:: ch2.sync!0 -> 
			ch2.sending?0
		fi
	od;
for20_exit:stop_process:
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
