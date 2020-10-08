#define lb_for67_0  -1
#define ub_for67_1  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example535250945/pt/renderer.go
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
	int samples = 5;
	int ncpu = 5;
	Chandef ch;
	int sppRoot = 5;
	int i;
	int h = 5;
	int w = 5;
	int spp = 5;
	int r_FireflySamples = 5;
	bool state = false;
	
	if
	:: h > 0 -> 
		ch.size = h;
		run emptyChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. ncpu-1) {
for10:		run Anonymous0(ch)
	};
for10_exit:	
	if
	:: 0 != -1 && h-1 != -1 -> 
				for(i : 0.. h-1) {
for20:			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		}
	:: else -> 
		do
		:: true -> 
for20:			
			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi
		:: true -> 
			break
		od
	fi;
for20_exit:
stop_process:}

proctype Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	
	if
	:: lb_for67_0 != -1 && ub_for67_1 != -1 -> 
				for(i : lb_for67_0.. ub_for67_1) {
for11:			
			if
			:: 0 != -1 && w-1 != -1 -> 
								for(i : 0.. w-1) {
for12:					
					if
					:: true -> 
						
						if
						:: 0 != -1 && sppRoot-1 != -1 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							}
						:: else -> 
							do
							:: true -> 
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							:: true -> 
								break
							od
						fi;
for13_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					fi;
					
					if
					:: true -> 
						
						if
						:: 0 != -1 && samples-1 != -1 -> 
														for(i : 0.. samples-1) {
for16:
							}
						:: else -> 
							do
							:: true -> 
for16:
							:: true -> 
								break
							od
						fi;
for16_exit:
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: 0 != -1 && r_FireflySamples-1 != -1 -> 
																for(i : 0.. r_FireflySamples-1) {
for17:
								}
							:: else -> 
								do
								:: true -> 
for17:
								:: true -> 
									break
								od
							fi;
for17_exit:
						:: true;
						fi
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					
					if
					:: true -> 
						
						if
						:: 0 != -1 && sppRoot-1 != -1 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							}
						:: else -> 
							do
							:: true -> 
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							:: true -> 
								break
							od
						fi;
for13_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					fi;
					
					if
					:: true -> 
						
						if
						:: 0 != -1 && samples-1 != -1 -> 
														for(i : 0.. samples-1) {
for16:
							}
						:: else -> 
							do
							:: true -> 
for16:
							:: true -> 
								break
							od
						fi;
for16_exit:
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: 0 != -1 && r_FireflySamples-1 != -1 -> 
																for(i : 0.. r_FireflySamples-1) {
for17:
								}
							:: else -> 
								do
								:: true -> 
for17:
								:: true -> 
									break
								od
							fi;
for17_exit:
						:: true;
						fi
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi
		}
	:: else -> 
		do
		:: true -> 
for11:			
			if
			:: 0 != -1 && w-1 != -1 -> 
								for(i : 0.. w-1) {
for12:					
					if
					:: true -> 
						
						if
						:: 0 != -1 && sppRoot-1 != -1 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							}
						:: else -> 
							do
							:: true -> 
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							:: true -> 
								break
							od
						fi;
for13_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					fi;
					
					if
					:: true -> 
						
						if
						:: 0 != -1 && samples-1 != -1 -> 
														for(i : 0.. samples-1) {
for16:
							}
						:: else -> 
							do
							:: true -> 
for16:
							:: true -> 
								break
							od
						fi;
for16_exit:
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: 0 != -1 && r_FireflySamples-1 != -1 -> 
																for(i : 0.. r_FireflySamples-1) {
for17:
								}
							:: else -> 
								do
								:: true -> 
for17:
								:: true -> 
									break
								od
							fi;
for17_exit:
						:: true;
						fi
					:: true;
					fi
				}
			:: else -> 
				do
				:: true -> 
for12:					
					if
					:: true -> 
						
						if
						:: 0 != -1 && sppRoot-1 != -1 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							}
						:: else -> 
							do
							:: true -> 
for13:								
								if
								:: 0 != -1 && sppRoot-1 != -1 -> 
																		for(i : 0.. sppRoot-1) {
for14:
									}
								:: else -> 
									do
									:: true -> 
for14:
									:: true -> 
										break
									od
								fi;
for14_exit:
							:: true -> 
								break
							od
						fi;
for13_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					:: true -> 
						
						if
						:: 0 != -1 && spp-1 != -1 -> 
														for(i : 0.. spp-1) {
for15:
							}
						:: else -> 
							do
							:: true -> 
for15:
							:: true -> 
								break
							od
						fi;
for15_exit:
					fi;
					
					if
					:: true -> 
						
						if
						:: 0 != -1 && samples-1 != -1 -> 
														for(i : 0.. samples-1) {
for16:
							}
						:: else -> 
							do
							:: true -> 
for16:
							:: true -> 
								break
							od
						fi;
for16_exit:
					:: true;
					fi;
					
					if
					:: true -> 
						
						if
						:: true -> 
							
							if
							:: 0 != -1 && r_FireflySamples-1 != -1 -> 
																for(i : 0.. r_FireflySamples-1) {
for17:
								}
							:: else -> 
								do
								:: true -> 
for17:
								:: true -> 
									break
								od
							fi;
for17_exit:
						:: true;
						fi
					:: true;
					fi
				:: true -> 
					break
				od
			fi;
for12_exit:			
			if
			:: ch.async_send!0;
			:: ch.sync!0 -> 
				ch.sending?0
			fi
		:: true -> 
			break
		od
	fi;
for11_exit:stop_process:
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

