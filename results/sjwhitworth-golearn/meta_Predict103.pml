#define Predict_n  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example958654119/meta/bagging.go
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
	Wgdef processwait;
	Chandef processpipe;
	Wgdef votingwait;
	Chandef votes;
	int num_msgs = 0;
	bool state = false;
	int i;
	int b_Models=3;
	int n = Predict_n;
	

	if
	:: n > 0 -> 
		votes.size = n;
		run AsyncChan(votes)
	:: else -> 
		run sync_monitor(votes)
	fi;
	run wgMonitor(votingwait);
	votingwait.Add!1;
	

	if
	:: n > 0 -> 
		processpipe.size = n;
		run AsyncChan(processpipe)
	:: else -> 
		run sync_monitor(processpipe)
	fi;
	run wgMonitor(processwait);
		for(i : 0.. n-1) {
		for10: skip;
		processwait.Add!1;
		run go_Anonymous0(votes,processpipe,votingwait,processwait);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: b_Models-1 != -3 -> 
				for(i : 0.. b_Models-1) {
			for20: skip;
			

			if
			:: processpipe.async_send!0;
			:: processpipe.sync!false,0 -> 
				processpipe.sending?state
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20103: skip;
			

			if
			:: processpipe.async_send!0;
			:: processpipe.sync!false,0 -> 
				processpipe.sending?state
			fi;
			for20_end103: skip
		:: true -> 
			break
		od;
		for20_exit103: skip
	fi;
	processpipe.closing!true;
	processwait.Wait?0;
	votes.closing!true;
	votingwait.Wait?0;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef votes;Chandef processpipe;Wgdef votingwait;Wgdef processwait) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		

		if
		:: processpipe.async_rcv?state,num_msgs;
		:: processpipe.sync?state,num_msgs;
		fi;
		

		if
		:: true -> 
			

			if
			:: votes.async_send!0;
			:: votes.sync!false,0 -> 
				votes.sending?state
			fi
		:: true -> 
			processwait.Add!-1;
			break
		fi;
		for11_end: skip
	od;
	for11_exit: skip;
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


