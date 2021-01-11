#define benchmarkRun_chunkCount  3
#define benchmarkRun_threads  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example788564112/src/duplicacy_benchmark.go
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
	Chandef finishChannel;
	Chandef stopChannel;
	Chandef indexChannel;
	bool state = false;
	int i;
	int threads = benchmarkRun_threads;
	int chunkCount = benchmarkRun_chunkCount;
	

	if
	:: chunkCount > 0 -> 
		indexChannel.size = chunkCount;
		run AsyncChan(indexChannel)
	:: else -> 
		run sync_monitor(indexChannel)
	fi;
	

	if
	:: threads > 0 -> 
		stopChannel.size = threads;
		run AsyncChan(stopChannel)
	:: else -> 
		run sync_monitor(stopChannel)
	fi;
	

	if
	:: threads > 0 -> 
		finishChannel.size = threads;
		run AsyncChan(finishChannel)
	:: else -> 
		run sync_monitor(finishChannel)
	fi;
		for(i : 0.. threads-1) {
		for10: skip;
		run go_Anonymous0(indexChannel,stopChannel,finishChannel);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && chunkCount-1 != -3 -> 
				for(i : 0.. chunkCount-1) {
			for201275: skip;
			

			if
			:: indexChannel.async_send!0;
			:: indexChannel.sync!0 -> 
				indexChannel.sending?0
			fi;
			for20_end1275: skip
		};
		for20_exit1275: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: indexChannel.async_send!0;
			:: indexChannel.sync!0 -> 
				indexChannel.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	

	if
	:: 0 != -2 && chunkCount-1 != -3 -> 
				for(i : 0.. chunkCount-1) {
			for301276: skip;
			

			if
			:: finishChannel.async_rcv?0;
			:: finishChannel.sync?0;
			fi;
			for30_end1276: skip
		};
		for30_exit1276: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: finishChannel.async_rcv?0;
			:: finishChannel.sync?0;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: 0 != -2 && threads-1 != -3 -> 
				for(i : 0.. threads-1) {
			for401277: skip;
			

			if
			:: stopChannel.async_send!0;
			:: stopChannel.sync!0 -> 
				stopChannel.sending?0
			fi;
			for40_end1277: skip
		};
		for40_exit1277: skip
	:: else -> 
		do
		:: true -> 
			for40: skip;
			

			if
			:: stopChannel.async_send!0;
			:: stopChannel.sync!0 -> 
				stopChannel.sending?0
			fi;
			for40_end: skip
		:: true -> 
			break
		od;
		for40_exit: skip
	fi
stop_process:skip
}

proctype go_Anonymous0(Chandef indexChannel;Chandef stopChannel;Chandef finishChannel) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for11: skip;
		do
		:: indexChannel.async_rcv?0 -> 
			

			if
			:: finishChannel.async_send!0;
			:: finishChannel.sync!0 -> 
				finishChannel.sending?0
			fi;
			break
		:: indexChannel.sync?0 -> 
			

			if
			:: finishChannel.async_send!0;
			:: finishChannel.sync!0 -> 
				finishChannel.sending?0
			fi;
			break
		:: stopChannel.async_rcv?0 -> 
			goto stop_process
		:: stopChannel.sync?0 -> 
			goto stop_process
		od;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip
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

