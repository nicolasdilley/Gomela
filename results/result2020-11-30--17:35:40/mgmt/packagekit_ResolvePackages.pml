#define lb_for325_0  -1
#define ub_for325_1  -1

// /tmp/clone-example058538204/engine/resources/packagekit/packagekit.go
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
	int i;
	chan child_objmatchSignal0 = [0] of {int};
	Chandef ch;
	int packageIDs = -2;
	bool state = false;
	
	if
	:: 1000 > 0 -> 
		ch.size = 1000;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run objmatchSignal(ch,signals,child_objmatchSignal0);
	child_objmatchSignal0?0;
	
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
loop:		do
	:: true -> 
for20:		do
		:: ch.async_rcv?0 -> 
			
			if
			:: true -> 
								for(i : 0.. packageIDs-1) {
for21:
				}
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true -> 
					
					if
					:: true -> 
						goto loop
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				fi
			fi;
			break
		:: ch.sync?0 -> 
			
			if
			:: true -> 
								for(i : 0.. packageIDs-1) {
for21:
				}
			:: true -> 
				
				if
				:: true -> 
					goto loop
				:: true -> 
					
					if
					:: true -> 
						goto loop
					:: true -> 
						goto stop_process
					:: true -> 
						goto stop_process
					fi
				fi
			fi;
			break
		od
	od;
for20_exit:;
	goto stop_process
stop_process:}

proctype objmatchSignal(Chandef ch;int signals;chan child) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 0.. signals-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	:: true -> 
				for(i : 0.. signals-1) {
for10:			
			if
			:: true -> 
				break
			:: true;
			fi
		}
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
stop_process:	child!0
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

