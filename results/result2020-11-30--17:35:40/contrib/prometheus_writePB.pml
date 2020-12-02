#define writePB_r_collectorsByID  0

// /tmp/clone-example467569462/service-loadbalancer/Godeps/_workspace/src/github.com/prometheus/client_golang/prometheus/registry.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	int i;
	int r_metricFamilyInjectionHook47122 = -2;
	Chandef metricChan;
	int r_collectorsByID = writePB_r_collectorsByID;
	int mf_Metric = -2;
	bool state = false;
	
	if
	:: 1000 > 0 -> 
		metricChan.size = 1000;
		run AsyncChan(metricChan)
	:: else -> 
		run sync_monitor(metricChan)
	fi;
	run wgMonitor(wg);
	wg.Add!r_collectorsByID;
	run Anonymous0(metricChan,wg);
	do
	:: metricChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: metricChan.async_rcv?0;
			:: metricChan.sync?0;
			fi;
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				break
			fi;
			
			if
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		fi
	od;
	
	if
	:: true -> 
				for(i : 0.. r_metricFamilyInjectionHook47122-1) {
for40:			
			if
			:: true -> 
				
				if
				:: true -> 
										for(i : 0.. mf_Metric-1) {
for41:						
						if
						:: true -> 
							goto stop_process
						:: true;
						fi
					}
				:: true;
				fi
			:: true;
			fi;
						for(i : 0.. mf_Metric-1) {
for42:				
				if
				:: true -> 
					
					if
					:: true -> 
						goto stop_process
					:: true;
					fi
				:: true;
				fi
			}
		}
	:: true;
	fi;
	goto stop_process;
	do
	:: metricChan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			
			if
			:: metricChan.async_rcv?0;
			:: metricChan.sync?0;
			fi
		fi
	od
stop_process:}

proctype Anonymous0(Chandef metricChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	metricChan.closing!true;
stop_process:
}
proctype collectorCollect(Chandef ch;chan child) {
	bool closed; 
	int i;
	bool state;
stop_process:	child!0
}
proctype Anonymous1(Chandef metricChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	chan child_collectorCollect0 = [0] of {int};
	run collectorCollect(metricChan,child_collectorCollect0);
	child_collectorCollect0?0;
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
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
		  :: ch.sending!false;  // sending channel is open
		fi;
	fi;
fi;
od;
}

proctype sync_monitor(Chandef ch) {
do
:: true
if
:: ch.closed ->
end: if
  :: ch.async_send?0-> // cannot send on closed channel
    assert(false)
  :: ch.closing?true -> // cannot close twice a channel
    assert(false)
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}
