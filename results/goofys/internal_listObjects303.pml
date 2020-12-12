
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example470474324/internal/dir.go
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
	Chandef errListChan;
	Chandef errSlurpChan;
	int i;
	Chandef slurpChan;
	Chandef listChan;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		errSlurpChan.size = 1;
		run AsyncChan(errSlurpChan)
	:: else -> 
		run sync_monitor(errSlurpChan)
	fi;
	
	if
	:: 1 > 0 -> 
		slurpChan.size = 1;
		run AsyncChan(slurpChan)
	:: else -> 
		run sync_monitor(slurpChan)
	fi;
	
	if
	:: 1 > 0 -> 
		errListChan.size = 1;
		run AsyncChan(errListChan)
	:: else -> 
		run sync_monitor(errListChan)
	fi;
	
	if
	:: 1 > 0 -> 
		listChan.size = 1;
		run AsyncChan(listChan)
	:: else -> 
		run sync_monitor(listChan)
	fi;
	
	if
	:: true -> 
		run Anonymous0(errSlurpChan,slurpChan,errListChan,listChan)
	:: true -> 
		
		if
		:: errSlurpChan.async_send!0;
		:: errSlurpChan.sync!0 -> 
			errSlurpChan.sending?0
		fi
	:: true -> 
		
		if
		:: errSlurpChan.async_send!0;
		:: errSlurpChan.sync!0 -> 
			errSlurpChan.sending?0
		fi
	fi;
	do
	:: slurpChan.async_rcv?0 -> 
		goto stop_process
	:: slurpChan.sync?0 -> 
		goto stop_process
	:: errSlurpChan.async_rcv?0 -> 
		break
	:: errSlurpChan.sync?0 -> 
		break
	od;
	do
	:: listChan.async_rcv?0 -> 
		goto stop_process
	:: listChan.sync?0 -> 
		goto stop_process
	:: errListChan.async_rcv?0 -> 
		goto stop_process
	:: errListChan.sync?0 -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef errSlurpChan;Chandef slurpChan;Chandef errListChan;Chandef listChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: errSlurpChan.async_send!0;
		:: errSlurpChan.sync!0 -> 
			errSlurpChan.sending?0
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: slurpChan.async_send!0;
			:: slurpChan.sync!0 -> 
				slurpChan.sending?0
			fi
		:: true -> 
			
			if
			:: errSlurpChan.async_send!0;
			:: errSlurpChan.sync!0 -> 
				errSlurpChan.sending?0
			fi
		:: true -> 
			
			if
			:: errSlurpChan.async_send!0;
			:: errSlurpChan.sync!0 -> 
				errSlurpChan.sending?0
			fi
		fi
	fi;
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

