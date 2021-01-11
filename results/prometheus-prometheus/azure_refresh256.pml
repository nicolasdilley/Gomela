#define refresh_machines  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example163393137/discovery/azure/azure.go
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
	Chandef ch;
	Wgdef wg;
	bool state = false;
	int i;
	int machines = refresh_machines;
	

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
	wg.Add!machines;
	

	if
	:: machines > 0 -> 
		ch.size = machines;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. machines-1) {
		for20: skip;
		run go_Anonymous0(ch,wg);
		for20_end: skip
	};
	for20_exit: skip;
	wg.Wait?0;
	ch.closing!true;
	do
	:: ch.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: ch.async_rcv?0;
			:: ch.sync?0;
			fi;
			for30: skip;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for30_end: skip
		fi
	od;
	for30_exit: skip;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef ch;Wgdef wg) {
	bool closed; 
	int i;
	bool state;
	int networkInterface_IPConfigurations = -2;
	int vm_NetworkInterfaces = -2;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!0 -> 
			ch.sending?0
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: vm_NetworkInterfaces-1 != -3 -> 
				for(i : 0.. vm_NetworkInterfaces-1) {
			for22: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for22_end
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: networkInterface_IPConfigurations-1 != -3 -> 
										for(i : 0.. networkInterface_IPConfigurations-1) {
						for23: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!0 -> 
								ch.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!0 -> 
							ch.sending?0
						fi;
						goto stop_process;
						for23_end: skip
					};
					for23_exit: skip
				:: else -> 
					do
					:: true -> 
						for23145: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!0 -> 
								ch.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!0 -> 
							ch.sending?0
						fi;
						goto stop_process;
						for23_end145: skip
					:: true -> 
						break
					od;
					for23_exit145: skip
				fi
			:: true;
			fi;
			for22_end: skip
		};
		for22_exit: skip
	:: else -> 
		do
		:: true -> 
			for22146: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!0 -> 
					ch.sending?0
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for22_end146
			:: true;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: networkInterface_IPConfigurations-1 != -3 -> 
										for(i : 0.. networkInterface_IPConfigurations-1) {
						for23146: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!0 -> 
								ch.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!0 -> 
							ch.sending?0
						fi;
						goto stop_process;
						for23_end146: skip
					};
					for23_exit146: skip
				:: else -> 
					do
					:: true -> 
						for23145146: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!0 -> 
								ch.sending?0
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!0 -> 
							ch.sending?0
						fi;
						goto stop_process;
						for23_end145146: skip
					:: true -> 
						break
					od;
					for23_exit145146: skip
				fi
			:: true;
			fi;
			for22_end146: skip
		:: true -> 
			break
		od;
		for22_exit146: skip
	fi;
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

