#define lb_for201_0  -1
#define ub_for201_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example592734163/converter/converter.go
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
	int convert_Config_Format = 5;
	int convert_ProcessNum = 5;
	int i;
	
	if
	:: true -> 
		Chandef convert_process;
		
		if
		:: 4 > 0 -> 
			convert_process.size = 4;
			run emptyChan(convert_process)
		:: else -> 
			run sync_monitor(convert_process)
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef convert_limitChan;
		
		if
		:: convert_ProcessNum > 0 -> 
			convert_limitChan.size = convert_ProcessNum;
			run emptyChan(convert_limitChan)
		:: else -> 
			run sync_monitor(convert_limitChan)
		fi;
		
		if
		:: 0 != -1 && convert_ProcessNum-1 != -1 -> 
						for(i : 0.. convert_ProcessNum-1) {
for10:				
				if
				:: convert_limitChan.async_send!0;
				:: convert_limitChan.sync!0 -> 
					convert_limitChan.sending?0
				fi
			}
		:: else -> 
			do
			:: true -> 
for10:				
				if
				:: convert_limitChan.async_send!0;
				:: convert_limitChan.sync!0 -> 
					convert_limitChan.sending?0
				fi
			:: true -> 
				break
			od
		fi;
for10_exit:
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
		
		if
		:: true -> 
			run Anonymous0(convert_process,convert_limitChan);
			Wgdef group;
			run wgMonitor(group);
						for(i : lb_for201_0.. ub_for201_1) {
for30:				
				if
				:: convert_process.async_rcv?0;
				:: convert_process.sync?0;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi;
				group.Add!1;
				
				if
				:: convert_limitChan.async_rcv?0;
				:: convert_limitChan.sync?0;
				fi;
				run Anonymous1(group,convert_process,convert_limitChan)
			};
for30_exit:			group.Wait?0
		fi
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef convert_process;Chandef convert_limitChan) {
	bool closed; 
	int i;
		for(i : 1.. convert_Config_Format) {
for20:		

		if
		:: true;
		:: true;
		:: true;
		:: true;
		fi
	};
stop_process:
}
proctype Anonymous1(Wgdef group;Chandef convert_process;Chandef convert_limitChan) {
	bool closed; 
	int i;
	group.Add!-1;
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

