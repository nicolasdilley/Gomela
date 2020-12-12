#define Gradient_evals  ??
#define Gradient_nWorkers  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example306907566/diff/fd/gradient.go
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
	int nWorkers = Gradient_nWorkers;
	Chandef quit;
	Chandef sendChan;
	int formula_Stencil = -2;
	bool state = false;
	Chandef ansChan;
	int xcopy = -2;
	int evals = Gradient_evals;
	int i;
	
	if
	:: true -> 
				for(i : 0.. xcopy-1) {
for10:						for(i : 0.. formula_Stencil-1) {
for11:
			}
		};
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
for20_exit:	run Anonymous1(sendChan,ansChan,quit);
for50_exit:	goto stop_process;
	quit.closing!true
stop_process:}

proctype Anonymous0(Chandef sendChan;Chandef ansChan;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for21:		do
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
		od
	od;
for21_exit:stop_process:
}
proctype Anonymous1(Chandef sendChan;Chandef ansChan;Chandef quit) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		do
		:: true -> 
for31:			
			if
			:: true -> 
				
				if
				:: ansChan.async_send!0;
				:: ansChan.sync!0 -> 
					ansChan.sending?0
				fi
			:: true;
			fi;
			
			if
			:: sendChan.async_send!0;
			:: sendChan.sync!0 -> 
				sendChan.sending?0
			fi
		:: true -> 
			break
		od
	:: true -> 
		break
	od;
stop_process:
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

