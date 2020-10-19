#define Migrate_m_PrefetchMigrations  60
#define lb_for440_1  -1
#define ub_for440_2  -1
#define lb_for465_3  -1
#define ub_for465_4  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example396291914/migrate.go
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
	int m_PrefetchMigrations = Migrate_m_PrefetchMigrations;
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
	:: m_PrefetchMigrations > 0 -> 
		ret.size = m_PrefetchMigrations;
		run emptyChan(ret)
	:: else -> 
		run sync_monitor(ret)
	fi;
	run go_mread(ret);
	goto stop_process
stop_process:}

proctype go_mread(Chandef ret) {
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
				for(i : lb_for440_1.. ub_for440_2) {
for10:			
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
			fi;
			
			if
			:: ret.async_send!0;
			:: ret.sync!0 -> 
				ret.sending?0
			fi
		};
for10_exit:
	:: true -> 
				for(i : lb_for465_3.. ub_for465_4) {
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
				fi;
				goto stop_process
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
for20_exit:
	:: true -> 
				for(i : lb_for465_3.. ub_for465_4) {
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
				fi;
				goto stop_process
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
for20_exit:
	fi;
	ret.closing!true;
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

