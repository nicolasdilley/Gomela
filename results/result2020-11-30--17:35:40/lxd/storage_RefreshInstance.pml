
// /tmp/clone-example144597218/lxd/storage/backend_lxd.go
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
	int srcSnapVols = -2;
	bool state = false;
	int i;
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
				for(i : 0.. srcSnapVols-1) {
for20:
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef aEndErrCh;
		
		if
		:: 1 > 0 -> 
			aEndErrCh.size = 1;
			run AsyncChan(aEndErrCh)
		:: else -> 
			run sync_monitor(aEndErrCh)
		fi;
		Chandef bEndErrCh;
		
		if
		:: 1 > 0 -> 
			bEndErrCh.size = 1;
			run AsyncChan(bEndErrCh)
		:: else -> 
			run sync_monitor(bEndErrCh)
		fi;
		run Anonymous0(aEndErrCh,bEndErrCh);
		run Anonymous1(aEndErrCh,bEndErrCh);
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true -> 
				for(i : 0.. srcSnapVols-1) {
for20:
		};
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		Chandef aEndErrCh;
		
		if
		:: 1 > 0 -> 
			aEndErrCh.size = 1;
			run AsyncChan(aEndErrCh)
		:: else -> 
			run sync_monitor(aEndErrCh)
		fi;
		Chandef bEndErrCh;
		
		if
		:: 1 > 0 -> 
			bEndErrCh.size = 1;
			run AsyncChan(bEndErrCh)
		:: else -> 
			run sync_monitor(bEndErrCh)
		fi;
		run Anonymous0(aEndErrCh,bEndErrCh);
		run Anonymous1(aEndErrCh,bEndErrCh);
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
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

proctype Anonymous0(Chandef aEndErrCh;Chandef bEndErrCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: aEndErrCh.async_send!0;
	:: aEndErrCh.sync!0 -> 
		aEndErrCh.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef aEndErrCh;Chandef bEndErrCh) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: bEndErrCh.async_send!0;
	:: bEndErrCh.sync!0 -> 
		bEndErrCh.sending?0
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
