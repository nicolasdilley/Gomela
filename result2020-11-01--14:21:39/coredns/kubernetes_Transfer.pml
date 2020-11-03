#define Transfer_serviceList  ??
#define Transfer_svc_Ports  ??
#define Transfer_endpointsList  ??
#define Transfer_ep_Subsets  ??
#define Transfer_eps_Addresses  ??
#define Transfer_eps_Ports  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example022390051/plugin/kubernetes/xfr.go
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



init { 
	int eps_Ports = Transfer_eps_Ports;
	int svc_Ports = Transfer_svc_Ports;
	Chandef ch;
	int ep_Subsets = Transfer_ep_Subsets;
	bool state = false;
	int serviceList = Transfer_serviceList;
	int endpointsList = Transfer_endpointsList;
	int eps_Addresses = Transfer_eps_Addresses;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(ch);
	run Anonymous0(ch);
	goto stop_process
stop_process:}

proctype kubernetesemitAddressRecord(Chandef c;chan child) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		
		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi;
		goto stop_process
	:: true -> 
		
		if
		:: c.async_send!0;
		:: c.sync!0 -> 
			c.sending?0
		fi;
		goto stop_process
	fi;
	goto stop_process;
stop_process:	child!0
}
proctype Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		ch.closing!true;
		goto stop_process
	:: true;
	fi;
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
		for(i : 0.. serviceList-1) {
for10:		

		if
		:: true -> 
			
			if
			:: true -> 
				chan child_kubernetesemitAddressRecord0 = [0] of {int};
				run kubernetesemitAddressRecord(ch,child_kubernetesemitAddressRecord0);
				child_kubernetesemitAddressRecord0?0;
								for(i : 0.. svc_Ports-1) {
for11:					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi;
					
					if
					:: ch.async_send!0;
					:: ch.sync!0 -> 
						ch.sending?0
					fi
				}
			:: true;
			fi;
						for(i : 0.. endpointsList-1) {
for12:								for(i : 0.. ep_Subsets-1) {
for13:										for(i : 0.. eps_Addresses-1) {
for14:						chan child_kubernetesemitAddressRecord1 = [0] of {int};
						run kubernetesemitAddressRecord(ch,child_kubernetesemitAddressRecord1);
						child_kubernetesemitAddressRecord1?0;
						chan child_kubernetesemitAddressRecord2 = [0] of {int};
						run kubernetesemitAddressRecord(ch,child_kubernetesemitAddressRecord2);
						child_kubernetesemitAddressRecord2?0;
												for(i : 0.. eps_Ports-1) {
for15:							
							if
							:: ch.async_send!0;
							:: ch.sync!0 -> 
								ch.sending?0
							fi
						}
					}
				}
			}
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi
			:: true;
			fi
		fi
	};
	
	if
	:: ch.async_send!0;
	:: ch.sync!0 -> 
		ch.sending?0
	fi;
	ch.closing!true;
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

