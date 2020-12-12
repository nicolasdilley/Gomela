#define revListShas_chanBufSize  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example714267106/lfs/gitscanner_refs.go
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
	Chandef errs;
	bool state = false;
	int chanBufSize = revListShas_chanBufSize;
	Chandef revs;
	chan child_lfsNewStringChannelWrapper0 = [0] of {int};
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: chanBufSize > 0 -> 
		revs.size = chanBufSize;
		run AsyncChan(revs)
	:: else -> 
		run sync_monitor(revs)
	fi;
	
	if
	:: 5 > 0 -> 
		errs.size = 5;
		run AsyncChan(errs)
	:: else -> 
		run sync_monitor(errs)
	fi;
	run Anonymous0(revs,errs);
	run lfsNewStringChannelWrapper(revs,errs,child_lfsNewStringChannelWrapper0);
	child_lfsNewStringChannelWrapper0?0;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef revs;Chandef errs) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: lb_for129_1 != -2 && ub_for129_2 != -2 -> 
				for(i : lb_for129_1.. ub_for129_2) {
for10:			
			if
			:: revs.async_send!0;
			:: revs.sync!0 -> 
				revs.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for10:			
			if
			:: revs.async_send!0;
			:: revs.sync!0 -> 
				revs.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for10_exit:	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: errs.async_send!0;
		:: errs.sync!0 -> 
			errs.sending?0
		fi
	:: true;
	fi;
	revs.closing!true;
	errs.closing!true;
stop_process:
}
proctype lfsNewStringChannelWrapper(Chandef stringChan;Chandef errorChan;chan child) {
	bool closed; 
	int i;
	bool state;
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

