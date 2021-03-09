#define Keys_count  1
#define Keys_SHARD_COUNT  1
#define Keys_m  3

// https://github.com/snail007/goproxy/blob/83cd1d9ff169914e498439c223d1233eb9d81b46/utils/map.go#L243
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
	Chandef ch;
	int num_msgs = 0;
	bool state = false;
	int i;
	int count = Keys_count;
	

	if
	:: count > 0 -> 
		ch.size = count;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
	run go_Anonymous0(ch);
	do
	:: true -> 
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef wg;
	int m = Keys_m;
	int SHARD_COUNT = Keys_SHARD_COUNT;
	run wgMonitor(wg);
	wg.Add!SHARD_COUNT;
		for(i : 0.. m-1) {
		for10: skip;
		run go_Anonymous1(ch,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	ch.closing!true;
	stop_process: skip
}
proctype go_Anonymous1(Chandef ch;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int shard_items=3;
	

	if
	:: shard_items-1 != -3 -> 
				for(i : 0.. shard_items-1) {
			for11: skip;
			

			if
			:: ch.async_send!0;
			:: ch.sync!false,0 -> 
				ch.sending?state
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for11555: skip;
			

			if
			:: ch.async_send!0;
			:: ch.sync!false,0 -> 
				ch.sending?state
			fi;
			for11_end555: skip
		:: true -> 
			break
		od;
		for11_exit555: skip
	fi;
	wg.Add!-1;
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


