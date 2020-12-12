#define lb_for94_0  -1
#define ub_for94_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example672779410/src/test/run/run.go
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
	Chandef ch;
	Chandef timeout;
	Chandef done;
	bool state = false;
	run sync_monitor(timeout);
	
	if
	:: true -> 
		run Anonymous0(timeout,ch,done)
	:: true;
	fi;
	
	if
	:: 3000 > 0 -> 
		ch.size = 3000;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run sync_monitor(done);
	run Anonymous1(timeout,ch,done);
exitFor:			for(i : lb_for94_0.. ub_for94_1) {
for40:		do
		:: timeout.async_rcv?0 -> 
			goto exitFor;
			break
		:: timeout.sync?0 -> 
			goto exitFor;
			break
		:: true -> 
			chan child_Execute0 = [0] of {int};
			run Execute(ch,child_Execute0);
			child_Execute0?0;
			
			if
			:: true -> 
				timeout.closing!true
			:: true;
			fi;
			break
		od
	};
for40_exit:;
	
	if
	:: done.async_rcv?0;
	:: done.sync?0;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef timeout;Chandef ch;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		timeout.closing!true;
		break
	od;
stop_process:
}
proctype Anonymous1(Chandef timeout;Chandef ch;Chandef done) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		do
		:: timeout.async_rcv?0 -> 
			goto outer;
			break
		:: timeout.sync?0 -> 
			goto outer;
			break
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		od
	od;
for10_exit:outer:		
	if
	:: true -> 
		do
		:: true -> 
for20:			
			if
			:: true -> 
				
				if
				:: ch.async_rcv?0;
				:: ch.sync?0;
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				break
			:: true;
			fi
		od;
for20_exit:		
		if
		:: done.async_send!0;
		:: done.sync!0 -> 
			done.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	do
	:: true -> 
for30:		do
		:: ch.async_rcv?0 -> 
			break
		:: ch.sync?0 -> 
			break
		od
	od;
for30_exit:	goto stop_process;
stop_process:
}
proctype Execute(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
	run Anonymous2(ch);
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

