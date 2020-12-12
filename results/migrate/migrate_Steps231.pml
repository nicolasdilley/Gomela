#define Steps_m_PrefetchMigrations  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example206543662/migrate.go
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
	bool state = false;
	int m_PrefetchMigrations = Steps_m_PrefetchMigrations;
	Chandef ret;
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
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: m_PrefetchMigrations > 0 -> 
		ret.size = m_PrefetchMigrations;
		run AsyncChan(ret)
	:: else -> 
		run sync_monitor(ret)
	fi;
	
	if
	:: true -> 
		run go_readUp(ret)
	:: true -> 
		run go_readDown(ret)
	:: true -> 
		run go_readDown(ret)
	fi;
	goto stop_process
stop_process:}

proctype go_readUp(Chandef ret) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: ret.async_send!0;
		:: ret.sync!0 -> 
			ret.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : lb_for522_1.. ub_for522_2) {
for10:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi;
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
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ret.async_send!0;
		:: ret.sync!0 -> 
			ret.sending?0
		fi
	};
for10_exit:stop_process:	ret.closing!true
}
proctype go_readDown(Chandef ret) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi;
			goto stop_process
		:: true;
		fi
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: ret.async_send!0;
		:: ret.sync!0 -> 
			ret.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: ret.async_send!0;
		:: ret.sync!0 -> 
			ret.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: ret.async_send!0;
		:: ret.sync!0 -> 
			ret.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
		for(i : lb_for626_1.. ub_for626_2) {
for20:		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: ret.async_send!0;
					:: ret.sync!0 -> 
						ret.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: true -> 
					
					if
					:: ret.async_send!0;
					:: ret.sync!0 -> 
						ret.sending?0
					fi;
					goto stop_process
				:: true;
				fi;
				
				if
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi
			:: true;
			fi;
			
			if
			:: true -> 
				
				if
				:: ret.async_send!0;
				:: ret.sync!0 -> 
					ret.sending?0
				fi
			:: true;
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: true -> 
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi;
			goto stop_process
		:: true;
		fi;
		
		if
		:: ret.async_send!0;
		:: ret.sync!0 -> 
			ret.sending?0
		fi
	};
for20_exit:stop_process:	ret.closing!true
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

