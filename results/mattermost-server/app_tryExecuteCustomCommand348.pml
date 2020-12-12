
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example135141040/app/command.go
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
	Chandef userChan;
	Chandef chanChan;
	bool state = false;
	Chandef teamChan;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: 1 > 0 -> 
		chanChan.size = 1;
		run AsyncChan(chanChan)
	:: else -> 
		run sync_monitor(chanChan)
	fi;
	run Anonymous0(chanChan,teamChan,userChan);
	
	if
	:: 1 > 0 -> 
		teamChan.size = 1;
		run AsyncChan(teamChan)
	:: else -> 
		run sync_monitor(teamChan)
	fi;
	run Anonymous1(chanChan,teamChan,userChan);
	
	if
	:: 1 > 0 -> 
		userChan.size = 1;
		run AsyncChan(userChan)
	:: else -> 
		run sync_monitor(userChan)
	fi;
	run Anonymous2(chanChan,teamChan,userChan);
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef chanChan;Chandef teamChan;Chandef userChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: chanChan.async_send!0;
	:: chanChan.sync!0 -> 
		chanChan.sending?0
	fi;
	chanChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef chanChan;Chandef teamChan;Chandef userChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: teamChan.async_send!0;
	:: teamChan.sync!0 -> 
		teamChan.sending?0
	fi;
	teamChan.closing!true;
stop_process:
}
proctype Anonymous2(Chandef chanChan;Chandef teamChan;Chandef userChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: userChan.async_send!0;
	:: userChan.sync!0 -> 
		userChan.sending?0
	fi;
	userChan.closing!true;
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

