#define lb_for262_0  -1
#define ub_for262_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example326115153/lang/funcs/funcs.go
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
	bool state = false;
	Chandef output;
	Chandef errch;
	Chandef close2;
	Wgdef wg;
	Chandef input;
	Chandef close1;
	int i;
	
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
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	run sync_monitor(errch);
	run sync_monitor(input);
	run sync_monitor(output);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(close1);
	run sync_monitor(close2);
	wg.Add!1;
	run Anonymous0(errch,input,output,close1,close2);
	wg.Add!1;
	run Anonymous1(errch,input,output,close1,close2);
	wg.Add!1;
	run Anonymous2(errch,input,output,close1,close2);
Loop:		do
	:: true -> 
for20:		do
		od
	od;
for20_exit:;
	
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
	goto stop_process;
	wg.Wait?0
stop_process:}

proctype Anonymous0(Chandef errch;Chandef input;Chandef output;Chandef close1;Chandef close2) {
	bool closed; 
	int i;
	do
	:: close1.async_rcv?0 -> 
		break
	:: close1.sync?0 -> 
		break
	od;
	do
	:: close2.async_rcv?0 -> 
		break
	:: close2.sync?0 -> 
		break
	od;
	errch.closing!true;
stop_process:
}
proctype Anonymous1(Chandef errch;Chandef input;Chandef output;Chandef close1;Chandef close2) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: errch.async_send!0 -> 
		break
	:: errch.sync!0 -> 
		errch.sending?0;
		break
	od;
	close1.closing!true;
stop_process:
}
proctype Anonymous2(Chandef errch;Chandef input;Chandef output;Chandef close1;Chandef close2) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 1.. args) {
for10:		
		if
		:: true -> 
			do
			:: errch.async_send!0 -> 
				break
			:: errch.sync!0 -> 
				errch.sending?0;
				break
			od;
			goto stop_process
		:: true;
		fi
	};
	do
	:: input.async_send!0 -> 
		break
	:: input.sync!0 -> 
		input.sending?0;
		break
	:: close1.async_rcv?0 -> 
		do
		:: errch.async_send!0 -> 
			break
		:: errch.sync!0 -> 
			errch.sending?0;
			break
		od;
		break
	:: close1.sync?0 -> 
		do
		:: errch.async_send!0 -> 
			break
		:: errch.sync!0 -> 
			errch.sending?0;
			break
		od;
		break
	od;
	close2.closing!true;
	input.closing!true;
stop_process:
}
proctype wgMonitor(Wgdef wg) {
	bool closed; 
	int i;
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
	od;
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

