#define crossLaplacianConcurrent_evals  0
#define crossLaplacianConcurrent_nWorkers  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example570632772/diff/fd/crosslaplacian.go
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
	int nWorkers = crossLaplacianConcurrent_nWorkers;
	int evals = crossLaplacianConcurrent_evals;
	

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
	for30_exit: skip;
	goto stop_process
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
	int stencil=0;
	int n=1;
	

	if
	:: 0 != -2 && n-1 != -3 -> 
				for(i : 0.. n-1) {
			for201465: skip;
			

			if
			:: stencil-1 != -3 -> 
								for(i : 0.. stencil-1) {
					for211465: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for221465: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end1465: skip
						};
						for22_exit1465: skip
					:: else -> 
						do
						:: true -> 
							for2214631465: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end14631465: skip
						:: true -> 
							break
						od;
						for22_exit14631465: skip
					fi;
					for21_end1465: skip
				};
				for21_exit1465: skip
			:: else -> 
				do
				:: true -> 
					for2114641465: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for2214641465: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end14641465: skip
						};
						for22_exit14641465: skip
					:: else -> 
						do
						:: true -> 
							for22146314641465: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end146314641465: skip
						:: true -> 
							break
						od;
						for22_exit146314641465: skip
					fi;
					for21_end14641465: skip
				:: true -> 
					break
				od;
				for21_exit14641465: skip
			fi;
			for20_end1465: skip
		};
		for20_exit1465: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: stencil-1 != -3 -> 
								for(i : 0.. stencil-1) {
					for21: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end: skip
						};
						for22_exit: skip
					:: else -> 
						do
						:: true -> 
							for221463: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end1463: skip
						:: true -> 
							break
						od;
						for22_exit1463: skip
					fi;
					for21_end: skip
				};
				for21_exit: skip
			:: else -> 
				do
				:: true -> 
					for211464: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for221464: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end1464: skip
						};
						for22_exit1464: skip
					:: else -> 
						do
						:: true -> 
							for2214631464: skip;
							

							if
							:: send.async_send!0;
							:: send.sync!false,0 -> 
								send.sending?state
							fi;
							for22_end14631464: skip
						:: true -> 
							break
						od;
						for22_exit14631464: skip
					fi;
					for21_end1464: skip
				:: true -> 
					break
				od;
				for21_exit1464: skip
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


