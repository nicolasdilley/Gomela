#define refresh_machines  3

// https://github.com/prometheus/prometheus/blob/master/discovery/azure/azure.go#L256
typedef Chandef {
	chan sync = [0] of {bool};
	chan enq = [0] of {int};
	chan deq = [0] of {bool,int};
	chan sending = [0] of {bool};
	chan rcving = [0] of {bool};
	chan closing = [0] of {bool};
	int size = 0;
	int num_msgs = 0;
	bool closed = false;
}
typedef Wgdef {
	chan update = [0] of {int};
	chan wait = [0] of {int};
	int Counter = 0;}



init { 
	chan child_refresh2560 = [1] of {int};
	run refresh256(child_refresh2560)
stop_process:skip
}

proctype refresh256(chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	chan child_Anonymousrefresh2962960 = [1] of {int};
	Chandef ch;
	Wgdef wg;
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
	wg.update!machines;
	

	if
	:: machines > 0 -> 
		ch.size = machines;
		run AsyncChan(ch)
	:: else -> 
		run sync_monitor(ch)
	fi;
		for(i : 0.. machines-1) {
		for20: skip;
		run Anonymousrefresh296296(ch,wg,child_Anonymousrefresh2962960);
		for20_end: skip
	};
	for20_exit: skip;
	wg.wait?0;
	ch.closing!true;
	do
	:: true -> 
		

		if
		:: ch.deq?state,num_msgs;
		:: ch.sync?state -> 
			ch.rcving!false
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
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype Anonymousrefresh296296(Chandef ch;Wgdef wg;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int vm_NetworkInterfaces=0;
	int networkInterface_IPConfigurations=0;
	

	if
	:: true -> 
		

		if
		:: ch.enq!0;
		:: ch.sync!false -> 
			ch.sending!false
		fi;
		goto stop_process
	:: true;
	fi;
	

	if
	:: vm_NetworkInterfaces-1 != -3 -> 
				for(i : 0.. vm_NetworkInterfaces-1) {
			for23: skip;
			

			if
			:: true -> 
				

				if
				:: ch.enq!0;
				:: ch.sync!false -> 
					ch.sending!false
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for23_end
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
						for24: skip;
						

						if
						:: true -> 
							

							if
							:: ch.enq!0;
							:: ch.sync!false -> 
								ch.sending!false
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.enq!0;
						:: ch.sync!false -> 
							ch.sending!false
						fi;
						goto stop_process;
						for24_end: skip
					};
					for24_exit: skip
				:: else -> 
					do
					:: true -> 
						for25: skip;
						

						if
						:: true -> 
							

							if
							:: ch.enq!0;
							:: ch.sync!false -> 
								ch.sending!false
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.enq!0;
						:: ch.sync!false -> 
							ch.sending!false
						fi;
						goto stop_process;
						for25_end: skip
					:: true -> 
						break
					od;
					for25_exit: skip
				fi
			:: true;
			fi;
			for23_end: skip
		};
		for23_exit: skip
	:: else -> 
		do
		:: true -> 
			for26: skip;
			

			if
			:: true -> 
				

				if
				:: ch.enq!0;
				:: ch.sync!false -> 
					ch.sending!false
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				goto for26_end
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
						for27: skip;
						

						if
						:: true -> 
							

							if
							:: ch.enq!0;
							:: ch.sync!false -> 
								ch.sending!false
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.enq!0;
						:: ch.sync!false -> 
							ch.sending!false
						fi;
						goto stop_process;
						for27_end: skip
					};
					for27_exit: skip
				:: else -> 
					do
					:: true -> 
						for28: skip;
						

						if
						:: true -> 
							

							if
							:: ch.enq!0;
							:: ch.sync!false -> 
								ch.sending!false
							fi;
							goto stop_process
						:: true;
						fi;
						

						if
						:: ch.enq!0;
						:: ch.sync!false -> 
							ch.sending!false
						fi;
						goto stop_process;
						for28_end: skip
					:: true -> 
						break
					od;
					for28_exit: skip
				fi
			:: true;
			fi;
			for26_end: skip
		:: true -> 
			break
		od;
		for26_exit: skip
	fi;
	stop_process: skip;
		wg.update!-1;
	child!0
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.rcving?false;
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.sync!true -> 
		 ch.num_msgs = ch.num_msgs - 1
  fi;
:: else ->
	if
	:: ch.num_msgs == ch.size ->
		end1: if
		  :: ch.deq!false,ch.num_msgs ->
		    ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		    ch.closed = true
		   :: ch.rcving?false ->
 		    ch.sending?false;
		fi;
	:: ch.num_msgs == 0 -> 
end2:		if
		:: ch.enq?0 -> // a message has been received
			ch.num_msgs = ch.num_msgs + 1
		:: ch.closing?true -> // closing the channel
			ch.closed = true
		:: ch.rcving?false ->
 		    ch.sending?false;
		fi;
		:: else -> 
		end3: if
		  :: ch.enq?0->
		     ch.num_msgs = ch.num_msgs + 1
		  :: ch.deq!false,ch.num_msgs
		     ch.num_msgs = ch.num_msgs - 1
		  :: ch.closing?true -> // closing the channel
		     ch.closed = true
		  :: ch.rcving?false ->
 		    ch.sending?false;
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
  :: ch.enq?0-> // cannot send on closed channel
    assert(1 == 0)
  :: ch.closing?true -> // cannot close twice a channel
    assert(2 == 0)
  :: ch.sending?false -> // sending state of channel (closed)
    assert(1 == 0)
  :: ch.rcving?false;
  :: ch.sync!true; // can always receive on a closed chan
  fi;
:: else -> 
end1: if
    :: ch.rcving?false ->
       ch.sending?false;
    :: ch.closing?true ->
      ch.closed = true
    fi;
fi;
od
stop_process:
}

proctype wgMonitor(Wgdef wg) {
int i;
do
	:: wg.update?i ->
		wg.Counter = wg.Counter + i;
		assert(wg.Counter >= 0)
	:: wg.Counter == 0 ->
end: if
		:: wg.update?i ->
			wg.Counter = wg.Counter + i;
			assert(wg.Counter >= 0)
		:: wg.wait!0;
	fi
od
}


