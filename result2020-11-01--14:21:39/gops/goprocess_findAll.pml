#define findAll_pss 1
#define findAll_concurrencyLimit 3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example555668650/goprocess/gp.go
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Chandef output;
	int i;
	int pss = findAll_pss;
	Chandef input;
	Wgdef wg;
	int concurrencyLimit = findAll_concurrencyLimit;
	bool state = false;
	
	if
	:: pss > 0 -> 
		input.size = pss;
		run emptyChan(input)
	:: else -> 
		run sync_monitor(input)
	fi;
	
	if
	:: pss > 0 -> 
		output.size = pss;
		run emptyChan(output)
	:: else -> 
		run sync_monitor(output)
	fi;
		for(i : 0.. pss-1) {
for10:		
		if
		:: input.async_send!0;
		:: input.sync!0 -> 
			input.sending?0
		fi
	};
	input.closing!true;
	run wgMonitor(wg);
	wg.Add!concurrencyLimit;
		for(i : 0.. concurrencyLimit-1) {
for20:		run Anonymous0(input,output,wg)
	};
for20_exit:	wg.Wait?0;
	output.closing!true;
	do
	:: output.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: output.async_rcv?0;
			:: output.sync?0;
			fi
		fi
	od;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef input;Chandef output;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: input.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: input.async_rcv?0;
			:: input.sync?0;
			fi;
			
			if
			:: output.async_send!0;
			:: output.sync!0 -> 
				output.sending?0
			fi
		fi
	od;
stop_process:	wg.Add!-1
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: wg.Add?i -> 
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 -> 
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
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


