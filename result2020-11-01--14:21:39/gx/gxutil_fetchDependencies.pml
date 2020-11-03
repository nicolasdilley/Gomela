#define lb_for893_0  -1
#define ub_for893_1  -1
#define lb_for903_2  -1
#define ub_for903_3  -1
#define lb_for955_4  -1
#define ub_for955_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example301575027/gxutil/pm.go
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
	Chandef fetchedPackages;
	int i;
	Chandef fetchErrs;
	bool state = false;
	
	if
	:: 20 > 0 -> 
		fetchedPackages.size = 20;
		run emptyChan(fetchedPackages)
	:: else -> 
		run sync_monitor(fetchedPackages)
	fi;
	
	if
	:: 20 > 0 -> 
		fetchErrs.size = 20;
		run emptyChan(fetchErrs)
	:: else -> 
		run sync_monitor(fetchErrs)
	fi;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
				for(i : lb_for903_2.. ub_for903_3) {
for11:			run Anonymous0(fetchedPackages,fetchErrs)
		};
for11_exit:		do
		:: fetchedPackages.async_rcv?0 -> 
			break
		:: fetchedPackages.sync?0 -> 
			break
		:: fetchErrs.async_rcv?0 -> 
			break
		:: fetchErrs.sync?0 -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true;
		fi
	od;
for10_exit:	
	if
	:: lb_for955_4 != -1 && ub_for955_5 != -1 -> 
				for(i : lb_for955_4.. ub_for955_5) {
for20:			do
			:: fetchErrs.async_rcv?0 -> 
				break
			:: fetchErrs.sync?0 -> 
				break
			:: fetchedPackages.async_rcv?0 -> 
				break
			:: fetchedPackages.sync?0 -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: fetchErrs.async_rcv?0 -> 
				break
			:: fetchErrs.sync?0 -> 
				break
			:: fetchedPackages.async_rcv?0 -> 
				break
			:: fetchedPackages.sync?0 -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef fetchedPackages;Chandef fetchErrs) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: fetchErrs.async_send!0;
		:: fetchErrs.sync!0 -> 
			fetchErrs.sending?0
		fi
	:: true -> 
		
		if
		:: fetchedPackages.async_send!0;
		:: fetchedPackages.sync!0 -> 
			fetchedPackages.sending?0
		fi
	:: true -> 
		
		if
		:: fetchedPackages.async_send!0;
		:: fetchedPackages.sync!0 -> 
			fetchedPackages.sending?0
		fi
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

