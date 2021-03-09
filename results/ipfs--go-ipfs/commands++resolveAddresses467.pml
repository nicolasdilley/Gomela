#define resolveAddresses_addrs  3

// https://github.com/ipfs/go-ipfs/blob/7588a6a52a789fa951e1c4916cee5c7a304912c2/core/commands/swarm.go#L467
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
	Chandef maddrC;
	Chandef resolveErrC;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int addrs = resolveAddresses_addrs;
	run wgMonitor(wg);
	

	if
	:: addrs > 0 -> 
		resolveErrC.size = addrs;
		run AsyncChan(resolveErrC)
	:: else -> 
		run sync_monitor(resolveErrC)
	fi;
	run sync_monitor(maddrC);
		for(i : 0.. addrs-1) {
		for10: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		

		if
		:: true -> 
			goto for10_end
		:: true;
		fi;
		wg.Add!1;
		run go_Anonymous0(resolveErrC,maddrC,wg);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous1(resolveErrC,maddrC,wg);
	do
	:: true -> 
		

		if
		:: maddrC.async_rcv?state,num_msgs;
		:: maddrC.sync?state,num_msgs;
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
	do
	:: resolveErrC.async_rcv?state,num_msgs -> 
		goto stop_process
	:: resolveErrC.sync?state,num_msgs -> 
		goto stop_process
	:: true;
	od;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resolveErrC;Chandef maddrC;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int raddrs = -2;
	

	if
	:: true -> 
		

		if
		:: resolveErrC.async_send!0;
		:: resolveErrC.sync!false,0 -> 
			resolveErrC.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: raddrs-1 != -3 -> 
				for(i : 0.. raddrs-1) {
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: maddrC.async_send!0;
				:: maddrC.sync!false,0 -> 
					maddrC.sending?state
				fi
			:: true;
			fi;
			for11_end: skip
		};
		for11_exit: skip
	:: else -> 
		do
		:: true -> 
			for11897: skip;
			

			if
			:: true -> 
				

				if
				:: maddrC.async_send!0;
				:: maddrC.sync!false,0 -> 
					maddrC.sending?state
				fi
			:: true;
			fi;
			for11_end897: skip
		:: true -> 
			break
		od;
		for11_exit897: skip
	fi;
	

	if
	:: true -> 
		

		if
		:: resolveErrC.async_send!0;
		:: resolveErrC.sync!false,0 -> 
			resolveErrC.sending?state
		fi
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef resolveErrC;Chandef maddrC;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	wg.Wait?0;
	maddrC.closing!true;
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

