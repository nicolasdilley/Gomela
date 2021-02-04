#define ProbePodToPodConnectivity_size  0
#define ProbePodToPodConnectivity_numberOfWorkers  1

// https://github.com/kubernetes/kubernetes/blob/d70ee902fddc682863a3cc4f0d8eac0223ebf70b/test/e2e/network/netpol/probe.go#L44
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



init { 
	Chandef results;
	Chandef jobs;
	int num_msgs = 0;
	bool state = false;
	int i;
	int allPods=1;
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
					:: jobs.sync!false,0 -> 
						jobs.sending?state
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for21788: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!false,0 -> 
						jobs.sending?state
					fi;
					for21_end788: skip
				:: true -> 
					break
				od;
				for21_exit788: skip
			fi;
			for20_end: skip
		};
		for20_exit: skip
	:: else -> 
		do
		:: true -> 
			for20789: skip;
			

			if
			:: allPods-1 != -3 -> 
								for(i : 0.. allPods-1) {
					for21789: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!false,0 -> 
						jobs.sending?state
					fi;
					for21_end789: skip
				};
				for21_exit789: skip
			:: else -> 
				do
				:: true -> 
					for21788789: skip;
					

					if
					:: jobs.async_send!0;
					:: jobs.sync!false,0 -> 
						jobs.sending?state
					fi;
					for21_end788789: skip
				:: true -> 
					break
				od;
				for21_exit788789: skip
			fi;
			for20_end789: skip
		:: true -> 
			break
		od;
		for20_exit789: skip
	fi;
	jobs.closing!true;
	

	if
	:: 0 != -2 && size-1 != -3 -> 
				for(i : 0.. size-1) {
			for30790: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			for30_end790: skip
		};
		for30_exit790: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
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
	int num_msgs;
	do
	:: true -> 
		

		if
		:: jobs.async_rcv?state,num_msgs;
		:: jobs.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!false,0 -> 
					results.sending?state
				fi
			:: true -> 
				

				if
				:: results.async_send!0;
				:: results.sync!false,0 -> 
					results.sending?state
				fi
			fi;
			for11_end: skip
		fi
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


