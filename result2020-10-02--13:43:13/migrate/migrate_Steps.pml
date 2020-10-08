#define lb_for522_0  -1
#define ub_for522_1  -1
#define lb_for626_2  -1
#define ub_for626_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example982078547/migrate.go
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
	bool state = false;
	int m_PrefetchMigrations = 5;
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
		run emptyChan(ret)
	:: else -> 
		run sync_monitor(ret)
	fi;
	
	if
	:: true -> 
		run go_mreadUp(ret)
	:: true -> 
		run go_mreadDown(ret)
	:: true -> 
		run go_mreadDown(ret)
	fi;
	goto stop_process
stop_process:}

proctype go_mreadUp(Chandef ret) {
	bool closed; 
	int i;
	
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
		for(i : lb_for522_0.. ub_for522_1) {
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
for10_exit:	ret.closing!true;
stop_process:
}
proctype go_mreadDown(Chandef ret) {
	bool closed; 
	int i;
	
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
		for(i : lb_for626_2.. ub_for626_3) {
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
for20_exit:	ret.closing!true;
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

