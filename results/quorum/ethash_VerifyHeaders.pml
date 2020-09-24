#define headers  5
#define workers  5
#define headers  5
#define lb_for145_3  -1
#define ub_for145_4  -1
#define lb_for153_5  -1
#define ub_for153_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example244624373/consensus/ethash/consensus.go
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
	bool state = false;
	Chandef errorsOut;
	Chandef done;
	int inputs = 5;
	Chandef inputs;
	Chandef abort;
	int workers = 5;
	int i;
	
	if
	:: true -> 
		Chandef results;
		
		if
		:: headers > 0 -> 
			results.size = headers;
			run emptyChan(results)
		:: else -> 
			run sync_monitor(results)
		fi;
		Chandef abort;
		run sync_monitor(abort);
		
		if
		:: 0 != -1 && headers-1 != -1 -> 
						for(i : 0.. headers-1) {
for10:				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:		goto stop_process
	:: true;
	fi;
	run sync_monitor(inputs);
	
	if
	:: workers > 0 -> 
		done.size = workers;
		run emptyChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run sync_monitor(abort);
		for(i : 0.. workers-1) {
for20:		run Anonymous0(abort,results,inputs,done,abort,errorsOut)
	};
for20_exit:	
	if
	:: headers > 0 -> 
		errorsOut.size = headers;
		run emptyChan(errorsOut)
	:: else -> 
		run sync_monitor(errorsOut)
	fi;
	run Anonymous1(abort,results,inputs,done,abort,errorsOut);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef abort;Chandef results;Chandef inputs;Chandef done;Chandef abort;Chandef errorsOut) {
	bool closed; 
	int i;
	do
	:: inputs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			inputs.in?0;
			
			if
			:: done.async_send!0;
			:: done.sync!0 -> 
				done.sending?0
			fi
		fi
	od;
stop_process:
}
proctype Anonymous1(Chandef abort;Chandef results;Chandef inputs;Chandef done;Chandef abort;Chandef errorsOut) {
	bool closed; 
	int i;
	do
	:: true -> 
for30:		do
		:: inputs.async_send!0 -> 
			break
		:: inputs.sync!0 -> 
			inputs.sending?0;
			break
		:: abort.async_rcv?0 -> 
			goto stop_process
		:: abort.sync?0 -> 
			goto stop_process
		od
	od;
for30_exit:	inputs.closing!true;
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

