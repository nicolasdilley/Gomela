#define run_h  0
#define run_ncpu  1
#define lb_for67_2  -1
#define ub_for67_3  -1

// /tmp/clone-example836832586/pt/renderer.go
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
	int h = run_h;
	Chandef ch;
	int ncpu = run_ncpu;
	bool state = false;
	
	if
	:: h > 0 -> 
		ch.size = h;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
for10_exit:	
	if
	:: 0 != -2 && h-1 != -3 -> 
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
	bool state;
	
	if
	:: lb_for67_2 != -2 && ub_for67_3 != -2 -> 
				for(i : lb_for67_2.. ub_for67_3) {
for11:			
			if
			:: 0 != -2 && w-1 != -3 -> 
								for(i : 0.. w-1) {
for12:					
					if
					:: true -> 
						
						if
						:: 0 != -2 && sppRoot-1 != -3 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && samples-1 != -3 -> 
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
							:: 0 != -2 && r_FireflySamples-1 != -3 -> 
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
						:: 0 != -2 && sppRoot-1 != -3 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && samples-1 != -3 -> 
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
							:: 0 != -2 && r_FireflySamples-1 != -3 -> 
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
			:: 0 != -2 && w-1 != -3 -> 
								for(i : 0.. w-1) {
for12:					
					if
					:: true -> 
						
						if
						:: 0 != -2 && sppRoot-1 != -3 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && samples-1 != -3 -> 
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
							:: 0 != -2 && r_FireflySamples-1 != -3 -> 
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
						:: 0 != -2 && sppRoot-1 != -3 -> 
														for(i : 0.. sppRoot-1) {
for13:								
								if
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
								:: 0 != -2 && sppRoot-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && spp-1 != -3 -> 
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
						:: 0 != -2 && samples-1 != -3 -> 
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
							:: 0 != -2 && r_FireflySamples-1 != -3 -> 
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

