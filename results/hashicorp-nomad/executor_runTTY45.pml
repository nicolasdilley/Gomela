
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example334195573/drivers/shared/executor/exec_utils.go
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
	Chandef errCh;
	Wgdef wg;
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
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run wgMonitor(wg);
	

	if
	:: 3 > 0 -> 
		errCh.size = 3;
		run AsyncChan(errCh)
	:: else -> 
		run sync_monitor(errCh)
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	wg.Add!1;
	run go_handleStdin(errCh);
	run go_handleStdout(wg,errCh);
	wg.Wait?0;
	do
	:: errCh.async_rcv?0 -> 
		goto stop_process
	:: errCh.sync?0 -> 
		goto stop_process
	:: true -> 
		goto stop_process
	od
stop_process:skip
}

proctype go_handleStdin(Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for10: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: errCh.async_send!0;
					:: errCh.sync!0 -> 
						errCh.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: true -> 
					

					if
					:: errCh.async_send!0;
					:: errCh.sync!0 -> 
						errCh.sending?0
					fi;
					goto stop_process
				:: true;
				fi
			:: true;
			fi
		fi;
		for10_end: skip
	od;
	for10_exit: skip;
	stop_process: skip
}
proctype go_handleStdout(Wgdef wg;Chandef errCh) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for20: skip;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		:: true;
		fi;
		

		if
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			goto stop_process
		:: true -> 
			

			if
			:: true -> 
				

				if
				:: errCh.async_send!0;
				:: errCh.sync!0 -> 
					errCh.sending?0
				fi;
				goto stop_process
			:: true;
			fi
		fi;
		for20_end: skip
	od;
	for20_exit: skip;
	stop_process: skip;
	wg.Add!-1
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

