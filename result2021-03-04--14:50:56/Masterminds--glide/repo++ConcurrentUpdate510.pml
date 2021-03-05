#define deps510  3
#define ConcurrentUpdate_concurrentWorkers  0

// https://github.com/Masterminds/glide/blob/b94b39d657d8abcccba6545e148f1201aee6ffec/repo/installer.go#L510
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
	run go_ConcurrentUpdate(deps510)
stop_process:skip
}

proctype go_ConcurrentUpdate(int deps) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef wg;
	Chandef in;
	Chandef done;
	int concurrentWorkers = ConcurrentUpdate_concurrentWorkers;
	

	if
	:: concurrentWorkers > 0 -> 
		done.size = concurrentWorkers;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	

	if
	:: concurrentWorkers > 0 -> 
		in.size = concurrentWorkers;
		run AsyncChan(in)
	:: else -> 
		run sync_monitor(in)
	fi;
	run wgMonitor(wg);
		for(i : 0.. concurrentWorkers-1) {
		for10: skip;
		run go_Anonymous1(in,done,wg);
		for10_end: skip
	};
	for10_exit: skip;
		for(i : 0.. deps-1) {
		for20: skip;
		

		if
		:: true -> 
			wg.Add!1;
			

			if
			:: in.async_send!0;
			:: in.sync!false,0 -> 
				in.sending?state
			fi
		:: true;
		fi;
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	

	if
	:: 0 != -2 && concurrentWorkers-1 != -3 -> 
				for(i : 0.. concurrentWorkers-1) {
			for31: skip;
			

			if
			:: done.async_send!0;
			:: done.sync!false,0 -> 
				done.sending?state
			fi;
			for31_end: skip
		};
		for31_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: done.async_send!0;
			:: done.sync!false,0 -> 
				done.sending?state
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	goto stop_process;
	stop_process: skip
}
proctype go_Anonymous1(Chandef ch;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		do
		:: ch.async_rcv?state,num_msgs -> 
			wg.Add!-1;
			break
		:: ch.sync?state,num_msgs -> 
			wg.Add!-1;
			break
		:: done.async_rcv?state,num_msgs -> 
			goto stop_process
		:: done.sync?state,num_msgs -> 
			goto stop_process
		od;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip
}
proctype go_Anonymous2(Chandef ch;Chandef done;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for14: skip;
		do
		:: ch.async_rcv?state,num_msgs -> 
			wg.Add!-1;
			break
		:: ch.sync?state,num_msgs -> 
			wg.Add!-1;
			break
		:: done.async_rcv?state,num_msgs -> 
			goto stop_process
		:: done.sync?state,num_msgs -> 
			goto stop_process
		od;
		for14_end: skip
	od;
	for14_exit: skip;
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

