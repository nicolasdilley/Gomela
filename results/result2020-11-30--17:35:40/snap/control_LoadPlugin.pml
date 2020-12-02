#define lb_for663_0  -1
#define ub_for663_1  -1

// /tmp/clone-example436708666/control/plugin_manager.go
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
	int i;
	Chandef resultChan;
	bool state = false;
	run sync_monitor(resultChan);
	run Anonymous0(resultChan);
	do
	:: true -> 
		goto stop_process
	od
stop_process:}

proctype Anonymous0(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
for40_exit:stop_process:
}
proctype Anonymous0(Chandef resultChan) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
				for(i : 0.. lPlugin_Details_Exec-1) {
for10:
		};
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	fi;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
						for(i : 0.. lPlugin_ConfigPolicy_GetAll51129-1) {
for20:				
				if
				:: true -> 
										for(i : 0.. errs_Errors51427-1) {
for21:
					};
					
					if
					:: resultChan.async_send!0;
					:: resultChan.sync!0 -> 
						resultChan.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			};
			
			if
			:: true -> 
				
				if
				:: resultChan.async_send!0;
				:: resultChan.sync!0 -> 
					resultChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
				for(i : 0.. metricTypes-1) {
for30:			
			if
			:: true -> 
				
				if
				:: resultChan.async_send!0;
				:: resultChan.sync!0 -> 
					resultChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: resultChan.async_send!0;
				:: resultChan.sync!0 -> 
					resultChan.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		}
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: resultChan.async_send!0;
			:: resultChan.sync!0 -> 
				resultChan.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: resultChan.async_send!0;
		:: resultChan.sync!0 -> 
			resultChan.sending?0
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		run Anonymous0(resultChan)
	:: true;
	fi;
	
	if
	:: resultChan.async_send!0;
	:: resultChan.sync!0 -> 
		resultChan.sending?0
	fi;
	goto stop_process;
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
