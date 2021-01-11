#define ProbePodToPodConnectivity_size  1
#define ProbePodToPodConnectivity_numberOfWorkers  0

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example328969469/test/e2e/network/netpol/probe.go
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



init { 
	Chandef results;
	Chandef jobs;
	bool state = false;
	int i;
	int allPods=0;
	int numberOfWorkers = ProbePodToPodConnectivity_numberOfWorkers;
	int size = ProbePodToPodConnectivity_size;
	

	if
	:: size > 0 -> 
		jobs.size = size;
		run AsyncChan(jobs)
	:: else -> 
		run sync_monitor(jobs)
	fi;
	

	if
	:: size > 0 -> 
		results.size = size;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
		for(i : 0.. numberOfWorkers-1) {
		for10: skip;
		run go_probeWorker(jobs,results);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: allPods-1 != -3 -> 
				for(i : 0.. allPods-1) {
			for20: skip;
			

			if
			:: allPods-1 != -3 -> 
								for(i : 0.. allPods-1) {
					for21: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!0 -> 
						jobs.sending?0
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for212345: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!0 -> 
						jobs.sending?0
					fi;
					for21_end2345: skip
				:: true -> 
					break
				od;
				for21_exit2345: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for202346: skip;
			

			if
			:: allPods-1 != -3 -> 
								for(i : 0.. allPods-1) {
					for212346: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!0 -> 
						jobs.sending?0
					fi;
					for21_end2346: skip
				};
				for21_exit2346: skip
			:: else -> 
				do
				:: true -> 
					for2123452346: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!0 -> 
						jobs.sending?0
					fi;
					for21_end23452346: skip
				:: true -> 
					break
				od;
				for21_exit23452346: skip
			fi;
			for20_end2346: skip
		:: true -> 
			break
		od;
		for20_exit2346: skip
	fi;
	jobs.closing!true;
	

	if
	:: 0 != -2 && size-1 != -3 -> 
				for(i : 0.. size-1) {
			for302347: skip;
			

			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			for30_end2347: skip
		};
		for30_exit2347: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: results.async_rcv?0;
			:: results.sync?0;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi
stop_process:skip
}

proctype go_probeWorker(Chandef jobs;Chandef results) {
	bool closed; 
	int i;
	bool state;
	do
	:: jobs.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: jobs.async_rcv?0;
			:: jobs.sync?0;
			fi;
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!0 -> 
					results.sending?0
				fi
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
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


