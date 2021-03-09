#define Read_p_readers  3

// https://github.com/minio/minio/blob/3163a660aa79b75b725a0c6f152557e6253b900f/cmd/erasure-decode.go#L104
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
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	Wgdef wg;
	Chandef readTriggerCh;
	int num_msgs = 0;
	bool state = false;
	int i;
	int p_dataBlocks=1;
	int p_readers = Read_p_readers;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: p_readers > 0 -> 
		readTriggerCh.size = p_readers;
		run AsyncChan(readTriggerCh)
	:: else -> 
		run sync_monitor(readTriggerCh)
	fi;
	

	if
	:: 0 != -2 && p_dataBlocks-1 != -3 -> 
				for(i : 0.. p_dataBlocks-1) {
			for20584: skip;
			

			if
			:: readTriggerCh.async_send!0;
			:: readTriggerCh.sync!false,0 -> 
				readTriggerCh.sending?state
			fi;
			for20_end584: skip
		};
		for20_exit584: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: readTriggerCh.async_send!0;
			:: readTriggerCh.sync!false,0 -> 
				readTriggerCh.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	run wgMonitor(wg);
	do
	:: true -> 
		

		if
		:: readTriggerCh.async_rcv?state,num_msgs;
		:: readTriggerCh.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				break
			:: true;
			fi;
			

			if
			:: true -> 
				goto for30_end
			:: true;
			fi;
			wg.Add!1;
			run go_Anonymous0(readTriggerCh,wg);
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	wg.Wait?0;
	

	if
	:: true -> 
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef readTriggerCh;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: readTriggerCh.async_send!0;
		:: readTriggerCh.sync!false,0 -> 
			readTriggerCh.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: readTriggerCh.async_send!0;
		:: readTriggerCh.sync!false,0 -> 
			readTriggerCh.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: readTriggerCh.async_send!0;
	:: readTriggerCh.sync!false,0 -> 
		readTriggerCh.sending?state
	fi;
	stop_process: skip;
	wg.Add!-1
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

proctype wgMonitor(Wgdef wg) {
bool closed;
int i;
bool state;
do
	:: wg.Add?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.Add?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
	fi
od
}


