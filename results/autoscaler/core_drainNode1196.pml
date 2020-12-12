#define drainNode_pods  ??
#define drainNode_daemonSetPods  ??
#define lb_for1250_2  -1
#define ub_for1250_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example220687980/cluster-autoscaler/core/scale_down.go
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



init { 
	int pods = drainNode_pods;
	Chandef confirmations;
	int i;
	Chandef daemonSetConfirmations;
	int daemonSetPods = drainNode_daemonSetPods;
	bool state = false;
	
	if
	:: pods > 0 -> 
		confirmations.size = pods;
		run AsyncChan(confirmations)
	:: else -> 
		run sync_monitor(confirmations)
	fi;
	
	if
	:: daemonSetPods > 0 -> 
		daemonSetConfirmations.size = daemonSetPods;
		run AsyncChan(daemonSetConfirmations)
	:: else -> 
		run sync_monitor(daemonSetConfirmations)
	fi;
	
	if
	:: 0 != -2 && pods + daemonSetPods-1 != -3 -> 
				for(i : 0.. pods + daemonSetPods-1) {
for30:			do
			:: confirmations.async_rcv?0 -> 
				break
			:: confirmations.sync?0 -> 
				break
			:: daemonSetConfirmations.async_rcv?0 -> 
				break
			:: daemonSetConfirmations.sync?0 -> 
				break
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for30:			do
			:: confirmations.async_rcv?0 -> 
				break
			:: confirmations.sync?0 -> 
				break
			:: daemonSetConfirmations.async_rcv?0 -> 
				break
			:: daemonSetConfirmations.sync?0 -> 
				break
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			od
		:: true -> 
			break
		od
	fi;
for30_exit:	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: lb_for1250_2 != -2 && ub_for1250_3 != -2 -> 
				for(i : lb_for1250_2.. ub_for1250_3) {
for50:						for(i : 0.. pods-1) {
for51:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		}
	:: else -> 
		do
		:: true -> 
for50:						for(i : 0.. pods-1) {
for51:				
				if
				:: true -> 
					break
				:: true;
				fi;
				
				if
				:: true -> 
					break
				:: true;
				fi
			};
			
			if
			:: true -> 
				goto stop_process
			:: true;
			fi
		:: true -> 
			break
		od
	fi;
for50_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef confirmations;Chandef daemonSetConfirmations) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: confirmations.async_send!0;
	:: confirmations.sync!0 -> 
		confirmations.sending?0
	fi;
stop_process:
}
proctype Anonymous1(Chandef confirmations;Chandef daemonSetConfirmations) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: daemonSetConfirmations.async_send!0;
	:: daemonSetConfirmations.sync!0 -> 
		daemonSetConfirmations.sending?0
	fi;
stop_process:
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

