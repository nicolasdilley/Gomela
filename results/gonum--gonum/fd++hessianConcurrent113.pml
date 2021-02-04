#define hessianConcurrent_evals  1
#define hessianConcurrent_nWorkers  1

// https://github.com/gonum/gonum/blob/090a5d652c892e8d5460a07eca1c1ddf480b04d9/diff/fd/hessian.go#L113
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
		originWG.Add!1;
		run go_Anonymous0(send,ans,originWG)
	:: true;
	fi;
	run wgMonitor(workerWG);
		for(i : 0.. nWorkers-1) {
		for10: skip;
		workerWG.Add!1;
		run go_Anonymous1(send,ans,originWG,workerWG);
		for10_end: skip
	};
	for10_exit: skip;
	run go_Anonymous2(send,ans,originWG,workerWG);
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

proctype go_Anonymous0(Chandef send;Chandef ans;Wgdef originWG) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	stop_process: skip;
	originWG.Add!-1
}
proctype go_Anonymous1(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
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
proctype go_Anonymous2(Chandef send;Chandef ans;Wgdef originWG;Wgdef workerWG) {
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
			for20369: skip;
			

			if
			:: i != -2 && n-1 != -3 -> 
								for(i : i.. n-1) {
					for21368369: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22368369: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23368369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end368369: skip
								};
								for23_exit368369: skip
							:: else -> 
								do
								:: true -> 
									for23366368369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366368369: skip
								:: true -> 
									break
								od;
								for23_exit366368369: skip
							fi;
							for22_end368369: skip
						};
						for22_exit368369: skip
					:: else -> 
						do
						:: true -> 
							for22367368369: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23367368369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end367368369: skip
								};
								for23_exit367368369: skip
							:: else -> 
								do
								:: true -> 
									for23366367368369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366367368369: skip
								:: true -> 
									break
								od;
								for23_exit366367368369: skip
							fi;
							for22_end367368369: skip
						:: true -> 
							break
						od;
						for22_exit367368369: skip
					fi;
					for21_end368369: skip
				};
				for21_exit368369: skip
			:: else -> 
				do
				:: true -> 
					for21369: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22369: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end369: skip
								};
								for23_exit369: skip
							:: else -> 
								do
								:: true -> 
									for23366369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366369: skip
								:: true -> 
									break
								od;
								for23_exit366369: skip
							fi;
							for22_end369: skip
						};
						for22_exit369: skip
					:: else -> 
						do
						:: true -> 
							for22367369: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23367369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end367369: skip
								};
								for23_exit367369: skip
							:: else -> 
								do
								:: true -> 
									for23366367369: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366367369: skip
								:: true -> 
									break
								od;
								for23_exit366367369: skip
							fi;
							for22_end367369: skip
						:: true -> 
							break
						od;
						for22_exit367369: skip
					fi;
					for21_end369: skip
				:: true -> 
					break
				od;
				for21_exit369: skip
			fi;
			for20_end369: skip
		};
		for20_exit369: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: i != -2 && n-1 != -3 -> 
								for(i : i.. n-1) {
					for21368: skip;
					

					if
					:: stencil-1 != -3 -> 
												for(i : 0.. stencil-1) {
							for22368: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23368: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end368: skip
								};
								for23_exit368: skip
							:: else -> 
								do
								:: true -> 
									for23366368: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366368: skip
								:: true -> 
									break
								od;
								for23_exit366368: skip
							fi;
							for22_end368: skip
						};
						for22_exit368: skip
					:: else -> 
						do
						:: true -> 
							for22367368: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23367368: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end367368: skip
								};
								for23_exit367368: skip
							:: else -> 
								do
								:: true -> 
									for23366367368: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366367368: skip
								:: true -> 
									break
								od;
								for23_exit366367368: skip
							fi;
							for22_end367368: skip
						:: true -> 
							break
						od;
						for22_exit367368: skip
					fi;
					for21_end368: skip
				};
				for21_exit368: skip
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
									for23366: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366: skip
								:: true -> 
									break
								od;
								for23_exit366: skip
							fi;
							for22_end: skip
						};
						for22_exit: skip
					:: else -> 
						do
						:: true -> 
							for22367: skip;
							

							if
							:: stencil-1 != -3 -> 
																for(i : 0.. stencil-1) {
									for23367: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end367: skip
								};
								for23_exit367: skip
							:: else -> 
								do
								:: true -> 
									for23366367: skip;
									

									if
									:: send.async_send!0;
									:: send.sync!false,0 -> 
										send.sending?state
									fi;
									for23_end366367: skip
								:: true -> 
									break
								od;
								for23_exit366367: skip
							fi;
							for22_end367: skip
						:: true -> 
							break
						od;
						for22_exit367: skip
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

