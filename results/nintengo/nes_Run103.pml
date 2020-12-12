#define Run_audio_buffers  ??
#define lb_for127_1  -1
#define ub_for127_2  -1
#define lb_for133_3  -1
#define ub_for133_4  -1
#define lb_for149_5  -1
#define ub_for149_6  -1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example345587580/nes/azul3d_audio.go
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
	int audio_buffers = Run_audio_buffers;
	Chandef schan;
	int pbuffers = -2;
	bool state = false;
	
	if
	:: audio_buffers > 0 -> 
		schan.size = audio_buffers;
		run AsyncChan(schan)
	:: else -> 
		run sync_monitor(schan)
	fi;
	run go_stream(schan);
	
	if
	:: lb_for127_1 != -2 && ub_for127_2 != -2 -> 
				for(i : lb_for127_1.. ub_for127_2) {
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
				:: lb_for149_5 != -2 && ub_for149_6 != -2 -> 
										for(i : lb_for149_5.. ub_for149_6) {
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
				:: lb_for149_5 != -2 && ub_for149_6 != -2 -> 
										for(i : lb_for149_5.. ub_for149_6) {
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

proctype go_stream(Chandef schan) {
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

