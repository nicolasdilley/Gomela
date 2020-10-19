#define resolveParallelHarness_target  60
#define resolveParallelHarness_answer_Answer  60
#define resolveParallelHarness_input  60
#define resolveParallelHarness_t_Answer  60
#define lb_for287_4  -1
#define ub_for287_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example057755448/responder/recursive_dns_resolver.go
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
	Chandef achan;
	int t_Answer = resolveParallelHarness_t_Answer;
	int answer_Answer = resolveParallelHarness_answer_Answer;
	bool state = false;
	int target = resolveParallelHarness_target;
	int input = resolveParallelHarness_input;
	int i;
		for(i : 1.. target) {
for10:
	};
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
								for(i : 1.. answer_Answer) {
for20:
				}
			:: true;
			fi
		:: true;
		fi;
		goto stop_process
	fi;
	
	if
	:: input > 0 -> 
		achan.size = input;
		run emptyChan(achan)
	:: else -> 
		run sync_monitor(achan)
	fi;
		for(i : 1.. input) {
for30:		run Anonymous0(achan)
	};
	do
	:: true -> 
for40:		
		if
		:: true -> 
			break
		:: true;
		fi;
		do
		:: achan.async_rcv?0 -> 
			
			if
			:: true -> 
								for(i : 1.. t_Answer) {
for41:
				}
			:: true;
			fi;
			break
		:: achan.sync?0 -> 
			
			if
			:: true -> 
								for(i : 1.. t_Answer) {
for41:
				}
			:: true;
			fi;
			break
		:: true -> 
			break
		od
	od;
for40_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef achan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: achan.async_send!0;
	:: achan.sync!0 -> 
		achan.sending?0
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

