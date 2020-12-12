#define CollectMetrics_pluginToMetricMap  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example690713090/control/control.go
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
	Chandef cMetrics;
	int pluginToMetricMap = CollectMetrics_pluginToMetricMap;
	Wgdef wg;
	bool state = false;
	Chandef cError;
	int serrs = -2;
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
				for(i : 0.. serrs-1) {
for10:
		}
	:: true;
	fi;
	run sync_monitor(cMetrics);
	run sync_monitor(cError);
	run wgMonitor(wg);
		for(i : 0.. pluginToMetricMap-1) {
for30:		wg.Add!1;
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
	bool state;
	
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
	bool state;
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
			do
			:: true -> 
for41:
			:: true -> 
				break
			od;
			wg.Add!-1
		fi
	od;
stop_process:
}
proctype Anonymous2(Chandef cMetrics;Chandef cError;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
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

