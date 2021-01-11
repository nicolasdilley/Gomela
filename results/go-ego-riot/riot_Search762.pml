#define Search_engine_initOptions_NumShards  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example444176249/engine.go
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
	chan child_Ranks1 = [0] of {int};
	chan child_RankID0 = [0] of {int};
	Chandef rankerReturnChan;
	bool state = false;
	int i;
	int engine_initOptions_NumShards = Search_engine_initOptions_NumShards;
	

	if
	:: engine_initOptions_NumShards > 0 -> 
		rankerReturnChan.size = engine_initOptions_NumShards;
		run AsyncChan(rankerReturnChan)
	:: else -> 
		run sync_monitor(rankerReturnChan)
	fi;
	

	if
	:: true -> 
		run RankID(rankerReturnChan,child_RankID0);
		child_RankID0?0;
		goto stop_process
	:: true;
	fi;
	run Ranks(rankerReturnChan,child_Ranks1);
	child_Ranks1?0;
	goto stop_process
stop_process:skip
}

proctype RankID(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_NotTimeOut0 = [0] of {int};
	chan child_TimeOut1 = [0] of {int};
	

	if
	:: true -> 
		run NotTimeOut(rankerReturnChan,child_NotTimeOut0);
		child_NotTimeOut0?0
	:: true -> 
		run TimeOut(rankerReturnChan,child_TimeOut1);
		child_TimeOut1?0
	:: true -> 
		run TimeOut(rankerReturnChan,child_TimeOut1);
		child_TimeOut1?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype NotTimeOut(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int engine_initOptions_NumShards=3;
	

	if
	:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
			for20872: skip;
			

			if
			:: rankerReturnChan.async_rcv?0;
			:: rankerReturnChan.sync?0;
			fi;
			for20_end872: skip
		};
		for20_exit872: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: rankerReturnChan.async_rcv?0;
			:: rankerReturnChan.sync?0;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype TimeOut(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int engine_initOptions_NumShards=0;
	

	if
	:: 0 != -2 && engine_initOptions_NumShards-1 != -3 -> 
				for(i : 0.. engine_initOptions_NumShards-1) {
			for30874: skip;
			do
			:: rankerReturnChan.async_rcv?0 -> 
				break
			:: rankerReturnChan.sync?0 -> 
				break
			:: true -> 
				goto for30_exit874
			od;
			for30_end874: skip
		};
		for30_exit874: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			do
			:: rankerReturnChan.async_rcv?0 -> 
				break
			:: rankerReturnChan.sync?0 -> 
				break
			:: true -> 
				goto for30_exit
			od;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Ranks(Chandef rankerReturnChan;chan child) {
	bool closed; 
	int i;
	bool state;
	chan child_NotTimeOut1 = [0] of {int};
	chan child_TimeOut2 = [0] of {int};
	

	if
	:: true -> 
		run NotTimeOut(rankerReturnChan,child_NotTimeOut1);
		child_NotTimeOut1?0
	:: true -> 
		run TimeOut(rankerReturnChan,child_TimeOut2);
		child_TimeOut2?0
	:: true -> 
		run TimeOut(rankerReturnChan,child_TimeOut2);
		child_TimeOut2?0
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
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


