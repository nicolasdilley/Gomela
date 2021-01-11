#define symbolize_procs  3
#define ub_for299_1  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example675888632/pkg/cover/backend/elf.go
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
	Chandef pcchan;
	Chandef symbolizerC;
	bool state = false;
	int i;
	int procs = symbolize_procs;
	

	if
	:: procs > 0 -> 
		symbolizerC.size = procs;
		run AsyncChan(symbolizerC)
	:: else -> 
		run sync_monitor(symbolizerC)
	fi;
	

	if
	:: procs > 0 -> 
		pcchan.size = procs;
		run AsyncChan(pcchan)
	:: else -> 
		run sync_monitor(pcchan)
	fi;
		for(i : 0.. procs-1) {
		for10: skip;
		run go_Anonymous0(symbolizerC,pcchan);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && ub_for299_1 != -2 -> 
				for(i : 0.. ub_for299_1) {
			for201545: skip;
			

			if
			:: pcchan.async_send!0;
			:: pcchan.sync!0 -> 
				pcchan.sending?0
			fi;
			for20_end1545: skip
		};
		for20_exit1545: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: pcchan.async_send!0;
			:: pcchan.sync!0 -> 
				pcchan.sending?0
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	pcchan.closing!true;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process
stop_process:skip
}

proctype go_Anonymous0(Chandef symbolizerC;Chandef pcchan) {
	bool closed; 
	int i;
	bool state;
	do
	:: pcchan.is_closed?state -> 
		if
		:: state -> 
			break
		:: else -> 
			

			if
			:: pcchan.async_rcv?0;
			:: pcchan.sync?0;
			fi;
			for11: skip;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	

	if
	:: symbolizerC.async_send!0;
	:: symbolizerC.sync!0 -> 
		symbolizerC.sending?0
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

