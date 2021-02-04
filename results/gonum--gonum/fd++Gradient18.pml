#define Gradient_evals  0
#define Gradient_nWorkers  1

// https://github.com/gonum/gonum/blob/090a5d652c892e8d5460a07eca1c1ddf480b04d9/diff/fd/gradient.go#L18
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
	Chandef quit;
	Chandef ansChan;
	Chandef sendChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	int nWorkers = Gradient_nWorkers;
	int evals = Gradient_evals;
	int formula_Stencil=0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: evals > 0 -> 
		sendChan.size = evals;
		run AsyncChan(sendChan)
	:: else -> 
		run sync_monitor(sendChan)
	fi;
	

	if
	:: evals > 0 -> 
		ansChan.size = evals;
		run AsyncChan(ansChan)
	:: else -> 
		run sync_monitor(ansChan)
	fi;
	run sync_monitor(quit);
		for(i : 0.. nWorkers-1) {
		for20: skip;
		run go_Anonymous0(sendChan,ansChan,quit);
		for20_end: skip
	};
	for20_exit: skip;
	run go_Anonymous1(sendChan,ansChan,quit,formula_Stencil);
	

	if
	:: 0 != -2 && evals-1 != -3 -> 
				for(i : 0.. evals-1) {
			for50365: skip;
			

			if
			:: ansChan.async_rcv?state,num_msgs;
			:: ansChan.sync?state,num_msgs;
			fi;
			for50_end365: skip
		};
		for50_exit365: skip
	:: else -> 
		do
		:: true -> 
			for50: skip;
			

			if
			:: ansChan.async_rcv?state,num_msgs;
			:: ansChan.sync?state,num_msgs;
			fi;
			for50_end: skip
		:: true -> 
			break
		od;
		for50_exit: skip
	fi;
	goto stop_process;
	quit.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef sendChan;Chandef ansChan;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for21: skip;
		do
		:: quit.async_rcv?state,num_msgs -> 
			goto stop_process
		:: quit.sync?state,num_msgs -> 
			goto stop_process
		:: sendChan.async_rcv?state,num_msgs -> 
			

			if
			:: ansChan.async_send!0;
			:: ansChan.sync!false,0 -> 
				ansChan.sending?state
			fi;
			break
		:: sendChan.sync?state,num_msgs -> 
			

			if
			:: ansChan.async_send!0;
			:: ansChan.sync!false,0 -> 
				ansChan.sending?state
			fi;
			break
		od;
		for21_end: skip
	od;
	for21_exit: skip;
	stop_process: skip
}
proctype go_Anonymous1(Chandef sendChan;Chandef ansChan;Chandef quit;int formula_Stencil) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	int x=1;
	

	if
	:: x-1 != -3 -> 
				for(i : 0.. x-1) {
			for30: skip;
			

			if
			:: formula_Stencil-1 != -3 -> 
								for(i : 0.. formula_Stencil-1) {
					for31: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!false,0 -> 
							ansChan.sending?state
						fi;
						goto for31_end
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!false,0 -> 
						sendChan.sending?state
					fi;
					for31_end: skip
				};
				for31_exit: skip
			:: else -> 
				do
				:: true -> 
					for31363: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!false,0 -> 
							ansChan.sending?state
						fi;
						goto for31_end363
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!false,0 -> 
						sendChan.sending?state
					fi;
					for31_end363: skip
				:: true -> 
					break
				od;
				for31_exit363: skip
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for30364: skip;
			

			if
			:: formula_Stencil-1 != -3 -> 
								for(i : 0.. formula_Stencil-1) {
					for31364: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!false,0 -> 
							ansChan.sending?state
						fi;
						goto for31_end364
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!false,0 -> 
						sendChan.sending?state
					fi;
					for31_end364: skip
				};
				for31_exit364: skip
			:: else -> 
				do
				:: true -> 
					for31363364: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!false,0 -> 
							ansChan.sending?state
						fi;
						goto for31_end363364
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!false,0 -> 
						sendChan.sending?state
					fi;
					for31_end363364: skip
				:: true -> 
					break
				od;
				for31_exit363364: skip
			fi;
			for30_end364: skip
		:: true -> 
			break
		od;
		for30_exit364: skip
	fi;
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


