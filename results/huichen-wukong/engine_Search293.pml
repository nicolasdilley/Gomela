#define Search_engine_initOptions_NumShards  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example605536193/engine/engine.go
typedef Chandef {
	chan sync = [0] of {bool,int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {bool,int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}



init { 
	Chandef rankerReturnChannel;
	int num_msgs = 0;
	bool state = false;
	int i;
	int engine_initOptions_NumShards = Search_engine_initOptions_NumShards;
	

	if
	:: engine_initOptions_NumShards > 0 -> 
		rankerReturnChannel.size = engine_initOptions_NumShards;
		run AsyncChan(rankerReturnChannel)
	:: else -> 
		run sync_monitor(rankerReturnChannel)
	fi;
	

	if
	:: true -> 
		

		if
		:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
				for401013: skip;
				

				if
				:: rankerReturnChannel.async_rcv?state,num_msgs;
				:: rankerReturnChannel.sync?state,num_msgs;
				fi;
				for40_end1013: skip
			};
			for40_exit1013: skip
		:: else -> 
			do
			:: true -> 
				for40: skip;
				

				if
				:: rankerReturnChannel.async_rcv?state,num_msgs;
				:: rankerReturnChannel.sync?state,num_msgs;
				fi;
				for40_end: skip
			:: true -> 
				break
			od;
			for40_exit: skip
		fi
	:: true -> 
		

		if
		:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
						for(i : 0.. engine_initOptions_NumShards-1) {
				for501015: skip;
				do
				:: rankerReturnChannel.async_rcv?state,num_msgs -> 
					break
				:: rankerReturnChannel.sync?state,num_msgs -> 
					break
				:: true -> 
					goto for50_exit1015
				od;
				for50_end1015: skip
			};
			for50_exit1015: skip
		:: else -> 
			do
			:: true -> 
				for50: skip;
				do
				:: rankerReturnChannel.async_rcv?state,num_msgs -> 
					break
				:: rankerReturnChannel.sync?state,num_msgs -> 
					break
				:: true -> 
					goto for50_exit
				od;
				for50_end: skip
			:: true -> 
				break
			od;
			for50_exit: skip
		fi
	fi;
	goto stop_process
stop_process:skip
}


 /* ================================================================================== */
 /* ================================================================================== */
 /* ================================================================================== */ 
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,ch.num_msgs -> // can always receive on a closed chan
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
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
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!true,0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

