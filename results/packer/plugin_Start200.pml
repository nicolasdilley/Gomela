
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example970072738/packer/plugin/client.go
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
	Chandef linesCh;
	Chandef c_doneLogging;
	bool state = false;
	Chandef exitCh;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(c_doneLogging);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(exitCh);
	run Anonymous0(c_doneLogging,exitCh,linesCh);
	run sync_monitor(linesCh);
	run Anonymous1(c_doneLogging,exitCh,linesCh);
	do
	:: exitCh.async_rcv?0 -> 
		break
	:: exitCh.sync?0 -> 
		break
	:: linesCh.async_rcv?0 -> 
		
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
		break
	:: linesCh.sync?0 -> 
		
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
		break
	od;
	goto stop_process;
	run Anonymous2(c_doneLogging,exitCh,linesCh)
stop_process:}

proctype Anonymous0(Chandef c_doneLogging;Chandef exitCh;Chandef linesCh) {
	bool closed; 
	int i;
	bool state;
	exitCh.closing!true;
stop_process:
}
proctype Anonymous1(Chandef c_doneLogging;Chandef exitCh;Chandef linesCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: linesCh.async_send!0;
			:: linesCh.sync!0 -> 
				linesCh.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	od;
for10_exit:stop_process:	linesCh.closing!true
}
proctype Anonymous2(Chandef c_doneLogging;Chandef exitCh;Chandef linesCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: linesCh.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: linesCh.async_rcv?0;
			:: linesCh.sync?0;
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

