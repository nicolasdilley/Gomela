#define hessianConcurrent_evals  3
#define hessianConcurrent_nWorkers  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example570632772/diff/fd/hessian.go
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
	Wgdef workerWG;
	Wgdef originWG;
	Chandef ans;
	Chandef send;
	int num_msgs = 0;
	bool state = false;
	int i;
	int nWorkers = hessianConcurrent_nWorkers;
	int evals = hessianConcurrent_evals;
	

	if
	:: evals > 0 -> 
		send.size = evals;
		run AsyncChan(send)
	:: else -> 
		run sync_monitor(send)
	fi;
	

	if
	:: evals > 0 -> 
		ans.size = evals;
		run AsyncChan(ans)
	:: else -> 
		run sync_monitor(ans)
	fi;
	run wgMonitor(originWG);
	

	if
	:: true -> 
		originWG.Add!1
	:: true;
	fi;
	run wgMonitor(workerWG);
		for(i : 0.. nWorkers-1) {
		for10: skip;
		workerWG.Add!1;
		run go_Anonymous0(send,ans,originWG,workerWG);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous1(send,ans,originWG,workerWG);
	do
	:: true -> 
		

		if
		:: ans.async_rcv?state,num_msgs;
		:: ans.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for30: skip;
			for30_end: skip
		fi
	od;
	for30_exit: skip
stop_process:skip
}

proctype go_Anonymous0(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: send.async_rcv?state,num_msgs;
		:: send.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			

			if
			:: true -> 
				originWG.Wait?0
			fi;
			

			if
			:: ans.async_send!0;
			:: ans.sync!false,0 -> 
				ans.sending?state
			fi;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	stop_process: skip;
	workerWG.Add!-1
}
proctype go_Anonymous1(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int stencil = -2;
	int i = -2;
	int n = -2;
	

	if
	:: 0 != -2 && n-1 != -3 -> 
				for(i : 0.. n-1) {
			for201473: skip;
			

			if
			:: i != -2 && n-1 != -3 -> 
								for(i : i.. n-1) {
					for2114721473: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for2214721473: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for2314721473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end14721473: skip
								};
								for23_exit14721473: skip
							:: else -> 
								do
								:: true -> 
									for23147014721473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end147014721473: skip
								:: true -> 
									break
								od;
								for23_exit147014721473: skip
							fi;
							for22_end14721473: skip
						};
						for22_exit14721473: skip
					:: else -> 
						do
						:: true -> 
							for22147114721473: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23147114721473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end147114721473: skip
								};
								for23_exit147114721473: skip
							:: else -> 
								do
								:: true -> 
									for231470147114721473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end1470147114721473: skip
								:: true -> 
									break
								od;
								for23_exit1470147114721473: skip
							fi;
							for22_end147114721473: skip
						:: true -> 
							break
						od;
						for22_exit147114721473: skip
					fi;
					for21_end14721473: skip
				};
				for21_exit14721473: skip
			:: else -> 
				do
				:: true -> 
					for211473: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for221473: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for231473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end1473: skip
								};
								for23_exit1473: skip
							:: else -> 
								do
								:: true -> 
									for2314701473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end14701473: skip
								:: true -> 
									break
								od;
								for23_exit14701473: skip
							fi;
							for22_end1473: skip
						};
						for22_exit1473: skip
					:: else -> 
						do
						:: true -> 
							for2214711473: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for2314711473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end14711473: skip
								};
								for23_exit14711473: skip
							:: else -> 
								do
								:: true -> 
									for23147014711473: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end147014711473: skip
								:: true -> 
									break
								od;
								for23_exit147014711473: skip
							fi;
							for22_end14711473: skip
						:: true -> 
							break
						od;
						for22_exit14711473: skip
					fi;
					for21_end1473: skip
				:: true -> 
					break
				od;
				for21_exit1473: skip
			fi;
			for20_end1473: skip
		};
		for20_exit1473: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: i != -2 && n-1 != -3 -> 
								for(i : i.. n-1) {
					for211472: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for221472: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for231472: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end1472: skip
								};
								for23_exit1472: skip
							:: else -> 
								do
								:: true -> 
									for2314701472: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end14701472: skip
								:: true -> 
									break
								od;
								for23_exit14701472: skip
							fi;
							for22_end1472: skip
						};
						for22_exit1472: skip
					:: else -> 
						do
						:: true -> 
							for2214711472: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for2314711472: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end14711472: skip
								};
								for23_exit14711472: skip
							:: else -> 
								do
								:: true -> 
									for23147014711472: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end147014711472: skip
								:: true -> 
									break
								od;
								for23_exit147014711472: skip
							fi;
							for22_end14711472: skip
						:: true -> 
							break
						od;
						for22_exit14711472: skip
					fi;
					for21_end1472: skip
				};
				for21_exit1472: skip
			:: else -> 
				do
				:: true -> 
					for21: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end: skip
								};
								for23_exit: skip
							:: else -> 
								do
								:: true -> 
									for231470: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end1470: skip
								:: true -> 
									break
								od;
								for23_exit1470: skip
							fi;
							for22_end: skip
						};
						for22_exit: skip
					:: else -> 
						do
						:: true -> 
							for221471: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for231471: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end1471: skip
								};
								for23_exit1471: skip
							:: else -> 
								do
								:: true -> 
									for2314701471: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end14701471: skip
								:: true -> 
									break
								od;
								for23_exit14701471: skip
							fi;
							for22_end1471: skip
						:: true -> 
							break
						od;
						for22_exit1471: skip
					fi;
					for21_end: skip
				:: true -> 
					break
				od;
				for21_exit: skip
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	send.closing!true;
	workerWG.Wait?0;
	ans.closing!true;
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

