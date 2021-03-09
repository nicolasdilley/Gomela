
// https://github.com/coreos/clair/blob/9254ab66ea7f1b9711242026045da35b7ffa2782/httptransport/client/matcher.go#L60
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
	Chandef item;
	Wgdef wg;
	int num_msgs = 0;
	bool state = false;
	int i;
	int ref = -2;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	run sync_monitor(item);
		for(i : 0.. 4-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(item,wg);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: ref != -2 && lim-1-1 != -3 -> 
				for(i : ref.. lim-1-1) {
			for20693: skip;
			

			if
			:: item.async_send!0;
			:: item.sync!false,0 -> 
				item.sending?state
			fi;
			for20_end693: skip
		};
		for20_exit693: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: item.async_send!0;
			:: item.sync!false,0 -> 
				item.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	item.closing!true;
	wg.Wait?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef item;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: item.async_rcv?state,num_msgs;
		:: item.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

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
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
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

