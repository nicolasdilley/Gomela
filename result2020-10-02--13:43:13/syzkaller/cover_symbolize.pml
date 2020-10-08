#define lb_for659_0  -1
#define ub_for659_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example617981797/pkg/cover/report.go
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
	int i;
	Chandef pcchan;
	Chandef symbolizerC;
	int procs = 5;
	bool state = false;
	
	if
	:: procs > 0 -> 
		symbolizerC.size = procs;
		run emptyChan(symbolizerC)
	:: else -> 
		run sync_monitor(symbolizerC)
	fi;
	
	if
	:: procs > 0 -> 
		pcchan.size = procs;
		run emptyChan(pcchan)
	:: else -> 
		run sync_monitor(pcchan)
	fi;
		for(i : 0.. procs-1) {
for10:		run Anonymous0(symbolizerC,pcchan)
	};
for10_exit:	
	if
	:: lb_for659_0 != -1 && ub_for659_1 != -1 -> 
				for(i : lb_for659_0.. ub_for659_1) {
for20:			
			if
			:: pcchan.async_send!0;
			:: pcchan.sync!0 -> 
				pcchan.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: pcchan.async_send!0;
			:: pcchan.sync!0 -> 
				pcchan.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:	pcchan.closing!true;
	
	if
	:: 0 != -1 && procs-1 != -1 -> 
				for(i : 0.. procs-1) {
for30:			
			if
			:: symbolizerC.async_rcv?0;
			:: symbolizerC.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: symbolizerC.async_rcv?0;
			:: symbolizerC.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef symbolizerC;Chandef pcchan) {
	bool closed; 
	int i;
	do
	:: pcchan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: pcchan.async_rcv?0;
			:: pcchan.sync?0;
			fi
		fi
	od;
	
	if
	:: symbolizerC.async_send!0;
	:: symbolizerC.sync!0 -> 
		symbolizerC.sending?0
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

