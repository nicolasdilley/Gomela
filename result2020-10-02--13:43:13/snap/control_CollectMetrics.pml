
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example216211706/control/control.go
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
	int pluginToMetricMap = 5;
	Chandef cError;
	bool state = false;
	int serrs = 5;
	int m = 5;
	Chandef cMetrics;
	Wgdef wg;
	int nsTags = 5;
	int pmt_metricTypes = 5;
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
				for(i : 1.. serrs) {
for10:
		}
	:: true;
	fi;
		for(i : 1.. allTags) {
for20:				for(i : 1.. nsTags) {
for21:
		}
	};
	run sync_monitor(cMetrics);
	run sync_monitor(cError);
	run wgMonitor(wg);
		for(i : 1.. pluginToMetricMap) {
for30:				for(i : 1.. pmt_metricTypes) {
for31:
		};
		wg.Add!1;
		run Anonymous0(cMetrics,cError,wg)
	};
	run Anonymous1(cMetrics,cError,wg);
	run Anonymous2(cMetrics,cError,wg);
	wg.Wait?0;
	cMetrics.closing!true;
	cError.closing!true;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:}

proctype Anonymous0(Chandef cMetrics;Chandef cError;Wgdef wg) {
	bool closed; 
	int i;
	
	if
	:: true -> 
		
		if
		:: cError.async_send!0;
		:: cError.sync!0 -> 
			cError.sending?0
		fi
	:: true -> 
		
		if
		:: cMetrics.async_send!0;
		:: cMetrics.sync!0 -> 
			cMetrics.sending?0
		fi
	:: true -> 
		
		if
		:: cMetrics.async_send!0;
		:: cMetrics.sync!0 -> 
			cMetrics.sending?0
		fi
	fi;
stop_process:
}
proctype Anonymous1(Chandef cMetrics;Chandef cError;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: cMetrics.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: cMetrics.async_rcv?0;
			:: cMetrics.sync?0;
			fi;
						for(i : 1.. m) {
for41:
			};
			wg.Add!-1
		fi
	od;
stop_process:
}
proctype Anonymous2(Chandef cMetrics;Chandef cError;Wgdef wg) {
	bool closed; 
	int i;
	do
	:: cError.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: cError.async_rcv?0;
			:: cError.sync?0;
			fi;
			wg.Add!-1
		fi
	od;
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

