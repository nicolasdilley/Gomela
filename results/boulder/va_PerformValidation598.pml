#define PerformValidation_remoteVACount  ??
#define PerformValidation_rand_Perm38620  ??

// /var/folders/28/gltwgskn4998yb1_d73qtg8h0000gn/T/clone-example511113049/va/va.go
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
	int remoteVACount = PerformValidation_remoteVACount;
	bool state = false;
	int i;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		Chandef remoteResults;
		
		if
		:: remoteVACount > 0 -> 
			remoteResults.size = remoteVACount;
			run AsyncChan(remoteResults)
		:: else -> 
			run sync_monitor(remoteResults)
		fi;
		run go_performRemoteValidation(remoteResults)
	:: true;
	fi;
	
	if
	:: true -> 
		goto stop_process
	:: true;
	fi;
	
	if
	:: true -> 
		
		if
		:: true -> 
			
			if
			:: true -> 
				run Anonymous1(remoteResults)
			:: true -> 
				
				if
				:: true -> 
					chan child_processRemoteResults0 = [0] of {int};
					run processRemoteResults(remoteResults,child_processRemoteResults0);
					child_processRemoteResults0?0
				:: true;
				fi
			fi
		fi
	fi;
	goto stop_process
stop_process:}

proctype go_performRemoteValidation(Chandef results) {
	bool closed; 
	int i;
	bool state;
	int rand_Perm38620 = PerformValidation_rand_Perm38620;
stop_process:
}
proctype Anonymous1(Chandef remoteResults) {
	bool closed; 
	int i;
	bool state;
	chan child_processRemoteResults0 = [0] of {int};
	run processRemoteResults(remoteResults,child_processRemoteResults0);
	child_processRemoteResults0?0;
stop_process:
}
proctype processRemoteResults(Chandef remoteResultsChan;chan child) {
	bool closed; 
	int i;
	bool state;
	do
	:: true -> 
for30:		
		if
		:: true -> 
			
			if
			:: true -> 
				goto stop_process
			:: true -> 
				
				if
				:: true -> 
					goto stop_process
				:: true;
				fi
			fi
		:: true;
		fi;
		
		if
		:: true -> 
			break
		:: true;
		fi
	:: true -> 
		break
	od;
	
	if
	:: true -> 
		goto stop_process
	:: true -> 
		
		if
		:: true -> 
			goto stop_process
		:: true;
		fi
	fi;
	goto stop_process;
stop_process:	child!0
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

