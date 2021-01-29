#define refresh_machines  3

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example158003814/discovery/azure/azure.go
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
	Chandef ch;
	Wgdef wg;
	int num_msgs = 0;
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
	:: true -> 
		

		if
		:: ch.async_rcv?state,num_msgs;
		:: ch.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
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
	int num_msgs;
	int networkInterface_IPConfigurations = -2;
	int vm_NetworkInterfaces = -2;
	

	if
	:: true -> 
		

		if
		:: ch.async_send!0;
		:: ch.sync!false,0 -> 
			ch.sending?state
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
				:: ch.sync!false,0 -> 
					ch.sending?state
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
							:: ch.sync!false,0 -> 
								ch.sending?state
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!false,0 -> 
							ch.sending?state
						fi;
						goto stop_process;
						for23_end: skip
					};
					for23_exit: skip
				:: else -> 
					do
					:: true -> 
						for23549: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!false,0 -> 
								ch.sending?state
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!false,0 -> 
							ch.sending?state
						fi;
						goto stop_process;
						for23_end549: skip
					:: true -> 
						break
					od;
					for23_exit549: skip
				fi
			:: true;
			fi;
			for22_end: skip
		};
		for22_exit: skip
	:: else -> 
		do
		:: true -> 
			for22550: skip;
			

			if
			:: true -> 
				

				if
				:: ch.async_send!0;
				:: ch.sync!false,0 -> 
					ch.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for22_end550
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
						for23550: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!false,0 -> 
								ch.sending?state
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!false,0 -> 
							ch.sending?state
						fi;
						goto stop_process;
						for23_end550: skip
					};
					for23_exit550: skip
				:: else -> 
					do
					:: true -> 
						for23549550: skip;
						

						if
						:: true -> 
							

							if
							:: ch.async_send!0;
							:: ch.sync!false,0 -> 
								ch.sending?state
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.async_send!0;
						:: ch.sync!false,0 -> 
							ch.sending?state
						fi;
						goto stop_process;
						for23_end549550: skip
					:: true -> 
						break
					od;
					for23_exit549550: skip
				fi
			:: true;
			fi;
			for22_end550: skip
		:: true -> 
			break
		od;
		for22_exit550: skip
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

