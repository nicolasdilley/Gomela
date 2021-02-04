#define BatchCreateMutation_runtime_NumCPU11219  3

// https://github.com/google/keytransparency/blob/c1d8b03b87f098b18637b89ab17ff4c1c49fd1e2/core/client/batch_client.go#L82
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
	Chandef rChan;
	Chandef uChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int users=3;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(uChan);
	run sync_monitor(rChan);
	run go_Anonymous0(uChan,rChan,users);
	run go_Anonymous1(uChan,rChan);
	do
	:: true -> 
		

		if
		:: rChan.async_rcv?state,num_msgs;
		:: rChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for40: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for40_end: skip
		fi
	od;
	for40_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef uChan;Chandef rChan;int users) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: users-1 != -3 -> 
				for(i : 0.. users-1) {
			for20: skip;
			

			if
			:: uChan.async_send!0;
			:: uChan.sync!false,0 -> 
				uChan.sending?state
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for201000: skip;
			

			if
			:: uChan.async_send!0;
			:: uChan.sync!false,0 -> 
				uChan.sending?state
			fi;
			for20_end1000: skip
		:: true -> 
			break
		od;
		for20_exit1000: skip
	fi;
	stop_process: skip;
	uChan.closing!true
}
proctype go_Anonymous1(Chandef uChan;Chandef rChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Wgdef wg;
	int runtime_NumCPU11219 = BatchCreateMutation_runtime_NumCPU11219;
	run wgMonitor(wg);
		for(i : 0.. runtime_NumCPU11219-1) {
		for30: skip;
		wg.Add!1;
		run go_Anonymous2(uChan,rChan,wg);
		for30_end: skip
	};
	for30_exit: skip;
	stop_process: skip;
	wg.Wait?0;
	rChan.closing!true
}
proctype go_Anonymous2(Chandef uChan;Chandef rChan;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: uChan.async_rcv?state,num_msgs;
		:: uChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for31: skip;
			

			if
			:: rChan.async_send!0;
			:: rChan.sync!false,0 -> 
				rChan.sending?state
			fi;
			for31_end: skip
		fi
	od;
	for31_exit: skip;
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


