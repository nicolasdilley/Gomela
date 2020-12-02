#define lb_for262_0  -1
#define ub_for262_1  -1

// /tmp/clone-example058538204/lang/funcs/funcs.go
typedef Chandef {
	chan sync = [0] of {int};
	chan async_send = [0] of {int};
	chan async_rcv = [0] of {int};
	chan sending = [0] of {int};
	chan closing = [0] of {bool};
	chan is_closed = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan Add = [0] of {int};
	chan Wait = [0] of {int};
	int Counter = 0;}



init { 
	bool state = false;
	Chandef output;
	Chandef errch;
	Chandef close2;
	Wgdef wg;
	Chandef input;
	Chandef close1;
	int i;
	
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
	run wgMonitor(wg);
	run sync_monitor(errch);
	run sync_monitor(input);
	run sync_monitor(output);
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(close1);
	run sync_monitor(close2);
	wg.Add!1;
	run Anonymous0(errch,input,output,close1,close2,wg);
	wg.Add!1;
	run Anonymous1(errch,input,output,close1,close2,wg);
	wg.Add!1;
	run Anonymous2(errch,input,output,close1,close2,wg);
Loop:		do
	:: true -> 
for20:		do
		od
	od;
for20_exit:;
	
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
	goto stop_process;
	wg.Wait?0
stop_process:}

proctype Anonymous0(Chandef errch;Chandef input;Chandef output;Chandef close1;Chandef close2;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	do
	:: close1.async_rcv?0 -> 
		break
	:: close1.sync?0 -> 
		break
	od;
	do
	:: close2.async_rcv?0 -> 
		break
	:: close2.sync?0 -> 
		break
	od;
stop_process:	wg.Add!-1;
	errch.closing!true
}
proctype Anonymous1(Chandef errch;Chandef input;Chandef output;Chandef close1;Chandef close2;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	do
	:: errch.async_send!0 -> 
		break
	:: errch.sync!0 -> 
		errch.sending?0;
		break
	od;
stop_process:	wg.Add!-1;
	close1.closing!true
}
proctype Anonymous2(Chandef errch;Chandef input;Chandef output;Chandef close1;Chandef close2;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
		for(i : 0.. args-1) {
for10:		
		if
		:: true -> 
			do
			:: errch.async_send!0 -> 
				break
			:: errch.sync!0 -> 
				errch.sending?0;
				break
			od;
			goto stop_process
		:: true;
		fi
	};
	do
	:: input.async_send!0 -> 
		break
	:: input.sync!0 -> 
		input.sending?0;
		break
	:: close1.async_rcv?0 -> 
		do
		:: errch.async_send!0 -> 
			break
		:: errch.sync!0 -> 
			errch.sending?0;
			break
		od;
		break
	:: close1.sync?0 -> 
		do
		:: errch.async_send!0 -> 
			break
		:: errch.sync!0 -> 
			errch.sending?0;
			break
		od;
		break
	od;
stop_process:	wg.Add!-1;
	close2.closing!true;
	input.closing!true
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
end:		
		if
		:: wg.Add?i -> 
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.Wait!0;
		fi
	od
}
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.async_rcv!0 ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false; // sending channel is open 
		  :: ch.sending!false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.async_send?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.is_closed!false;
		:: ch.sending!false;
		fi;
		:: else -> 
		end3: if
		  :: ch.async_send?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.async_rcv!0
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		      ch.closed = true
		  :: ch.is_closed!false;  // sending channel is open
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
  :: ch.is_closed!true; // sending state of channel (closed)
  :: ch.sending!true -> // sending state of channel (closed)
    assert(false)
  :: ch.sync!0; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.sending!false;
    :: ch.closing?true ->
      ch.closed = true
    :: ch.is_closed!false ->
    fi;
fi;
od
stop_process:
}

