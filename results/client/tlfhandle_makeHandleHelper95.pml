#define makeHandleHelper_writers  ??
#define makeHandleHelper_readers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example678508291/go/kbfs/tlfhandle/resolve.go
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
	Chandef rc;
	Chandef errCh;
	int usedWNames = -2;
	Chandef uwc;
	int writers = makeHandleHelper_writers;
	bool state = false;
	Chandef wc;
	Chandef idc;
	Chandef urc;
	int readers = makeHandleHelper_readers;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: 1 > 0 -> 
		errCh.size = 1;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	
	if
	:: writers > 0 -> 
		wc.size = writers;
		run AsyncChan(wc)
	:: else -> 
		run sync_monitor(wc)
	fi;
	
	if
	:: writers > 0 -> 
		uwc.size = writers;
		run AsyncChan(uwc)
	:: else -> 
		run sync_monitor(uwc)
	fi;
	
	if
	:: 1 > 0 -> 
		idc.size = 1;
		run AsyncChan(idc)
	:: else -> 
		run sync_monitor(idc)
	fi;
	
	if
	:: readers > 0 -> 
		rc.size = readers;
		run AsyncChan(rc)
	:: else -> 
		run sync_monitor(rc)
	fi;
	
	if
	:: readers > 0 -> 
		urc.size = readers;
		run AsyncChan(urc)
	:: else -> 
		run sync_monitor(urc)
	fi;
	
	if
	:: 0 != -2 && writers + readers-1 != -3 -> 
				for(i : 0.. writers + readers-1) {
for30:			do
			:: errCh.async_rcv?0 -> 
				goto stop_process
			:: errCh.sync?0 -> 
				goto stop_process
			:: wc.async_rcv?0 -> 
				break
			:: wc.sync?0 -> 
				break
			:: rc.async_rcv?0 -> 
				break
			:: rc.sync?0 -> 
				break
			:: uwc.async_rcv?0 -> 
				break
			:: uwc.sync?0 -> 
				break
			:: urc.async_rcv?0 -> 
				break
			:: urc.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: errCh.async_rcv?0 -> 
				goto stop_process
			:: errCh.sync?0 -> 
				goto stop_process
			:: wc.async_rcv?0 -> 
				break
			:: wc.sync?0 -> 
				break
			:: rc.async_rcv?0 -> 
				break
			:: rc.sync?0 -> 
				break
			:: uwc.async_rcv?0 -> 
				break
			:: uwc.sync?0 -> 
				break
			:: urc.async_rcv?0 -> 
				break
			:: urc.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	idc.closing!true;
	do
	:: idc.async_rcv?0 -> 
		break
	:: idc.sync?0 -> 
		break
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: idc.async_rcv?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: idc.sync?0 -> 
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: true -> 
			break
		od
	:: true;
	fi;
	
	if
	:: true -> 
				for(i : 0.. usedWNames-1) {
for60:
		}
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype go_tlfhandleresolveOneUser(Chandef errCh;Chandef userInfoResults;Chandef socialAssertionResults;Chandef idResults) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		do
		:: errCh.async_send!0 -> 
			break
		:: errCh.sync!0 -> 
			errCh.sending?0;
			break
		:: true -> 
			break
		od;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		do
		:: idResults.async_send!0 -> 
			break
		:: idResults.sync!0 -> 
			idResults.sending?0;
			break
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			goto stop_process
		od
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: userInfoResults.async_send!0;
		:: userInfoResults.sync!0 -> 
			userInfoResults.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: socialAssertionResults.async_send!0;
		:: socialAssertionResults.sync!0 -> 
			socialAssertionResults.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: errCh.async_send!0;
	:: errCh.sync!0 -> 
		errCh.sending?0
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

