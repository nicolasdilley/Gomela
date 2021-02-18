#define ScrapeMetrics_sources  3

// https://github.com/kubernetes/heapster/blob/e1e83412787b60d8a70088f09a2cb12339b305c3/metrics/sources/manager.go#L78
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
	Chandef responseChannel;
	int num_msgs = 0;
	bool state = false;
	int i;
	int sources = ScrapeMetrics_sources;
	run sync_monitor(responseChannel);
		for(i : 0.. sources-1) {
		for10: skip;
		run go_Anonymous0(responseChannel);
		for10_end: skip
	};
	for10_exit: skip;
	responseloop: skip;
		

	if
	:: sources-1 != -3 -> 
				for(i : 0.. sources-1) {
			for20: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			do
			:: responseChannel.async_rcv?state,num_msgs -> 
				break
			:: responseChannel.sync?state,num_msgs -> 
				break
			:: true -> 
				goto responseloop;
				break
			od;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201124: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			do
			:: responseChannel.async_rcv?state,num_msgs -> 
				break
			:: responseChannel.sync?state,num_msgs -> 
				break
			:: true -> 
				goto responseloop1124;
				break
			od;
			for20_end1124: skip
		:: true -> 
			break
		od;
		for20_exit1124: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef channel) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

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
	do
	:: channel.async_send!0 -> 
		goto stop_process
	:: channel.sync!false,0 -> 
		channel.sending?state;
		goto stop_process
	:: true -> 
		goto stop_process
	od;
	stop_process: skip
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

