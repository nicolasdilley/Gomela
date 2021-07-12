// num_comm_params=1
// num_mand_comm_params=0
// num_opt_comm_params=1

// git_link=https://github.com/traefik/traefik/blob/080cf98e512f6fcb93838de76a6aa34ff147dee4/pkg/provider/aggregator/aggregator_test.go#L14
#define not_found_36  -2 // opt not_found_36
#define not_found_39  -2 // opt not_found_39
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_TestProviderAggregator_Provide140 = [1] of {int};
	run TestProviderAggregator_Provide14(child_TestProviderAggregator_Provide140);
	run receiver(child_TestProviderAggregator_Provide140)
stop_process:skip
}

proctype TestProviderAggregator_Provide14(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_requireReceivedMessageFromProviders462 = [1] of {int};
	chan child_requireReceivedMessageFromProviders461 = [1] of {int};
	chan child_AnonymousTestProviderAggregator_Provide31250 = [1] of {int};
	Wgdef pool_waitGroup;
	Chandef errCh_ch;
	Chandef cfgCh_ch;
	run sync_monitor(cfgCh_ch);
	run sync_monitor(errCh_ch);
	run wgMonitor(pool_waitGroup);
	run AnonymousTestProviderAggregator_Provide3125(cfgCh_ch,errCh_ch,pool_waitGroup,child_AnonymousTestProviderAggregator_Provide31250);
	run receiver(child_AnonymousTestProviderAggregator_Provide31250);
	run requireReceivedMessageFromProviders46(cfgCh_ch,not_found_36,child_requireReceivedMessageFromProviders461);
	child_requireReceivedMessageFromProviders461?0;
	run requireReceivedMessageFromProviders46(cfgCh_ch,not_found_39,child_requireReceivedMessageFromProviders462);
	child_requireReceivedMessageFromProviders462?0;
	

	if
	:: errCh_ch.deq?state,num_msgs;
	:: errCh_ch.sync?state -> 
		errCh_ch.rcving!false
	fi;
	stop_process: skip;
	child!0
}
proctype AnonymousTestProviderAggregator_Provide3125(Chandef cfgCh_ch;Chandef errCh_ch;Wgdef pool_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provide1210 = [1] of {int};
	run Provide121(cfgCh_ch,pool_waitGroup,child_Provide1210);
	child_Provide1210?0;
	

	if
	:: errCh_ch.enq!0;
	:: errCh_ch.sync!false -> 
		errCh_ch.sending!false
	fi;
	stop_process: skip;
	child!0
}
proctype Provide121(Chandef configurationChan_ch;Wgdef pool_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_launchProvider1421 = [1] of {int};
	chan child_launchProvider1420 = [1] of {int};
	int var_p_providersp_providers = -2; // opt var_p_providersp_providers
	

	if
	:: true -> 
		run launchProvider142(configurationChan_ch,pool_waitGroup,child_launchProvider1420);
		child_launchProvider1420?0
	:: true;
	fi;
	

	if
	:: true -> 
		run launchProvider142(configurationChan_ch,pool_waitGroup,child_launchProvider1421);
		child_launchProvider1421?0
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype launchProvider142(Chandef configurationChan_ch;Wgdef pool_waitGroup;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Provide1210 = [1] of {int};
	run Provide121(configurationChan_ch,pool_waitGroup,child_Provide1210);
	child_Provide1210?0;
	stop_process: skip;
	child!0
}
proctype requireReceivedMessageFromProviders46(Chandef cfgCh_ch;int names;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: var_names-1 != -3 -> 
				for(i : 0.. var_names-1) {
			for20: skip;
			do
			:: true -> 
				break
			:: cfgCh_ch.deq?state,num_msgs -> 
				break
			:: cfgCh_ch.sync?state -> 
				cfgCh_ch.rcving!false;
				break
			od;
			for21_exit: skip;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for22: skip;
			do
			:: true -> 
				break
			:: cfgCh_ch.deq?state,num_msgs -> 
				break
			:: cfgCh_ch.sync?state -> 
				cfgCh_ch.rcving!false;
				break
			od;
			for23_exit: skip;
			for22_end: skip
		:: true -> 
			break
		od;
		for22_exit: skip
	fi;
	stop_process: skip;
	child!0
}

 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
proctype AsyncChan(Chandef ch) {
do
:: true ->
if
:: ch.closed -> 
end: if
  :: ch.num_msgs > 0 -> // cannot send on closed channel
    end4: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.deq!true,ch.num_msgs -> 
  		 ch.num_msgs = ch.num_msgs - 1
    fi;
  :: else ->    end5: if
    :: ch.enq?0-> // cannot send on closed channel
      assert(1 == 0)
    :: ch.closing?true -> // cannot close twice a channel
      assert(2 == 0)
    :: ch.rcving?false;
    :: ch.sending?false -> // sending state of channel (closed)
      assert(1 == 0)
    :: ch.sync!true; 
    fi;
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}

proctype receiver(chan c) {
c?0
}

