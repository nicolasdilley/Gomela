
// https://github.com/chrislusf/seaweedfs/blob/e439b65e387609b2a761d9a976c0efc44060dff5/weed/storage/disk_location.go#L180
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
	Chandef errChain;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: 2 > 0 -> 
		errChain.size = 2;
		run AsyncChan(errChain)
	:: else -> 
		run sync_monitor(errChain)
	fi;
	run wgMonitor(wg);
	wg.Add!2;
	run go_Anonymous0(errChain,wg);
	run go_Anonymous1(errChain,wg);
	run go_Anonymous2(errChain,wg);
	do
	:: true -> 
		

		if
		:: errChain.async_rcv?state,num_msgs;
		:: errChain.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef errChain;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int delVolsMap = -2;
	

	if
	:: delVolsMap-1 != -3 -> 
				for(i : 0.. delVolsMap-1) {
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: errChain.async_send!0;
				:: errChain.sync!false,0 -> 
					errChain.sending?state
				fi
			:: true;
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10806: skip;
			

			if
			:: true -> 
				

				if
				:: errChain.async_send!0;
				:: errChain.sync!false,0 -> 
					errChain.sending?state
				fi
			:: true;
			fi;
			for10_end806: skip
		:: true -> 
			break
		od;
		for10_exit806: skip
	fi;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous1(Chandef errChain;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Add!-1;
	stop_process: skip
}
proctype go_Anonymous2(Chandef errChain;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
	errChain.closing!true;
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

