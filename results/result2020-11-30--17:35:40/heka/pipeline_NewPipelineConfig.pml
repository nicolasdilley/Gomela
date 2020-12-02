#define NewPipelineConfig_globals_PluginChanSize  0
#define NewPipelineConfig_globals_PoolSize  1

// /tmp/clone-example569798719/pipeline/config.go
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
	int globals_PluginChanSize = NewPipelineConfig_globals_PluginChanSize;
	Wgdef config_inputsWg;
	Wgdef config_filtersWg;
	Chandef config_injectRecycleChan;
	int i;
	Wgdef config_decodersWg;
	Chandef config_inputRecycleChan;
	Chandef config_reportRecycleChan;
	int globals_PoolSize = NewPipelineConfig_globals_PoolSize;
	bool state = false;
	run wgMonitor(config_filtersWg);
	run wgMonitor(config_decodersWg);
	run wgMonitor(config_inputsWg);
	
	if
	:: globals_PoolSize > 0 -> 
		config_inputRecycleChan.size = globals_PoolSize;
		run AsyncChan(config_inputRecycleChan)
	:: else -> 
		run sync_monitor(config_inputRecycleChan)
	fi;
	
	if
	:: globals_PoolSize > 0 -> 
		config_injectRecycleChan.size = globals_PoolSize;
		run AsyncChan(config_injectRecycleChan)
	:: else -> 
		run sync_monitor(config_injectRecycleChan)
	fi;
	
	if
	:: 1 > 0 -> 
		config_reportRecycleChan.size = 1;
		run AsyncChan(config_reportRecycleChan)
	:: else -> 
		run sync_monitor(config_reportRecycleChan)
	fi;
	goto stop_process
stop_process:}

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
