#define ub_for364_0  -2

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example873101154/aws/credentials/processcreds/provider.go
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
	Chandef execCh;
	Chandef stdoutCh;
	int num_msgs = 0;
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
			for10956: skip;
			do
			:: stdoutCh.async_rcv?state,num_msgs -> 
				break
			:: stdoutCh.sync?state,num_msgs -> 
				break
			:: execCh.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: execCh.sync?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: true -> 
				goto stop_process
			od;
			for10_end956: skip
		};
		for10_exit956: skip
	:: else -> 
		do
		:: true -> 
			for10: skip;
			do
			:: stdoutCh.async_rcv?state,num_msgs -> 
				break
			:: stdoutCh.sync?state,num_msgs -> 
				break
			:: execCh.async_rcv?state,num_msgs -> 
				

				if
				:: true -> 
					goto stop_process
				:: true;
				fi;
				break
			:: execCh.sync?state,num_msgs -> 
				

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
	int num_msgs;
	

	if
	:: read.async_send!0;
	:: read.sync!false,0 -> 
		read.sending?state
	fi;
	stop_process: skip
}
proctype go_executeCommand(Chandef exec) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	

	if
	:: exec.async_send!0;
	:: exec.sync!false,0 -> 
		exec.sending?state
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

