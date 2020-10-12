#define lb_for153_0  -1
#define ub_for153_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example487246790/util/exec_util.go
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
	Wgdef wg;
	int i;
	Chandef errChan;
	bool state = false;
	run wgMonitor(wg);
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				fi
			:: true -> 
				
				if
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				:: true -> 
					wg.Add!1;
					
					if
					:: true -> 
						run go_utilChannelToLineWriter(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					:: true -> 
						run go_utilLineReaderToChannel(wg)
					fi
				fi
			fi
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(errChan);
	run Anonymous2(errChan,wg);
	do
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype go_utilChannelToLineWriter(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!-1;
stop_process:
}
proctype go_utilLineReaderToChannel(Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: lb_for153_0 != -1 && ub_for153_1 != -1 -> 
				for(i : lb_for153_0.. ub_for153_1) {
for10:						for(i : 1.. parts) {
for11:
			}
		}
	:: else -> 
		do
		:: true -> 
for10:						for(i : 1.. parts) {
for11:
			}
		:: true -> 
			break
		od
	fi;
for10_exit:	wg.Add!-1;
stop_process:
}
proctype Anonymous2(Chandef errChan;Wgdef wg) {
	bool closed; 
	int i;
	wg.Wait?0;
	
	if
	:: errChan.async_send!0;
	:: errChan.sync!0 -> 
		errChan.sending?0
	fi;
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
