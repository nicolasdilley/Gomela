#define lb_for29_0  -1
#define ub_for29_1  -1
#define lb_for82_2  -1
#define ub_for82_3  -1
#define lb_for119_4  -1
#define ub_for119_5  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example960382288/plugins/drivers/execstreaming.go
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
	Wgdef outWg;
	Chandef resize;
	int i;
	Chandef errCh;
	Chandef doneCh;
	bool state = false;
	
	if
	:: 2 > 0 -> 
		resize.size = 2;
		run emptyChan(resize)
	:: else -> 
		run sync_monitor(resize)
	fi;
	
	if
	:: 3 > 0 -> 
		errCh.size = 3;
		run emptyChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	run Anonymous0(resize,errCh,doneCh,outWg);
	run wgMonitor(outWg);
	outWg.Add!2;
	run Anonymous1(resize,errCh,doneCh,outWg);
	run Anonymous2(resize,errCh,doneCh,outWg);
	
	if
	:: 1 > 0 -> 
		doneCh.size = 1;
		run emptyChan(doneCh)
	:: else -> 
		run sync_monitor(doneCh)
	fi;
	run Anonymous3(resize,errCh,doneCh,outWg);
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef resize;Chandef errCh;Chandef doneCh;Wgdef outWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			goto stop_process
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					do
					:: resize.async_send!0 -> 
						break
					:: resize.sync!0 -> 
						resize.sending?0;
						break
					od
				:: true -> 
					
					if
					:: true -> 
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi
					:: true -> 
						
						if
						:: errCh.async_send!0;
						:: errCh.sync!0 -> 
							errCh.sending?0
						fi
					fi
				fi
			fi
		fi
	od;
for10_exit:stop_process:
}
proctype Anonymous1(Chandef resize;Chandef errCh;Chandef doneCh;Wgdef outWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for20:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				break
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			break
		:: true;
		fi
	od;
for20_exit:stop_process:	outWg.Add!-1
}
proctype Anonymous2(Chandef resize;Chandef errCh;Chandef doneCh;Wgdef outWg) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				break
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi
			:: true;
			fi;
			break
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: errCh.async_send!0;
			:: errCh.sync!0 -> 
				errCh.sending?0
			fi;
			break
		:: true;
		fi
	od;
for30_exit:stop_process:	outWg.Add!-1
}
proctype Anonymous3(Chandef resize;Chandef errCh;Chandef doneCh;Wgdef outWg) {
	bool closed; 
	int i;
	bool state;
	outWg.Wait?0;
	do
	:: errCh.async_rcv?0 -> 
		
		if
		:: doneCh.async_send!0;
		:: doneCh.sync!0 -> 
			doneCh.sending?0
		fi;
		break
	:: errCh.sync?0 -> 
		
		if
		:: doneCh.async_send!0;
		:: doneCh.sync!0 -> 
			doneCh.sending?0
		fi;
		break
	:: true -> 
		break
	od;
	doneCh.closing!true;
stop_process:
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

