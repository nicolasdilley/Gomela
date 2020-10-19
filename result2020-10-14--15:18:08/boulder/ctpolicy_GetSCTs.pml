#define GetSCTs_ctp_groups  60
#define GetSCTs_ctp_informational  60

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example340194181/ctpolicy/ctpolicy.go
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
	int ctp_groups = GetSCTs_ctp_groups;
	Chandef results;
	int ctp_informational = GetSCTs_ctp_informational;
	bool state = false;
	
	if
	:: ctp_groups > 0 -> 
		results.size = ctp_groups;
		run emptyChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
		for(i : 1.. ctp_groups) {
for10:		run Anonymous0(results)
	};
		for(i : 1.. ctp_informational) {
for20:		run Anonymous1(results)
	};
	
	if
	:: 0 != -1 && ctp_groups-1 != -1 -> 
				for(i : 0.. ctp_groups-1) {
for30:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for30:			
			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for30_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef results) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: results.async_send!0;
		:: results.sync!0 -> 
			results.sending?0
		fi
	:: true;
	fi;
	
	if
	:: results.async_send!0;
	:: results.sync!0 -> 
		results.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef results) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
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

