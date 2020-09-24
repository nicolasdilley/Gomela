#define lb_for159_0  -1
#define ub_for159_1  -1
#define lb_for173_2  -1
#define ub_for173_3  -1
#define lb_for195_4  -1
#define ub_for195_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example749193309/pkg/istio-agent/xds_proxy.go
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
	Chandef upstreamError;
	Chandef healthEventsChan;
	Chandef requestsChan;
	int i;
	Chandef downstreamError;
	Chandef responsesChan;
	Chandef ndsRequestChan;
	bool state = false;
	run sync_monitor(upstreamError);
	run sync_monitor(downstreamError);
	
	if
	:: 10 > 0 -> 
		requestsChan.size = 10;
		run emptyChan(requestsChan)
	:: else -> 
		run sync_monitor(requestsChan)
	fi;
	
	if
	:: 10 > 0 -> 
		responsesChan.size = 10;
		run emptyChan(responsesChan)
	:: else -> 
		run sync_monitor(responsesChan)
	fi;
	
	if
	:: 5 > 0 -> 
		healthEventsChan.size = 5;
		run emptyChan(healthEventsChan)
	:: else -> 
		run sync_monitor(healthEventsChan)
	fi;
	
	if
	:: 5 > 0 -> 
		ndsRequestChan.size = 5;
		run emptyChan(ndsRequestChan)
	:: else -> 
		run sync_monitor(ndsRequestChan)
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
	run Anonymous0(upstreamError,downstreamError,requestsChan,responsesChan,healthEventsChan,ndsRequestChan);
	run Anonymous1(upstreamError,downstreamError,requestsChan,responsesChan,healthEventsChan,ndsRequestChan);
	do
	:: true -> 
for30:		do
		:: true -> 
			goto stop_process
		:: true -> 
			goto stop_process
		od
	od;
for30_exit:
stop_process:}

proctype Anonymous0(Chandef upstreamError;Chandef downstreamError;Chandef requestsChan;Chandef responsesChan;Chandef healthEventsChan;Chandef ndsRequestChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: upstreamError.async_send!0;
			:: upstreamError.sync!0 -> 
				upstreamError.sending?0
			fi;
			upstreamError.closing!true;
			goto stop_process
		:: true;
		fi;
		
		if
		:: responsesChan.async_send!0;
		:: responsesChan.sync!0 -> 
			responsesChan.sending?0
		fi
	od;
for10_exit:	responsesChan.closing!true;
stop_process:
}
proctype Anonymous1(Chandef upstreamError;Chandef downstreamError;Chandef requestsChan;Chandef responsesChan;Chandef healthEventsChan;Chandef ndsRequestChan) {
	bool closed; 
	int i;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: downstreamError.async_send!0;
			:: downstreamError.sync!0 -> 
				downstreamError.sending?0
			fi;
			downstreamError.closing!true;
			goto stop_process
		:: true;
		fi;
		
		if
		:: requestsChan.async_send!0;
		:: requestsChan.sync!0 -> 
			requestsChan.sending?0
		fi;
		
		if
		:: true -> 
			
			if
			:: ndsRequestChan.async_send!0;
			:: ndsRequestChan.sync!0 -> 
				ndsRequestChan.sending?0
			fi
		:: true;
		fi
	od;
for20_exit:	requestsChan.closing!true;
	ndsRequestChan.closing!true;
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

