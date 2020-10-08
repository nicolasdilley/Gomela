#define lb_for265_0  -1
#define ub_for265_1  -1
#define lb_for345_2  -1
#define ub_for345_3  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example942100504/staging/src/k8s.io/kubectl/pkg/drain/drain.go
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
	int i;
	Chandef returnCh;
	bool state = false;
	
	if
	:: 1 > 0 -> 
		returnCh.size = 1;
		run emptyChan(returnCh)
	:: else -> 
		run sync_monitor(returnCh)
	fi;
		for(i : 1.. pods) {
for10:		run Anonymous0(returnCh)
	};
	
	if
	:: lb_for345_2 != -1 && ub_for345_3 != -1 -> 
				for(i : lb_for345_2.. ub_for345_3) {
for20:			do
			:: true -> 
				break
			od
		}
	:: else -> 
		do
		:: true -> 
for20:			do
			:: true -> 
				break
			od
		:: true -> 
			break
		od
	fi;
for20_exit:	goto stop_process
stop_process:}

proctype Anonymous0(Chandef returnCh) {
	bool closed; 
	int i;
	do
	:: true -> 
for11:		

		if
		:: true;
		:: true;
		fi;
		do
		:: true -> 
			
			if
			:: returnCh.async_send!0;
			:: returnCh.sync!0 -> 
				returnCh.sending?0
			fi;
			goto stop_process
		:: true -> 
			break
		od;
		
		if
		:: true -> 
			break
		:: true -> 
			
			if
			:: true -> 
				
				if
				:: returnCh.async_send!0;
				:: returnCh.sync!0 -> 
					returnCh.sending?0
				fi;
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					
					if
					:: true -> 
						break
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: returnCh.async_send!0;
							:: returnCh.sync!0 -> 
								returnCh.sending?0
							fi;
							goto stop_process
						:: true -> 
							
							if
							:: returnCh.async_send!0;
							:: returnCh.sync!0 -> 
								returnCh.sending?0
							fi;
							goto stop_process
						fi
					fi
				fi
			fi
		fi
	od;
for11_exit:	
	if
	:: true -> 
		
		if
		:: returnCh.async_send!0;
		:: returnCh.sync!0 -> 
			returnCh.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: returnCh.async_send!0;
		:: returnCh.sync!0 -> 
			returnCh.sending?0
		fi
	:: true -> 
		
		if
		:: returnCh.async_send!0;
		:: returnCh.sync!0 -> 
			returnCh.sending?0
		fi
	:: true -> 
		
		if
		:: returnCh.async_send!0;
		:: returnCh.sync!0 -> 
			returnCh.sending?0
		fi
	fi;
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

