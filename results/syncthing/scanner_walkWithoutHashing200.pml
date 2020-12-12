
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example666849052/lib/scanner/walk.go
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
	Chandef toHashChan;
	int i;
	Chandef finishedChan;
	bool state = false;
	run sync_monitor(toHashChan);
	run sync_monitor(finishedChan);
	run go_scan(toHashChan,finishedChan);
	run Anonymous1(toHashChan,finishedChan);
	goto stop_process
stop_process:}

proctype go_scan(Chandef toHashChan;Chandef finishedChan) {
	bool closed; 
	int i;
	bool state;
	chan child_walkAndHashFiles0 = [0] of {int};
	int w_Subs = -2;
	run walkAndHashFiles(toHashChan,finishedChan,child_walkAndHashFiles0);
	child_walkAndHashFiles0?0;
	
	if
	:: true -> 
				for(i : 0.. w_Subs-1) {
for10:
		}
	:: true -> 
				for(i : 0.. w_Subs-1) {
for10:
		}
	fi;
	toHashChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef toHashChan;Chandef finishedChan) {
	bool closed; 
	int i;
	bool state;
	do
	:: toHashChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: toHashChan.async_rcv?0;
			:: toHashChan.sync?0;
			fi;
			
			if
			:: finishedChan.async_send!0;
			:: finishedChan.sync!0 -> 
				finishedChan.sending?0
			fi
		fi
	od;
	finishedChan.closing!true;
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

