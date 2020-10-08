#define lb_for92_0  -1
#define ub_for92_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example250238556/diff/fd/gradient.go
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
	int nWorkers = 5;
	Chandef quit;
	Chandef sendChan;
	int formula_Stencil = 5;
	bool state = false;
	Chandef ansChan;
	int xcopy = 5;
	int evals = 5;
	int i;
	
	if
	:: true -> 
				for(i : 1.. xcopy) {
for10:						for(i : 1.. formula_Stencil) {
for11:
			}
		};
		goto stop_process
	:: true;
	fi;
	
	if
	:: evals > 0 -> 
		sendChan.size = evals;
		run emptyChan(sendChan)
	:: else -> 
		run sync_monitor(sendChan)
	fi;
	
	if
	:: evals > 0 -> 
		ansChan.size = evals;
		run emptyChan(ansChan)
	:: else -> 
		run sync_monitor(ansChan)
	fi;
	run sync_monitor(quit);
		for(i : 0.. nWorkers-1) {
for20:		run Anonymous0(sendChan,ansChan,quit)
	};
for20_exit:	run Anonymous1(sendChan,ansChan,quit);
		for(i : 1.. dst) {
for40:
	};
	
	if
	:: 0 != -1 && evals-1 != -1 -> 
				for(i : 0.. evals-1) {
for50:			
			if
			:: ansChan.async_rcv?0;
			:: ansChan.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for50:			
			if
			:: ansChan.async_rcv?0;
			:: ansChan.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for50_exit:	goto stop_process;
	quit.closing!true
stop_process:}

proctype Anonymous0(Chandef sendChan;Chandef ansChan;Chandef quit) {
	bool closed; 
	int i;
	do
	:: true -> 
for21:		do
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		od
	od;
for21_exit:stop_process:
}
proctype Anonymous1(Chandef sendChan;Chandef ansChan;Chandef quit) {
	bool closed; 
	int i;
		for(i : 1.. x) {
for30:				for(i : 1.. formula_Stencil) {
for31:			
			if
			:: true -> 
				
				if
				:: ansChan.async_send!0;
				:: ansChan.sync!0 -> 
					ansChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: sendChan.async_send!0;
			:: sendChan.sync!0 -> 
				sendChan.sending?0
			fi
		}
	};
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

