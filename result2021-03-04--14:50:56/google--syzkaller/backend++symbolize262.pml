#define symbolize_procs  3
#define ub_for299_0  -2

// https://github.com/google/syzkaller/blob/63631df1539816bc62c7be40779c5f3e23b23b2f/pkg/cover/backend/elf.go#L262
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
	run go_symbolize()
stop_process:skip
}

proctype go_symbolize() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef pcchan;
	Chandef symbolizerC;
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
		run go_Anonymous1(symbolizerC,pcchan);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: 0 != -2 && ub_for299_0 != -2 -> 
				for(i : 0.. ub_for299_0) {
			for21: skip;
			

			if
			:: pcchan.async_send!0;
			:: pcchan.sync!false,0 -> 
				pcchan.sending?state
			fi;
			for21_end: skip
		};
		for21_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: pcchan.async_send!0;
			:: pcchan.sync!false,0 -> 
				pcchan.sending?state
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	pcchan.closing!true;
	

	if
	:: 0 != -2 && procs-1 != -3 -> 
				for(i : 0.. procs-1) {
			for33: skip;
			

			if
			:: symbolizerC.async_rcv?state,num_msgs;
			:: symbolizerC.sync?state,num_msgs;
			fi;
			for33_end: skip
		};
		for33_exit: skip
	:: else -> 
		do
		:: true -> 
			for30: skip;
			

			if
			:: symbolizerC.async_rcv?state,num_msgs;
			:: symbolizerC.sync?state,num_msgs;
			fi;
			for30_end: skip
		:: true -> 
			break
		od;
		for30_exit: skip
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip
}
proctype go_Anonymous1(Chandef symbolizerC;Chandef pcchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: pcchan.async_rcv?state,num_msgs;
		:: pcchan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for11: skip;
			for11_end: skip
		fi
	od;
	for11_exit: skip;
	

	if
	:: symbolizerC.async_send!0;
	:: symbolizerC.sync!false,0 -> 
		symbolizerC.sending?state
	fi;
	stop_process: skip;
	
}
proctype go_Anonymous2(Chandef symbolizerC;Chandef pcchan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: pcchan.async_rcv?state,num_msgs;
		:: pcchan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for14: skip;
			for14_end: skip
		fi
	od;
	for14_exit: skip;
	

	if
	:: symbolizerC.async_send!0;
	:: symbolizerC.sync!false,0 -> 
		symbolizerC.sending?state
	fi;
	stop_process: skip;
	
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

