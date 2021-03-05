#define InitDatabaseFromFreezer_runtime_NumCPU4539  3
#define InitDatabaseFromFreezer_runtime_NumCPU5018  1

// https://github.com/jpmorganchase/quorum/blob/7b726385216c44e55fc6b6191a022fe598c102d4/core/rawdb/freezer_reinit.go#L36
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
	run go_InitDatabaseFromFreezer()
stop_process:skip
}

proctype go_InitDatabaseFromFreezer() {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef abort;
	Chandef results;
	int uint648611=0;
	int frozen=1;
	int runtime_NumCPU5018 = InitDatabaseFromFreezer_runtime_NumCPU5018;
	int runtime_NumCPU4539 = InitDatabaseFromFreezer_runtime_NumCPU4539;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 4 * runtime_NumCPU4539 > 0 -> 
		results.size = 4 * runtime_NumCPU4539;
		run AsyncChan(results)
	:: else -> 
		run sync_monitor(results)
	fi;
	run sync_monitor(abort);
		for(i : 0.. runtime_NumCPU5018-1) {
		for10: skip;
		run go_Anonymous1(results,abort);
		for10_end: skip
	};
	for10_exit: skip;
	

	if
	:: uint648611 != -2 && frozen-1 != -3 -> 
				for(i : uint648611.. frozen-1) {
			for23: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for23_end: skip
		};
		for23_exit: skip
	:: else -> 
		do
		:: true -> 
			for20: skip;
			

			if
			:: results.async_rcv?state,num_msgs;
			:: results.sync?state,num_msgs;
			fi;
			

			if
			:: true -> 
				goto stop_process
			:: true;
			fi;
			for20_end: skip
		:: true -> 
			break
		od;
		for20_exit: skip
	fi;
	goto stop_process;
	stop_process: skip;
		abort.closing!true
}
proctype go_Anonymous1(Chandef results;Chandef abort) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for11: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: results.async_send!0 -> 
			break
		:: results.sync!false,0 -> 
			results.sending?state;
			break
		:: abort.async_rcv?state,num_msgs -> 
			goto stop_process
		:: abort.sync?state,num_msgs -> 
			goto stop_process
		od;
		for11_end: skip
	od;
	for11_exit: skip;
	stop_process: skip
}
proctype go_Anonymous2(Chandef results;Chandef abort) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		for18: skip;
		

		if
		:: true -> 
			goto stop_process
		:: true;
		fi;
		do
		:: results.async_send!0 -> 
			break
		:: results.sync!false,0 -> 
			results.sending?state;
			break
		:: abort.async_rcv?state,num_msgs -> 
			goto stop_process
		:: abort.sync?state,num_msgs -> 
			goto stop_process
		od;
		for18_end: skip
	od;
	for18_exit: skip;
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


