
// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example656402055/pkg/resource/deploy/source_query.go
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
	Chandef src_providerRegErrChan;
	Chandef src_langPluginFinChan;
	chan child_deploynewQueryResourceMonitor0 = [0] of {int};
	Chandef providerRegErrChan;
	int num_msgs = 0;
	bool state = false;
	int i;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(providerRegErrChan);
	run deploynewQueryResourceMonitor(providerRegErrChan,child_deploynewQueryResourceMonitor0);
	child_deploynewQueryResourceMonitor0?0;
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	run sync_monitor(src_langPluginFinChan);
	run sync_monitor(src_providerRegErrChan);
	goto stop_process
stop_process:skip
}

proctype deploynewQueryResourceMonitor(Chandef providerRegErrChan;chan child) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	Chandef d_requests;
	Chandef providerRegChan;
	Chandef cancel;
	run sync_monitor(cancel);
	run sync_monitor(providerRegChan);
	run sync_monitor(d_requests);
	run go_Anonymous1(cancel,providerRegChan,providerRegErrChan);
	

	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	goto stop_process;
	stop_process: skip;
	child!0
}
proctype go_Anonymous1(Chandef cancel;Chandef providerRegChan;Chandef providerRegErrChan) {
	bool closed; 
	int i;
	bool state;
	int num_msgs;
	do
	:: true -> 
		

		if
		:: providerRegChan.async_rcv?state,num_msgs;
		:: providerRegChan.sync?state,num_msgs;
		fi;
		

		if
		:: state && num_msgs <= 0 -> 
			break
		:: else -> 
			for10: skip;
			

			if
			:: true -> 
				

				if
				:: providerRegErrChan.async_send!0;
				:: providerRegErrChan.sync!false,0 -> 
					providerRegErrChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			

			if
			:: true -> 
				

				if
				:: providerRegErrChan.async_send!0;
				:: providerRegErrChan.sync!false,0 -> 
					providerRegErrChan.sending?state
				fi;
				goto stop_process
			:: true;
			fi;
			for10_end: skip
		fi
	od;
	for10_exit: skip;
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

