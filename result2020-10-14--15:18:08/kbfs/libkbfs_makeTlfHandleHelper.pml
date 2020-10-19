#define makeTlfHandleHelper_writers  60
#define makeTlfHandleHelper_readers  60
#define makeTlfHandleHelper_usedWNames  60
#define makeTlfHandleHelper_usedUnresolvedWriters  60
#define makeTlfHandleHelper_usedRNames  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example093354317/libkbfs/tlf_handle_resolve.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
}



init { 
	Chandef uwc;
	int usedRNames = makeTlfHandleHelper_usedRNames;
	int writers = makeTlfHandleHelper_writers;
	Chandef errCh;
	Chandef rc;
	int usedWNames = makeTlfHandleHelper_usedWNames;
	bool state = false;
	Chandef wc;
	Chandef idc;
	Chandef urc;
	int readers = makeTlfHandleHelper_readers;
	int usedUnresolvedWriters = makeTlfHandleHelper_usedUnresolvedWriters;
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
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	
	if
	:: writers > 0 -> 
		wc.size = writers;
		run emptyChan(wc)
	:: else -> 
		run sync_monitor(wc)
	fi;
	
	if
	:: writers > 0 -> 
		uwc.size = writers;
		run emptyChan(uwc)
	:: else -> 
		run sync_monitor(uwc)
	fi;
	
	if
	:: 1 > 0 -> 
		idc.size = 1;
		run emptyChan(idc)
	:: else -> 
		run sync_monitor(idc)
	fi;
		for(i : 1.. writers) {
for10:		run go_libkbfsresolveOneUser(errCh,wc,uwc,idc)
	};
	
	if
	:: readers > 0 -> 
		rc.size = readers;
		run emptyChan(rc)
	:: else -> 
		run sync_monitor(rc)
	fi;
	
	if
	:: readers > 0 -> 
		urc.size = readers;
		run emptyChan(urc)
	:: else -> 
		run sync_monitor(urc)
	fi;
		for(i : 1.. readers) {
for20:		run go_libkbfsresolveOneUser(errCh,rc,urc,idc)
	};
	
	if
	:: 0 != -1 && writers + readers-1 != -1 -> 
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
	do
	:: true -> 
for40:
	:: true -> 
		break
	od;
	do
	:: true -> 
for50:
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		do
		:: true -> 
for60:
		:: true -> 
			break
		od
	:: true;
	fi;
	

	if
	:: true -> 
		do
		:: true -> 
for70:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od;
		do
		:: true -> 
for80:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for90:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	:: true -> 
		do
		:: true -> 
for100:			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
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

proctype go_libkbfsresolveOneUser(Chandef errCh;Chandef userInfoResults;Chandef socialAssertionResults;Chandef idResults) {
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
proctype sync_monitor(Chandef ch) {
end: if
    :: ch.sending!false;
      run sync_monitor(ch)
    :: ch.closing?true ->
      run closedChan(ch)
    :: ch.is_closed!false ->
      run sync_monitor(ch)
    fi
stop_process:
}

proctype emptyChan(Chandef ch) {
end: if
	 :: ch.async_send?0 -> // a message has been received
    ch.num_msgs = ch.num_msgs + 1
    if
    :: ch.num_msgs == ch.size ->
      run fullChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
    run closedChan(ch)
  :: ch.is_closed!false ->
    run emptyChan(ch) // sending channel is open 
  :: ch.sending!false ->
    run emptyChan(ch) // sending channel is open 
fi;
}

proctype fullChan(Chandef ch) {
end: if
  :: ch.async_rcv!0 ->
    ch.num_msgs = ch.num_msgs - 1
    if
    :: ch.num_msgs == 0 ->
      run emptyChan(ch)
    :: else ->
      run neitherChan(ch)
    fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false -> // sending channel is open 
      run fullChan(ch)
  :: ch.sending!false ->
      run fullChan(ch)
fi;
}

proctype neitherChan(Chandef ch) {
end: if
  :: ch.async_send?0->
     ch.num_msgs = ch.num_msgs + 1
     if
     :: ch.num_msgs == ch.size ->
        run fullChan(ch)
     :: else ->
        run neitherChan(ch)
    fi;
  :: ch.async_rcv!0
     ch.num_msgs = ch.num_msgs - 1
     if
     :: ch.num_msgs == 0 ->
      run emptyChan(ch)
     :: else ->
      run neitherChan(ch)
     fi;
  :: ch.closing?true -> // closing the channel
      run closedChan(ch)
  :: ch.is_closed!false ->  // sending channel is open
     run neitherChan(ch)
  :: ch.sending!false ->  // sending channel is open
     run neitherChan(ch)
fi;
}

proctype closedChan(Chandef ch) {
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true -> // sending state of channel (closed)
    run closedChan(ch)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0 -> // can always receive on a closed chan
    run closedChan(ch)
  fi;
}

