#define Process_p_evaluators  1
#define not_found_162  -2

// https://github.com/vmware/harbor/blob/42559479e629a4f9c7b4f9cb1da152919aba444f/src/pkg/retention/policy/alg/or/processor.go#L62
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
	Chandef done;
	Chandef errChan;
	Chandef resChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int p_evaluators = Process_p_evaluators;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		resChan.size = 1;
		run AsyncChan(resChan)
	:: else -> 
		run sync_monitor(resChan)
	fi;
	

	if
	:: 1 > 0 -> 
		errChan.size = 1;
		run AsyncChan(errChan)
	:: else -> 
		run sync_monitor(errChan)
	fi;
	

	if
	:: 1 > 0 -> 
		done.size = 1;
		run AsyncChan(done)
	:: else -> 
		run sync_monitor(done)
	fi;
	run go_Anonymous0(resChan,errChan,done);
	run wgMonitor(wg);
	wg.Add!p_evaluators;
		for(i : 0.. p_evaluators-1) {
		for20: skip;
		run go_Anonymous1(resChan,errChan,done,wg,not_found_162);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	resChan.closing!true;
	

	if
	:: done.async_rcv?state,num_msgs;
	:: done.sync?state,num_msgs;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef resChan;Chandef errChan;Chandef done) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for10: skip;
		do
		:: resChan.async_rcv?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: resChan.sync?state,num_msgs -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errChan.async_rcv?state,num_msgs -> 
			break
		:: errChan.sync?state,num_msgs -> 
			break
		od;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip;
	

	if
	:: done.async_send!0;
	:: done.sync!false,0 -> 
		done.sending?state
	fi
}
proctype go_Anonymous1(Chandef resChan;Chandef errChan;Chandef done;Wgdef wg;int selectors) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: true -> 
		

		if
		:: selectors-1 != -3 -> 
						for(i : 0.. selectors-1) {
				for21: skip;
				

				if
				:: true -> 
					

					if
					:: errChan.async_send!0;
					:: errChan.sync!false,0 -> 
						errChan.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				for21_end: skip
			};
			for21_exit: skip
		:: else -> 
			do
			:: true -> 
				for211132: skip;
				

				if
				:: true -> 
					

					if
					:: errChan.async_send!0;
					:: errChan.sync!false,0 -> 
						errChan.sending?state
					fi;
					goto stop_process
				:: true;
				fi;
				for21_end1132: skip
			:: true -> 
				break
			od;
			for21_exit1132: skip
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: errChan.async_send!0;
		:: errChan.sync!false,0 -> 
			errChan.sending?state
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: resChan.async_send!0;
	:: resChan.sync!false,0 -> 
		resChan.sending?state
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

