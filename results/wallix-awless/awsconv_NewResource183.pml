#define not_found_awsResourcesDefLres_TypeL20627  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example710248287/aws/conv/convert.go
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
	Wgdef wg;
	Chandef errc;
	Chandef resultc;
	bool state = false;
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
	run sync_monitor(resultc);
	run sync_monitor(errc);
	run wgMonitor(wg);
		for(i : 0.. not_found_awsResourcesDefLres_TypeL20627-1) {
		for10: skip;
		wg.Add!1;
		run go_Anonymous0(resultc,errc,wg);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous1(resultc,errc,wg);
	do
	:: true -> 
		for20: skip;
		do
		:: errc.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: errc.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: resultc.async_rcv?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		:: resultc.sync?0 -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			break
		od;
		for20_end: skip
	od;
	for20_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef resultc;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: errc.async_send!0;
				:: errc.sync!0 -> 
					errc.sending?0
				fi
			:: true;
			fi;
			

			if
			:: resultc.async_send!0;
			:: resultc.sync!0 -> 
				resultc.sending?0
			fi
		:: true;
		fi
	:: true;
	fi;
	

	if
	:: true -> 
		

		if
		:: true -> 
			

			if
			:: errc.async_send!0;
			:: errc.sync!0 -> 
				errc.sending?0
			fi
		:: true;
		fi;
		

		if
		:: resultc.async_send!0;
		:: resultc.sync!0 -> 
			resultc.sending?0
		fi
	:: true;
	fi;
	stop_process: skip;
	wg.Add!-1
}
proctype go_Anonymous1(Chandef resultc;Chandef errc;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	wg.Wait?0;
	errc.closing!true;
	resultc.closing!true;
	stop_process: skip
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

