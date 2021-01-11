#define Gradient_evals  0
#define Gradient_nWorkers  1

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example291430900/diff/fd/gradient.go
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
	Chandef quit;
	Chandef ansChan;
	Chandef sendChan;
	bool state = false;
	int i;
	int nWorkers = Gradient_nWorkers;
	int evals = Gradient_evals;
	int formula_Stencil=3;
	

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
	goto stop_process;
	quit.closing!true
stop_process:skip
}

proctype go_Anonymous0(Chandef sendChan;Chandef ansChan;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
		for21: skip;
		do
		:: quit.async_rcv?0 -> 
			goto stop_process
		:: quit.sync?0 -> 
			goto stop_process
		:: sendChan.async_rcv?0 -> 
			

			if
			:: ansChan.async_send!0;
			:: ansChan.sync!0 -> 
				ansChan.sending?0
			fi;
			break
		:: sendChan.sync?0 -> 
			

			if
			:: ansChan.async_send!0;
			:: ansChan.sync!0 -> 
				ansChan.sending?0
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
	int x=3;
	

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
						:: ansChan.sync!0 -> 
							ansChan.sending?0
						fi;
						goto for31_end
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!0 -> 
						sendChan.sending?0
					fi;
					for31_end: skip
				};
				for31_exit: skip
			:: else -> 
				do
				:: true -> 
					for311449: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!0 -> 
							ansChan.sending?0
						fi;
						goto for31_end1449
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!0 -> 
						sendChan.sending?0
					fi;
					for31_end1449: skip
				:: true -> 
					break
				od;
				for31_exit1449: skip
			fi;
			for30_end: skip
		};
		for30_exit: skip
	:: else -> 
		do
		:: true -> 
			for301450: skip;
			

			if
			:: formula_Stencil-1 != -3 -> 
								for(i : 0.. formula_Stencil-1) {
					for311450: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!0 -> 
							ansChan.sending?0
						fi;
						goto for31_end1450
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!0 -> 
						sendChan.sending?0
					fi;
					for31_end1450: skip
				};
				for31_exit1450: skip
			:: else -> 
				do
				:: true -> 
					for3114491450: skip;
					

					if
					:: true -> 
						

						if
						:: ansChan.async_send!0;
						:: ansChan.sync!0 -> 
							ansChan.sending?0
						fi;
						goto for31_end14491450
					:: true;
					fi;
					

					if
					:: sendChan.async_send!0;
					:: sendChan.sync!0 -> 
						sendChan.sending?0
					fi;
					for31_end14491450: skip
				:: true -> 
					break
				od;
				for31_exit14491450: skip
			fi;
			for30_end1450: skip
		:: true -> 
			break
		od;
		for30_exit1450: skip
	fi;
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


