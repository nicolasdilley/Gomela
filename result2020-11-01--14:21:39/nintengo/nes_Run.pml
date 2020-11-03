#define Run_audio_buffers 0
#define Run_pbuffers 3
#define lb_for82_2  -1
#define ub_for82_3  -1
#define lb_for127_4  -1
#define ub_for127_5  -1
#define lb_for133_6  -1
#define ub_for133_7  -1
#define lb_for149_8  -1
#define ub_for149_9  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example027857545/nes/azul3d_audio.go
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
	int audio_buffers = Run_audio_buffers;
	Chandef schan;
	int pbuffers = Run_pbuffers;
	bool state = false;
	
	if
	:: audio_buffers > 0 -> 
		schan.size = audio_buffers;
		run emptyChan(schan)
	:: else -> 
		run sync_monitor(schan)
	fi;
	run go_audiostream(schan);
	
	if
	:: lb_for127_4 != -1 && ub_for127_5 != -1 -> 
				for(i : lb_for127_4.. ub_for127_5) {
for20:			
			if
			:: schan.async_rcv?0;
			:: schan.sync?0;
			fi;
			do
			:: true -> 
for21:				
				if
				:: true -> 
					break
				:: true;
				fi
			od;
for21_exit:			
			if
			:: true -> 
				
				if
				:: lb_for149_8 != -1 && ub_for149_9 != -1 -> 
										for(i : lb_for149_8.. ub_for149_9) {
for22:						
						if
						:: true -> 
							break
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for22:						
						if
						:: true -> 
							break
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for22_exit:
			:: true;
			fi;
						for(i : 0.. pbuffers-1) {
for23:				
				if
				:: true -> 
					
					if
					:: schan.async_rcv?0;
					:: schan.sync?0;
					fi
				:: true;
				fi
			}
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: schan.async_rcv?0;
			:: schan.sync?0;
			fi;
			do
			:: true -> 
for21:				
				if
				:: true -> 
					break
				:: true;
				fi
			od;
for21_exit:			
			if
			:: true -> 
				
				if
				:: lb_for149_8 != -1 && ub_for149_9 != -1 -> 
										for(i : lb_for149_8.. ub_for149_9) {
for22:						
						if
						:: true -> 
							break
						:: true;
						fi
					}
				:: else -> 
					do
					:: true -> 
for22:						
						if
						:: true -> 
							break
						:: true;
						fi
					:: true -> 
						break
					od
				fi;
for22_exit:
			:: true;
			fi;
						for(i : 0.. pbuffers-1) {
for23:				
				if
				:: true -> 
					
					if
					:: schan.async_rcv?0;
					:: schan.sync?0;
					fi
				:: true;
				fi
			}
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype go_audiostream(Chandef schan) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for10:		
		if
		:: true -> 
			
			if
			:: schan.async_send!0;
			:: schan.sync!0 -> 
				schan.sending?0
			fi
		:: true;
		fi
	od;
for10_exit:stop_process:
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


