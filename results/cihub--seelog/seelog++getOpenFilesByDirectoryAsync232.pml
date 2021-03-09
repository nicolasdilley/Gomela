#define getOpenFilesByDirectoryAsync_n  3

// https://github.com/cihub/seelog/blob/f561c5e57575bb1e0a2167028b7339b3a8d16fb4/internals_fsutils.go#L232
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
	Chandef dirFilesChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int n = getOpenFilesByDirectoryAsync_n;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: n > 0 -> 
		dirFilesChan.size = n;
		run AsyncChan(dirFilesChan)
	:: else -> 
		run sync_monitor(dirFilesChan)
	fi;
	run wgMonitor(wg);
	wg.Add!n;
		for(i : 0.. n-1) {
		for10: skip;
		run go_Anonymous0(dirFilesChan,wg);
		for10_end: skip
	};
	for10_exit: skip;
	wg.Wait?0;
	dirFilesChan.closing!true;
	do
	:: true -> 
		

		if
		:: dirFilesChan.async_rcv?state,num_msgs;
		:: dirFilesChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for20: skip;
			

			if
			:: true -> 
				goto stop_process
			fi;
			for20_end: skip
		fi
	od;
	for20_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef dirFilesChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: dirFilesChan.async_send!0;
	:: dirFilesChan.sync!false,0 -> 
		dirFilesChan.sending?state
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

