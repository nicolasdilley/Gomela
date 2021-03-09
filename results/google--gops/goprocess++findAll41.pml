#define findAll_pss  0
#define findAll_concurrencyLimit  1

// https://github.com/google/gops/blob/268f11e4fcde1604b8593e6bc35eb6e138699cb5/goprocess/gp.go#L41
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
	Chandef output;
	Chandef input;
	int num_msgs = 0;
	bool state = false;
	int i;
	int concurrencyLimit = findAll_concurrencyLimit;
	int pss = findAll_pss;
	

	if
	:: pss > 0 -> 
		input.size = pss;
		run AsyncChan(input)
	:: else -> 
		run sync_monitor(input)
	fi;
	

	if
	:: pss > 0 -> 
		output.size = pss;
		run AsyncChan(output)
	:: else -> 
		run sync_monitor(output)
	fi;
	

	if
	:: pss-1 != -3 -> 
				for(i : 0.. pss-1) {
			for10: skip;
			

			if
			:: input.async_send!0;
			:: input.sync!false,0 -> 
				input.sending?state
			fi;
			for10_end: skip
		};
		for10_exit: skip
	:: else -> 
		do
		:: true -> 
			for10175: skip;
			

			if
			:: input.async_send!0;
			:: input.sync!false,0 -> 
				input.sending?state
			fi;
			for10_end175: skip
		:: true -> 
			break
		od;
		for10_exit175: skip
	fi;
	input.closing!true;
	run wgMonitor(wg);
	wg.Add!concurrencyLimit;
		for(i : 0.. concurrencyLimit-1) {
		for20: skip;
		run go_Anonymous0(input,output,wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	output.closing!true;
	do
	:: true -> 
		

		if
		:: output.async_rcv?state,num_msgs;
		:: output.sync?state,num_msgs;
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

proctype go_Anonymous0(Chandef input;Chandef output;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: input.async_rcv?state,num_msgs;
		:: input.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for21: skip;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto for21_end
			:: true;
			fi;
			

			if
			:: output.async_send!0;
			:: output.sync!false,0 -> 
				output.sending?state
			fi;
			for21_end: skip
		fi
	od;
	for21_exit: skip;
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

