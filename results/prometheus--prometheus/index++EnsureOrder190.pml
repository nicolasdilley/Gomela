#define EnsureOrder_n  1

// https://github.com/prometheus/prometheus/blob/b7fe028740b7b36a31c2deda1e2b74aa566fc0ee/tsdb/index/postings.go#L190
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
	Chandef workc;
	int num_msgs = 0;
	bool state = false;
	int i;
	int e = -2;
	int p_m = -2;
	int n = EnsureOrder_n;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(workc);
	run wgMonitor(wg);
	wg.Add!n;
		for(i : 0.. n-1) {
		for10: skip;
		run go_Anonymous0(workc,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: p_m-1 != -3 -> 
				for(i : 0.. p_m-1) {
			for20: skip;
			

			if
			:: e-1 != -3 -> 
								for(i : 0.. e-1) {
					for21: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!false,0 -> 
						workc.sending?state
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for21518: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!false,0 -> 
						workc.sending?state
					fi;
					for21_end518: skip
				:: true -> 
					break
				od;
				for21_exit518: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20519: skip;
			

			if
			:: e-1 != -3 -> 
								for(i : 0.. e-1) {
					for21519: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!false,0 -> 
						workc.sending?state
					fi;
					for21_end519: skip
				};
				for21_exit519: skip
			:: else -> 
				do
				:: true -> 
					for21518519: skip;
					

					if
					:: workc.async_send!0;
					:: workc.sync!false,0 -> 
						workc.sending?state
					fi;
					for21_end518519: skip
				:: true -> 
					break
				od;
				for21_exit518519: skip
			fi;
			for20_end519: skip
		:: true -> 
			break
		od;
		for20_exit519: skip
	fi;
	workc.closing!true;
	wg.Wait?0
stop_process:skip
}

proctype go_Anonymous0(Chandef workc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: workc.async_rcv?state,num_msgs;
		:: workc.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
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

