#define lb_for254_0  -1
#define ub_for254_1  -1

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
	Chandef ch;
	int i;
	chan child_objmatchSignal0 = [0] of {int};
	bool state = false;
	
	if
	:: 1000 > 0 -> 
		ch.size = 1000;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run objmatchSignal(ch,1,child_objmatchSignal0);
	child_objmatchSignal0?0;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef rch;
		run sync_monitor(rch);
		run Anonymous1(ch,rch);
		goto stop_process
	:: true;
	fi;
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
proctype Anonymous1(Chandef ch;Chandef rch) {
	bool closed; 
	int i;
	bool state;
loop:		do
	:: true -> 
for20:		do
		:: ch.async_rcv?0 -> 
			
			if
			:: true -> 
				goto loop
			:: true;
			fi;
			
			if
			:: rch.async_send!0;
			:: rch.sync!0 -> 
				rch.sending?0
			fi;
			break
		:: ch.sync?0 -> 
			
			if
			:: true -> 
				goto loop
			:: true;
			fi;
			
			if
			:: rch.async_send!0;
			:: rch.sync!0 -> 
				rch.sending?0
			fi;
			break
		od
	od;
for20_exit:;
stop_process:	ch.closing!true
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
