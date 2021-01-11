#define ub_for364_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example378112969/aws/credentials/processcreds/provider.go
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
	Chandef execCh;
	Chandef stdoutCh;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	

	if
	:: 1 > 0 -> 
		stdoutCh.size = 1;
		run AsyncChan(stdoutCh)
	:: else -> 
		run sync_monitor(stdoutCh)
	fi;
	run go_readInput(stdoutCh);
	

	if
	:: 1 > 0 -> 
		execCh.size = 1;
		run AsyncChan(execCh)
	:: else -> 
		run sync_monitor(execCh)
	fi;
	run go_executeCommand(execCh);
	

	if
	:: 0 != -2 && ub_for364_0 != -2 -> 
				for(i : 0.. ub_for364_0) {
			for10715: skip;
			do
			:: stdoutCh.async_rcv?0 -> 
				break
			:: stdoutCh.sync?0 -> 
				break
			:: execCh.async_rcv?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: execCh.sync?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for10_end715: skip
		};
		for10_exit715: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: stdoutCh.async_rcv?0 -> 
				break
			:: stdoutCh.sync?0 -> 
				break
			:: execCh.async_rcv?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: execCh.sync?0 -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for10_end: skip
		:: true -> 
			break
		od;
		for10_exit: skip
	fi;
	goto stop_process
stop_process:skip
}

proctype go_readInput(Chandef read) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: read.async_send!0;
	:: read.sync!0 -> 
		read.sending?0
	fi;
	stop_process: skip
}
proctype go_executeCommand(Chandef exec) {
	bool closed; 
	int i;
	bool state;
	

	if
	:: exec.async_send!0;
	:: exec.sync!0 -> 
		exec.sending?0
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

